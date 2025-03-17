︠33350c17-ecaa-44e5-96ba-8b8009b42b0c︠
attach('../nHGraphFamily.sage')
from tabulate import tabulate

# defines a class representing nH for H = Kℓ that inherits from nHGraphFamily
class nCrownGraphs(nHGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "nCrownGraphs"
        self.min_l = 2

    # prints or returns a table of graph information with values of n from 1 to n using formulas
    def table_by_formulas(self, max_n, l, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, max_n + 1):

            alpha = "not finished"
            sigma = "not finished"
            deg = "not finished"

            row = [n_value, l, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t

    # write the table for n = min_n to n = max_n to an output file
    def output_results(self, max_n, max_l, show_eigenvectors = False, lower_n = 5, upper_n = 7, lower_l = 5, upper_l = 7, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + min_s_str + ".txt", 'w')

        matrices = []
        eigenvalues = []
        eigenvectors = []

        f.write("Tables using graphs: \n")
        for l in range(self.min_l, max_l + 1):

            # make crown graph
            kn = graphs.CompleteGraph(l)
            k2 = graphs.CompleteGraph(2)
            crown = kn.tensor_product(k2)
            
            t_m = self.table_and_matrices(max_n, l, crown, lower_n, upper_n, lower_l, upper_l, min_s)
            t = t_m[0]
            matrices.append(t_m[1])
            eigenvalues.append(t_m[2])
            eigenvectors.append(t_m[3])

            f.write(str(table(t)))
            f.write("\n\n")

        f.write("\nTables using formulas: \n")
        for l in range(self.min_l, max_l + 1):
            
            t2 = self.table_by_formulas(max_n, l)
            f.write(str(table(t2)))
            f.write("\n\n")

        f.write("\nAdjacency matrices: \n")

        for index in range(len(matrices)):
            for element in range(len(matrices[index])):

                if len(matrices[index][element]) != 0:

                    f.write("n = ")
                    f.write(str(matrices[index][element][0]))
                    f.write("\nl = ")
                    f.write(str(matrices[index][element][1]))
                    f.write("\n")
                    f.write(str(matrices[index][element][2]))

                    f.write("\n\nEigenvalues: ")

                    combined = list(zip(eigenvalues[index][element], eigenvectors[index][element]))

                    # sort the combined list by eigenvalues
                    sorted_combined = sorted(combined, key=lambda x: x[0])

                    # unzip the combined list back into two lists
                    sorted_eigenvalues, sorted_eigenvectors = zip(*sorted_combined)

                    count = 1
                    for eigenvalue in sorted_eigenvalues:
                        f.write("\n" + str(count) + ": ")
                        f.write(str(eigenvalue))
                        count += 1
                    f.write("\n")

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

        print(self.name + "Results done")
        
    def ksensitivity(self, n, l):
        
        t = [['n','l','k', 'alpha', 'k-sensitivity']]
        gd = self.GraphDetails(n = n)
        
        # make crown graph
        kn = graphs.CompleteGraph(l)
        k2 = graphs.CompleteGraph(2)
        crown = kn.tensor_product(k2)
            
        graph = self.graph(gd, crown)
        alpha = self.get_alpha(gd)
            
        for k in range(1, graph.order() - alpha + 1):
            ksens = self.get_ksensitivity(k, gd)
            row = [n, l, k, alpha, ksens]
            t.append(row)
            
        return t
        
    # write the square tables for k-sensitivity to an output file
    def display_table(self, max_n, max_l):
        with open(self.out_dir + self.name + "KSensitivityTables" + ".txt", 'w') as f:
            f.write("Tables using graphs:\n")

            for n in range(self.min_n, max_n + 1):
                f.write(f"n = {n}\n")

                l_col = list(range(self.min_l, max_l + 1))
                k_values_set = set()
                ksens_data = {}

                for l in l_col:
                    t = self.ksensitivity(n, l)
                    ksensitivity = [t[row + 1][4] for row in range(len(t) - 1)]
                    k_values = [t[row + 1][2] for row in range(len(t) - 1)]
                    k_values_set.update(k_values)

                    for i, k in enumerate(k_values):
                        if k not in ksens_data:
                            ksens_data[k] = {}
                        ksens_data[k][l] = ksensitivity[i]

                k_values_list = sorted(k_values_set)

                # prepare k_row
                k_row = [[k_val for _ in range(len(l_col))] for k_val in k_values_list]

                # prepare header
                header = [
                    ["", "k"] + [str(k) for k in k_values_list],
                    ["l", ""] + ["" for _ in k_values_list],
                ]

                # prepare rows
                rows = []
                for l in l_col:
                    row = [l, ""] + [ksens_data[k].get(l, None) for k in k_values_list]
                    rows.append(row)

                # combine the header and rows to create the table
                table_data = header + rows

                # write the table to the file
                f.write(tabulate(table_data, headers="firstrow", tablefmt="grid"))
                f.write("\n\n")

        print(self.name + "KSensitivityTablesDone")
        return
    
    
    # write the tables for k-sensitivity to an output file
    def output_ksensitivity(self, max_n, max_l):
           
        f = open(self.out_dir + self.name + "KSensitivityResults" + ".txt", 'w')
        
        for n_value in range(self.min_n, max_n + 1):
            for l in range(self.min_l, max_l + 1):
                
                t = [['n','l','k', 'alpha', 'k-sensitivity']]
                gd = self.GraphDetails(n = n_value)
                
                
                # make crown graph
                kn = graphs.CompleteGraph(l)
                k2 = graphs.CompleteGraph(2)
                crown = kn.tensor_product(k2)
                
                graph = self.graph(gd, crown)
                alpha = self.get_alpha(gd)
            
                for k in range(1, graph.order() - alpha + 1):
                    ksens = self.get_ksensitivity(k, gd)
                    row = [n_value, l, k, alpha, ksens]
                    t.append(row)
                
                f.write(str(table(t)))
                f.write("\n\n")
            
        f.close
        
        print(self.name + "KSensitivityResultsDone")
        return


# run code
g = nCrownGraphs()
# g.output_results(1,10)
g.output_ksensitivity(1,9)
︡3238229a-7209-4f59-85e9-bd17baf2cba2︡{"stdout":"nCrownGraphsKSensitivityResultsDone"}︡{"stdout":"\n"}︡{"done":true}









