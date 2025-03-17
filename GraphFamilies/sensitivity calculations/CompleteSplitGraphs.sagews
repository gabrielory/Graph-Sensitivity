︠9e625abb-afda-4632-b74e-e0548b2f93bas︠
attach('../GraphFamily.sage')

# defines a class representing complete split graphs that inherits from GraphFamily
class CompleteSplitGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "CompleteSplitGraphs"
        self.min_n = 1
        self.min_m = 1

    # returns a complete split graph with the current values for n and m
    def graph(self, graphDetails):
        
        n = graphDetails.n
        m = graphDetails.m
        
        g = graphs.CompleteGraph(n)
        vertices = g.vertices()
        for i in range(m):
            vertexName = i + n
            g.add_vertex(vertexName)
            g.add_edges([(vertices[j], vertexName) for j in range(n)])
            
        graphDetails.graph = g
        # g.show()
        
        return g
    
    # prints or returns a table of graph information with values of n from 1 to n using formulas
    def table_by_formulas(self, max_n, m, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(1, max_n + 1):
            
            alpha = m
            sigma = m
            deg = n_value + m - 1
            
            row = [n_value, m, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t

        
# run the code
csg = CompleteSplitGraphs()
csg.output_results(10,10, True)
︡40bbca10-63e5-461c-a362-6a2e84ab15aa︡{"stdout":"CompleteSplitGraphsResults done"}︡{"stdout":"\n"}︡{"done":true}









