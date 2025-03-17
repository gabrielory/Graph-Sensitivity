︠a4bf629e-2bd7-4cec-ab3b-740c7bf7d712s︠
attach('../OneVarGraphFamily.sage')
attach('../10_graphs_of_small_order.sage')

graph_dict = {
    1: "K2",
    2: "K3",
    3: "P3",
    4: "K4",
    5: "Diamond",
    6: "Paw",
    7: "C4",
    8: "K1,3",
    9: "P4",
    10: "K5"
}

# gets all needed choices of a distinguished vertex up to symmetry
def select_vertices(graph):

    selected_degrees = []
    selected_vertices = []

    for vertex in graph.vertices():
        degree = graph.degree(vertex)
        if degree not in selected_degrees:
            selected_vertices.append(vertex)
            selected_degrees.append(degree)

    return selected_vertices

# defines a class representing an unnamed graph that inherits from GraphFamily
class UnnamedGraphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "Corollary 5-4 Graphs - H = Pn, H' ="
        self.min_n = 4
        self.out_dir = "../../out/Corollary Results 5-4/"

    # returns unnamed graphs with the current values for n and m
    def graph(self, graphDetails, H2):

        n = graphDetails.n

        H1 = graphs.PathGraph(n)

        list_of_graphs = []

        # make a list of all the possible graphs considering the different rooted vertices
        for h1_root in select_vertices(H1):
            for h2_root in select_vertices(H2):

                graph = H1.copy()
                H2_copy = H2.copy()

                # fix vertex labels
                old_vertices = graph.vertices()
                vertex_map = dict()
                for vertex in H2.vertices():
                    vertex_map[vertex] = vertex + len(old_vertices)

                H2_copy.relabel(vertex_map)

                graph.add_vertices(H2_copy.vertices())
                graph.add_edges(H2_copy.edges())

                h2_root_relabeled = vertex_map[h2_root]

                for neighbor in graph.neighbors(h2_root_relabeled):
                    graph.add_edge(h1_root, neighbor)
                graph.delete_vertex(h2_root_relabeled)

                #print(f"n = {n}")
                #graph.show()

                list_of_graphs.append(graph)

        return list_of_graphs

    # prints or returns a table of graph information with values of n from min_n to max_n using graphs
    def table(self, max_n, H2, min_s = 0, print_table = false):

        t = [self.table_columns]

        for n in range(self.min_n, max_n + 1):

            gd = self.GraphDetails(n = n)
            graphs = self.graph(gd, H2)

            for graph in graphs:

                self.GraphDetails.graph = graph
                alpha = self.get_alpha(gd)
                sigma = self.get_sensitivity(gd)
                deg = self.max_degree(graph) if graph.order() > 0 else 0
                row = [n, graph.order(), graph.size(), deg, alpha, sigma]

                if sigma >= min_s:
                    t.append(row)

        if print_table:
            print(self.name)
            print(table(t))
            print("\n\n")
        else:
            return t

    # prints or returns a table of graph information with values of n from min_n to max_n using formulas
    def table_by_formulas(self, max_n, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, max_n + 1):

            alpha = "not finished"
            sigma = "not finished"
            deg =  "not finished"

            row = [n_value, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t

    # returns the adjacency matrices for n = lower to n = upper
    def get_matrices(self, lower, upper):

        matrices = []

        for count in range(lower, upper + 1):

            gd = self.GraphDetails(n = count)
            graphs = self.graph(gd)

            for graph in graphs:
                matrices.append([count, graph.adjacency_matrix()])

        return matrices


    # returns a table of graph information with values of n from min_n to n and adjacency matrices using graphs (less operations than calling both seperately)
    def table_and_matrices(self, max_n, H2, lower = 6, upper = 8, min_s = 0):

        t = [self.table_columns]
        matrices = []
        eigenvalues = []
        eigenvectors = []

        # set a threshold for tiny imaginary parts
        threshold = 1e-10

        for n_value in range(self.min_n, max_n + 1):

            gd = self.GraphDetails(n = n_value)
            graphs = self.graph(gd, H2)

            for graph in graphs:
                gd.graph = graph
                alpha = self.get_alpha(gd)
                sigma = self.get_sensitivity(gd)
                deg = self.max_degree(graph) if graph.order() > 0 else 0
                row = [n_value, graph.order(), graph.size(), deg, alpha, sigma]

                if sigma >= min_s:
                    t.append(row)


                if ((n_value >= lower and n_value <= upper)):
                    matrices.append([n_value, graph.adjacency_matrix()])

                    eigenvalue, eigenvector =  np.linalg.eig(np.array(graph.adjacency_matrix()))

                    eigenvalue = np.where(np.abs(eigenvalue.imag) < threshold, eigenvalue.real, eigenvalue)
                    eigenvector = [np.where(np.abs(element.imag) < threshold, element.real, element) for element in eigenvector]

                    eigenvalues.append(eigenvalue)
                    eigenvectors.append(eigenvector)


        return [t, matrices, eigenvalues, eigenvectors]

    # write the table for n = min_n to n = max_n and some adjacency matrices to an output file
    def output_results(self, max_n, H2_number, show_eigenvectors = False, lower = 6, upper = 8, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + min_s_str + " " + graph_dict[H2_number] +".txt", 'w')

       
        matrices = []
        eigenvalues = []
        eigenvectors = []

        H2 = get_h2(H2_number)

        f.write("Tables using graphs: \n")
        t_m = self.table_and_matrices(max_n, H2, lower, upper)

        t = t_m[0]
        matrices = t_m[1]
        eigenvalues = t_m[2]
        eigenvectors = t_m[3]

        f.write(str(table(t)))

        f.write("\n\nTable using formulas: \n")
        t2 = self.table_by_formulas(max_n)
        f.write(str(table(t2)))

        f.write("\n\nAdjacency matrices: \n")

        for element in range(len(matrices)):

             if (len(matrices[element]) != 0):

                f.write("n = ")
                f.write(str(matrices[element][0]))
                f.write("\n")
                f.write(str(matrices[element][1]))
                f.write("\n")

                f.write("\nEigenvalues: ")

                combined = list(zip(eigenvalues[element], eigenvectors[element]))

                # sort the combined list by the eigenvalues values
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

        print(self.name + " " + graph_dict[H2_number] + " Results done")

        return


for h2_number in range(1,11):
    graph = UnnamedGraphs()
    graph.output_results(10, h2_number, True)
︡f45cd86e-469a-404b-8cb4-198597c17fdf︡{"stdout":"Corollary 5-4 Graphs - H = Pn, H' = K2 Results done\nCorollary 5-4 Graphs - H = Pn, H' = K3 Results done\nCorollary 5-4 Graphs - H = Pn, H' = P3 Results done"}︡{"stdout":"\nCorollary 5-4 Graphs - H = Pn, H' = K4 Results done\nCorollary 5-4 Graphs - H = Pn, H' = Diamond Results done"}︡{"stdout":"\nCorollary 5-4 Graphs - H = Pn, H' = Paw Results done"}︡{"stdout":"\nCorollary 5-4 Graphs - H = Pn, H' = C4 Results done\nCorollary 5-4 Graphs - H = Pn, H' = K1,3 Results done"}︡{"stdout":"\nCorollary 5-4 Graphs - H = Pn, H' = P4 Results done\nCorollary 5-4 Graphs - H = Pn, H' = K5 Results done"}︡{"stdout":"\n"}︡{"done":true}









