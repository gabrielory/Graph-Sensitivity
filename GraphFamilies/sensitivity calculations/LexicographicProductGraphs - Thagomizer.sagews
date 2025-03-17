︠449668fb-d3e8-4601-93a7-a582199446f6s︠
attach('../GraphFamily.sage')
from tabulate import tabulate

# defines a class representing Km[K_[1,1,n]] graphs that inherits from GraphFamily
class LexicographicProductGraphsThagomizer(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "LexicographicProductGraphs - Thagomizer"
        self.min_n = 1
        self.min_m = 1

    # returns a Km[K_[1,1,n]] graph with the current values for n and m
    def graph(self, graphDetails):

        m = graphDetails.m
        n = graphDetails.n

        # create the Km graph
        km = graphs.CompleteGraph(m)

        # create the thagomizer graph
        star = graphs.StarGraph(n) # k1 join k'n
        thagomizer = star.join(graphs.CompleteGraph(1))

        # create the lexicographic product graph
        graph = km.lexicographic_product(thagomizer)

        graphDetails.graph = graph
        #graph.show()

        return graph

    # prints or returns a table of graph information with values of n from 1 to n using formulas
    def table_by_formulas(self, n, m, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, n + 1):

            alpha = n_value
            sigma = min(n_value, math.ceil((n_value+1)/2))
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
graph = LexicographicProductGraphsThagomizer()
graph.output_results(5,5, True,3,4,3,4)
#graph.sensitivity_output_table()
︡a2c9fbb2-19bd-45d1-9e63-365970888f2a︡{"stdout":"LexicographicProductGraphs - ThagomizerResults done"}︡{"stdout":"\n"}︡{"done":true}









