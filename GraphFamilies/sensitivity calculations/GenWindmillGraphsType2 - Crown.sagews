︠de66c8a7-c447-4119-bb92-7aee07a45261s︠
attach('../TypeIIGeneralizedWindmillGraphFamily.sage')
from tabulate import tabulate

def get_crown(l_value):

    # make crown graph
    kn = graphs.CompleteGraph(l_value)
    k2 = graphs.CompleteGraph(2)
    crown = kn.tensor_product(k2)

    #create a dictionary to map tuple vertices to unique integers
    tuple_to_int = {}
    next_int = 0

    # function to get an integer for a tuple vertex
    def get_vertex_int(vertex):
        nonlocal next_int
        if vertex not in tuple_to_int:
            tuple_to_int[vertex] = next_int
            next_int += 1
        return tuple_to_int[vertex]

    # create the vertex map for relabeling
    vertex_map = {vertex: get_vertex_int(vertex) for vertex in crown.vertices()}

    # relabel the vertices
    crown.relabel(vertex_map, inplace=True)

    return crown

# defines a class representing K′m ∨nH for H = K_l ∨ K_2 that inherits from TypeIIGeneralizedWindmillGraphFamily
class GenWindmillIIGraphsCrown(TypeIIGeneralizedWindmillGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "GenWindmillGraphsType2 - Crown"
        self.min_l = 2

    # prints or returns a table of graph information for the given values of m,l from min_n to max_n using formulas
    def table_by_formulas(self, max_n, m, l, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, max_n + 1):

            nalphah = n_value*l
            alpha = max(m, nalphah)

            if m <= nalphah:

                h_sensitivity = math.floor(l/2)

                if m <= math.floor((nalphah+1)/2):
                    sigma = min(h_sensitivity, nalphah + 1 - m)
                else:
                    sigma = min(h_sensitivity, math.ceil((nalphah+1)/2))

            else:
                sigma = "X"

            deg_h = l - 1
            deg = max(n_value*l, m + deg_h)

            row = [n_value, m, l, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t

    # prints or returns a table of graph information for the given values of n,l from min_l to max_l using formulas
    def alternate_table_by_formulas(self, n, m, max_l, print_table = False):

        t = [self.table_columns_2]

        for l_value in range(self.min_l, max_l + 1):

            nalphah = n*l_value
            alpha = max(m, nalphah)

            if m <= nalphah:

                h_sensitivity = math.floor(l_value/2)

                if m <= math.floor((nalphah+1)/2):
                    sigma = min(h_sensitivity, nalphah + 1 - m)
                else:
                    sigma = min(h_sensitivity, math.ceil((nalphah+1)/2))

            else:
                sigma = "X"

            deg_h = l_value - 1
            deg = max(n*l_value, m + deg_h)

            row = [n, m, l_value, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t
        
    # prints or returns a table of graph information for the given values of n,m from min_l to max_l using graphs
    def alternate_table(self, n, m, max_l, min_s = 0, print_table = False):


        t = [["n", "m", "l", "alpha", "sigma"]]

        for l_value in range(self.min_l, max_l + 1):

            gd = self.GraphDetails(n=n, m=m)
            crown = get_crown(l_value)
            graph = self.graph(gd, crown)
            alpha = self.get_alpha(gd)

            if m <= n*l_value: # m <= n * independence number of crown graph
                sigma = self.get_sensitivity(gd)
            else:
                sigma = "X"

            row = [n, m, l_value, alpha, sigma]

            if sigma == "X" or sigma >= min_s:
                t.append(row)

        if print_table:
            print(self.name + ", n = " + str(n))
            print(table(t))
            print("\n\n")
        else:
            return t

    # write output as successive square tables of options for ℓ × m as n increases downward
    def display_lxm(self, max_n = 5, max_m = 5, max_l = 5, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + " Sensitivity Results lxm" + min_s_str + ".txt", 'w')

        f.write("Tables using graphs:\n")
        for n in range(self.min_n, max_n + 1):

            f.write("n = ")
            f.write(str(n))
            f.write("\n")

            m_row = []
            l_col = []
            sensitivity = []

            for m in range(self.min_m, max_m + 1):
                m_row.append(m)

                t = self.alternate_table(n, m, max_l, min_s)
                sensitivity.append([t[row + 1][4] for row in range(len(t) - 1)])

            for l in range(self.min_l, max_l + 1):
                l_col.append(l)

            # create the header
            header = [

            ["", "m"] + [f"{element}" for element in m_row],
            ["l", ""] + ["" for element in m_row],
            ]

            # create rows
            rows = []
            for i in range(len(l_col)):
                row = [l_col[i], ""] + [element[i] for element in sensitivity]
                rows.append(row)

            # combine the header and rows
            table_data = header + rows

            f.write(tabulate(table_data, tablefmt="grid"))
            f.write("\n\n")

        f.write("Tables using formulas:\n")
        for n in range(self.min_n, max_n + 1):

            f.write("n = ")
            f.write(str(n))
            f.write("\n")

            m_row = []
            l_col = []
            sensitivity = []

            for m in range(self.min_m, max_m + 1):
                m_row.append(m)

                t = self.alternate_table_by_formulas(n, m, max_l, min_s)
                sensitivity.append([t[row + 1][5] for row in range(len(t) - 1)])
            
            for l in range(self.min_l, max_l + 1):
                l_col.append(l)

            # create the header
            header = [

            ["", "m"] + [f"{element}" for element in m_row],
            ["l", ""] + ["" for element in m_row],
            ]

            # create rows
            rows = []
            for i in range(len(l_col)):
                row = [l_col[i], ""] + [element[i] for element in sensitivity]
                rows.append(row)

            # combine the header and rows
            table_data = header + rows

            f.write(tabulate(table_data, tablefmt="grid"))
            f.write("\n\n")

        f.close()
        print(self.name + " Sensitivity Results lxm done")

        return

    # write output as successive square tables of options for ℓ × n as m increases downward
    def display_lxn(self, max_n = 5, max_m = 5, max_l = 5, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + " Sensitivity Results lxn" + min_s_str + ".txt", 'w')

        f.write("Tables using graphs:\n")
        for m in range(self.min_m, max_m + 1):

            f.write("m = ")
            f.write(str(m))
            f.write("\n")

            n_row = []
            l_col = []
            sensitivity = []

            for n in range(self.min_n, max_n + 1):
                n_row.append(n)

                t = self.alternate_table(n, m, max_l, min_s)
                sensitivity.append([t[row + 1][4] for row in range(len(t) - 1)])

            for l in range(self.min_l, max_l + 1):
                l_col.append(l)

            # create the header
            header = [

            ["", "n"] + [f"{element}" for element in n_row],
            ["l", ""] + ["" for element in n_row],
            ]

            # create rows
            rows = []
            for i in range(len(l_col)):
                row = [l_col[i], ""] + [element[i] for element in sensitivity]
                rows.append(row)

            # combine the header and rows
            table_data = header + rows

            f.write(tabulate(table_data, tablefmt="grid"))
            f.write("\n\n")

        f.write("Tables using formulas:\n")
        for m in range(self.min_m, max_m + 1):

            f.write("m = ")
            f.write(str(m))
            f.write("\n")

            n_row = []
            l_col = []
            sensitivity = []

            for n in range(self.min_n, max_n + 1):
                n_row.append(n)
                
                t = self.alternate_table_by_formulas(n, m, max_l, min_s)
                sensitivity.append([t[row + 1][5] for row in range(len(t) - 1)])

            for l in range(self.min_l, max_l + 1):
                l_col.append(l)

            # create the header
            header = [

            ["", "n"] + [f"{element}" for element in n_row],
            ["l", ""] + ["" for element in n_row],
            ]

            # create rows
            rows = []
            for i in range(len(l_col)):
                row = [l_col[i], ""] + [element[i] for element in sensitivity]
                rows.append(row)

            # combine the header and rows
            table_data = header + rows

            f.write(tabulate(table_data, tablefmt="grid"))
            f.write("\n\n")

        f.close()
        print(self.name + " Sensitivity Results lxn done")

        return

    # write the table for n = min_n to n = max_n to an output file
    def output_results(self, max_n, max_m, max_l, show_eigenvectors = False, lower_n = 2, upper_n = 4, lower_m = 2, upper_m = 4, lower_l = 2, upper_l = 4, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + min_s_str + ".txt", 'w')

        matrices = []
        eigenvalues = []
        eigenvectors = []

        f.write("Tables using graphs: \n")
        for l in range(self.min_l, max_l + 1):
            for m in range(self.min_m, max_m + 1):

                crown = get_crown(l)
                t_m = self.table_and_matrices(max_n, m, l, crown, lower_n, upper_n, lower_m, upper_m, lower_l, upper_l, min_s)
                t = t_m[0]
                matrices.append(t_m[1])
                eigenvalues.append(t_m[2])
                eigenvectors.append(t_m[3])

                f.write(str(table(t)))
                f.write("\n\n")

        f.write("\nTables using formulas: \n")
        for l in range(self.min_l, max_l + 1):
            for m in range(self.min_m, max_m + 1):
                t2 = self.table_by_formulas(max_n, m, l)
                f.write(str(table(t2)))
                f.write("\n\n")

        f.write("\nAdjacency matrices: \n")

        for index in range(len(matrices)):
            for element in range(len(matrices[index])):

                if len(matrices[index][element]) != 0:

                    f.write("n = ")
                    f.write(str(matrices[index][element][0]))
                    f.write("\nm = ")
                    f.write(str(matrices[index][element][1]))
                    f.write("\nl = ")
                    f.write(str(matrices[index][element][2]))
                    f.write("\n")
                    f.write(str(matrices[index][element][3]))

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

        print(self.name + " Results done")


# run code
g = GenWindmillIIGraphsCrown()
g.output_results(3,3,5)
g.display_lxm(3,3,5)
g.display_lxn(3,3,5)
︡28c01653-0f70-4c90-b805-67d78adb8f76︡{"stderr":"Error in lines 258-258\n"}︡{"stderr":"Traceback (most recent call last):\n  File \"/cocalc/lib/python3.11/site-packages/smc_sagews/sage_server.py\", line 1244, in execute\n    exec(\n  File \"\", line 1, in <module>\n  File \"\", line 194, in output_results\n  File \"<string>\", line 111, in table_and_matrices\n  File \"<string>\", line 225, in get_sensitivity\n  File \"<string>\", line 198, in _lowerbound\n  File \"/ext/sage/10.3/src/sage/graphs/generic_graph.py\", line 13896, in subgraph\n    return self._subgraph_by_adding(vertices=vertices, edges=edges,\n           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n  File \"/ext/sage/10.3/src/sage/graphs/generic_graph.py\", line 14007, in _subgraph_by_adding\n    G = self.__class__(weighted=self._weighted, loops=self.allows_loops(),\n        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n  File \"/ext/sage/10.3/src/sage/graphs/graph.py\", line 1063, in __init__\n    self._backend = CGB(0, directed=False)\n                    ^^^^^^^^^^^^^^^^^^^^^^\n  File \"src/cysignals/signals.pyx\", line 341, in cysignals.signals.python_check_interrupt\nKeyboardInterrupt\n"}︡{"done":true}









