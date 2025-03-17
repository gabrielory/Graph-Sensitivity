︠9e625abb-afda-4632-b74e-e0548b2f93ba︠
attach('../GraphFamily.sage')
from tabulate import tabulate

# rounds the number to the nearest integer if it is within the specified threshold
def round_if_close(number, threshold=1e-10):
    nearest_int = round(number)
    if abs(number - nearest_int) < threshold:
        return nearest_int
    return number

# defines a class representing path networks that inherits from GraphFamily
class PathNetworks(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "PathNetworks"
        self.min_n = 1
        self.min_m = 2

    # returns a path network with the current values for n and m
    def graph(self, graphDetails):

        n = graphDetails.n
        m = graphDetails.m

        # create pm
        path = graphs.PathGraph(m)

        # create k'n
        empty = graphs.EmptyGraph()
        empty.add_vertices(range(n))

        path_network = path.lexicographic_product(empty)

        graphDetails.graph = path_network
        # path_network.show()

        return path_network

    # prints or returns a table of graph information with values of n from 1 to n using formulas
    def table_by_formulas(self, max_n, m, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(1, max_n + 1):

            alpha =  math.ceil(m/2) * n_value
            sigma = "not_finished"
            deg = 2 * n_value

            row = [n_value, m, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t

    # write an alternate table to an output file
    def alternate_display(self, max_n = 10, max_m = 10, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + "SensitivityResults" + min_s_str + ".txt", 'w')

        m_row = []
        n_col = []
        sensitivity = []

        for m in range(self.min_m, max_m + 1):
            m_row.append(m)

            t = self.table(max_n, m, min_s)
            sensitivity.append([t[row + 1][6] for row in range(len(t) - 1)])

        for n in range(self.min_n, max_n + 1):
            n_col.append(n)

        # create the header
        header = [

            ["", "m"] + [f"{element}" for element in m_row],
            ["n", ""] + ["" for element in m_row],
        ]

        # create rows
        rows = []
        for i in range(len(n_col)):
            row = [n_col[i], ""] + [element[i] for element in sensitivity]
            rows.append(row)

        # combine the header and rows
        table_data = header + rows

        f.write(tabulate(table_data, tablefmt="grid"))
        f.close()

        print(self.name + "SensitivityResults done")


    # make an out file with the eigenvalues for the adjacency matrices for n = min_n to max_n
    def get_eigenvalues(self, min_n = 1, max_n = 10, min_m = 2, max_m = 10, show_eigenvectors = False):

        matrices = []
        eigenvalues = []
        eigenvectors = []

        # get adjacency matrices, eigenvalues, and eigenvectors
        for n_value in range(min_n, max_n + 1):
            for m_value in range(min_m, max_m + 1):
                gd = self.GraphDetails(n=n_value, m=m_value)
                graph = self.graph(gd)
                adjacency_matrix = np.array(graph.adjacency_matrix())
                matrices.append([n_value, m_value, adjacency_matrix])
                
                # calculate eigenvalues and eigenvectors
                eigenvalue, eigenvector = np.linalg.eig(adjacency_matrix)

                # handle rounding close to integers
                eigenvalue = np.array([round_if_close(val) for val in eigenvalue])
                eigenvector = np.array([[round_if_close(val) for val in row] for row in eigenvector])

                eigenvalues.append(eigenvalue)
                eigenvectors.append(eigenvector)

        # create and write to the output file
        f = open(self.out_dir + self.name + "Eigenvalues" + ".txt", 'w')
        f.write("Adjacency matrices: \n")

        for element in range(len(matrices)):

            # write adjacency matrices
            f.write("n = ")
            f.write(str(matrices[element][0]))
            f.write("\n")
            f.write("m = ")
            f.write(str(matrices[element][1]))
            f.write("\n")
            f.write(str(matrices[element][2]))
            f.write("\n")

            combined = list(zip(eigenvalues[element], eigenvectors[element]))

            # sort the combined list by the eigenvalues values
            sorted_combined = sorted(combined, key=lambda x: x[0])

            # unzip the combined list back into two lists
            sorted_eigenvalues, sorted_eigenvectors = zip(*sorted_combined)

            # write eigenvalues
            f.write("\nEigenvalues: ")
            count = 1
            for eigenvalue in sorted_eigenvalues:
                f.write("\n" + str(count) + ": ")
                f.write(str(eigenvalue))
                count += 1
            f.write("\n")

            # write eigenvectors
            if show_eigenvectors:
                f.write("\nEigenvectors: ")
                count = 1
                for eigenvector in sorted_eigenvectors:
                    f.write("\n" + str(count) + ": ")
                    f.write(str(eigenvector))
                    count += 1
                f.write("\n")

            f.write("\n")
        f.close()
        print(self.name + "Eigenvalues done")

        return

# run the code
pn = PathNetworks()
#pn.output_results(7,6,True,5,6,5,6)
#pn.alternate_display(7,6)
pn.get_eigenvalues()
︡b475fbb9-d912-408a-8152-dafa3b3fbafe︡{"stdout":"PathNetworksEigenvalues done"}︡{"stdout":"\n"}︡{"done":true}









