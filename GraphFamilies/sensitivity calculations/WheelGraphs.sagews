︠1b579cd8-2d26-4c86-9b17-41733354b2c0s︠
attach('../OneVarGraphFamily.sage')

# defines a class representing wheel graphs that inherits from OneVarGraphFamily
class WheelGraphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "WheelGraphs"
        self.min_n = 3

    # returns a fan graph with the current n
    def graph(self, graphDetails):
        
        n = graphDetails.n
        k1 = graphs.CompleteGraph(1)
        
        wheel_graph = k1.join(graphs.CycleGraph(n))
        # wheel_graph.show()
        
        graphDetails.graph = wheel_graph
        
        return wheel_graph
        
    # prints or returns a table of graph information with values of n from 3 to n using formulas
    def table_by_formulas(self, max_n, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, max_n + 1): 
            
            alpha = math.floor(n_value/2)
            sigma = 1 if n_value != 4 else 2
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
wg = WheelGraphs()
wg.output_results(10, True)
︡84d249cf-e955-433b-9f71-d9662314dbef︡{"stdout":"WheelGraphsResults done\n"}︡{"done":true}









