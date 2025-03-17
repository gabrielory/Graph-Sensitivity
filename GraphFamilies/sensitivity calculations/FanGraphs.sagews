︠2e293414-cb96-40a2-a284-0aeeab37f470s︠
attach('../OneVarGraphFamily.sage')

# defines a class representing fan graphs that inherits from OneVarGraphFamily
class FanGraphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "FanGraphs"
        self.min_n = 2
   
    # returns a fan graph with the current n
    def graph(self, graphDetails):
        
        n = graphDetails.n
        k1 = graphs.CompleteGraph(1)
        
        fan_graph = k1.join(graphs.PathGraph(n))
        # fan_graph.show()
        
        graphDetails.graph = fan_graph
        
        return fan_graph

    # prints or returns a table of graph information with values of n from min_n to max_n using formulas
    def table_by_formulas(self, max_n, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, max_n + 1): 
            
            alpha = math.ceil(n_value/2)
            sigma = 1 if n_value != 3 else 2
            deg = n_value
            
            row = [n_value, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t


# run the code 
fg = FanGraphs()
fg.output_results(10, True)
︡9b964a1b-a87d-4e1e-8ad7-472847467aeb︡{"stdout":"FanGraphsResults done\n"}︡{"done":true}









