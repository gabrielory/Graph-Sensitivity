︠aabd7293-0074-4ea4-be92-cd12f875e3dbs︠
attach('../OneVarGraphFamily.sage')

# defines a class representing Pn x K2 graphs that inherits from OneVarGraphFamily
class PnxK2Graphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "Pn x K2 Graphs"
        self.notation = "Pn x K2"
        self.min_n = 2

    # returns a Pn x K2 graph with the current n
    def graph(self, graphDetails):

        n = graphDetails.n

        pn = graphs.PathGraph(n)
        k2 = graphs.CompleteGraph(2)
        pnxk2 = pn.tensor_product(k2)

        graphDetails.graph = pnxk2

        return pnxk2

    # prints or returns a table of graph information with values of n from min_n to n using formulas
    def table_by_formulas(self, max_n, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, max_n + 1):

            alpha = math.ceil(n_value/2)*2
            sigma = 2 if n_value == 3 else 1
            deg = 1 if n_value == 2 else 2

            row = [n_value, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t

        return

# run the code
g = PnxK2Graphs()
g.output_results(10,True)
︡4c3b98bd-22d0-4f42-824f-c614c1c8ab05︡{"stdout":"Pn x K2 GraphsResults done\n"}︡{"done":true}









