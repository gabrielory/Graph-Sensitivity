︠7f6a6c0d-3b9e-40f4-ba31-b6a8c1db6c3as︠
attach('../GraphFamily.sage')
from tabulate import tabulate

# defines a class representing Km[Cn x K2] graphs that inherits from GraphFamily
class LexicographicProductGraphsCnxK2(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "LexicographicProductGraphs - Cn x K2"
        self.min_n = 3
        self.min_m = 1

    # returns a Km[Cn x K2] graph with the current values for n and m
    def graph(self, graphDetails):

        m = graphDetails.m
        n = graphDetails.n

        # create the Km graph
        complete = graphs.CompleteGraph(m)

        # create the Cn×K2 graph
        cycle = graphs.CycleGraph(n)
        complete2 = graphs.CompleteGraph(2)
        cnxk2 = cycle.tensor_product(complete2)

        # create the lexicographic product graph
        graph = complete.lexicographic_product(cnxk2)

        graphDetails.graph = graph
        #graph.show()

        return graph

    # prints or returns a table of graph information with values of n from 2 to n using formulas
    def table_by_formulas(self, n, m, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, n + 1):

            alpha = n_value

            alpha_h = math.ceil(n_value/2)*2
            sigma_h = 2 if n_value == 4 else 1

            sigma = min(sigma_h, math.ceil((alpha_h+1)/2))

            deg = "not finished"

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
        f = open(self.out_dir + self.name + " SensitivityResults" + min_s_str + ".txt", 'w')

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


# run the code
graph = LexicographicProductGraphsCnxK2()
graph.output_results(10, 10, True)
#graph.sensitivity_output_table()
︡9e879d4a-32f6-4f43-8064-de59a8a66698︡{"stdout":"LexicographicProductGraphs - Cn x K2Results done"}︡{"stdout":"\n"}︡{"done":true}









