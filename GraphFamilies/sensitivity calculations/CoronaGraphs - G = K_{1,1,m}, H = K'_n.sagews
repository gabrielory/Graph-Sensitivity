︠eb1b7272-4c10-493f-9d55-a71fb7585fa4s︠
attach('../GraphFamily.sage')
attach('../corona_product.sage')
from tabulate import tabulate

# defines a class representing K_{1,1,m} ⊙ K'_n graphs that inherits from GraphFamily
class CoronaGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "CoronaGraphs - G = K_{1,1,m}, H = K'_n"
        self.notation = "K_{1,1,m} ⊙ K'_n "
        self.out_dir = "../../out/Corona Graphs/"
        self.min_n = 1
        self.min_m = 1


    # returns a P_m ⊙ K_n graph with the current values for n and m
    def graph(self, graphDetails):

        m = graphDetails.m
        n = graphDetails.n

        star = graphs.StarGraph(m) 
        thagomizer = star.join(graphs.CompleteGraph(1))
        thagomizer.relabel(range(thagomizer.num_verts()))

        empty = graphs.EmptyGraph()
        for v in range(n):
            empty.add_vertex()

        corona = corona_product(thagomizer, empty)
        #corona.show()

        graphDetails.graph = corona

        #print(f"n = {n}")
        #print(f"m = {m}")

        return corona


    # prints or returns a table of graph information with values of n from min_n to n using formulas
    def table_by_formulas(self, n, m, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, n + 1):

            alpha = n_value*(m+2)
            sigma = n_value
            deg = n_value+m+1

            row = [n_value, m, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(n))
            print(table(t))
            print("\n\n")
        else:
            return t

    # write an alternate table to an output file
    def sensitivity_output_table(self, max_n = 10, max_m = 10, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + "SensitivityResults" + min_s_str + ".txt", 'w')

        m_row = []
        n_col = []
        sensitivity = []

        f.write(f"Notation: {self.notation}\n\n")

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


# run the code
graph = CoronaGraphs()
graph.output_results(5,5, True, 4, 5, 4, 5)
#graph.sensitivity_output_table()
︡49ee873f-cf2d-40d7-bc42-f4226e4bb3a9︡{"stdout":"CoronaGraphs - G = K_{1,1,m}, H = K'_nResults done"}︡{"stdout":"\n"}︡{"done":true}









