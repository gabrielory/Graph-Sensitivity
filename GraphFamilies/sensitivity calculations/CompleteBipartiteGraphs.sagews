︠a8a636ad-457a-46e9-a39b-1537737daf62︠
attach('../GraphFamily.sage')

# defines a class representing complete bipartite graphs that inherits from GraphFamily
class CompleteBipartiteGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "CompleteBipartiteGraphs"
        self.min_n = 1
        self.min_m = 1

    # defines a class to store the details of the graph (n, graph, alpha)
    class GraphDetails(GraphFamily.GraphDetails):
        def __init__(self, n = None, m = None, graph = None, alpha = None):
            super().__init__(n = n, m = m, graph = graph, alpha = alpha)

    # returns a complete bipartite graph with the current values for n and m
    def graph(self, graphDetails):
    
        m = graphDetails.m
        n = graphDetails.n # number of path vertices
    
        empty_m = graphs.EmptyGraph()
        empty_n = graphs.EmptyGraph()

        # make empty_m = K'm
        for i in range(m):
            empty_m.add_vertex()
            
        # make empty_n = K'n
        for i in range(n):
            empty_n.add_vertex()
        
        # join operation
        g = empty_m.join(empty_n)
        
        graphDetails.graph = g
        # g.show()
   
        return g
     
    # prints or returns a table of graph information with values of n from min_n to max_n using formulas
    def table_by_formulas(self, max_n, m, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, max_n + 1):
            
            alpha = max(m, n_value)
            deg =  max(m, n_value)
            
            if (m >= n_value):
                big = m
                small = n_value
            else: 
                big = n_value
                small = m
             
            if (small <= math.floor((big + 1) / 2)):
                sigma = big - small + 1
            else:
                sigma = math.ceil((big + 1) / 2)
            
            row = [n_value, m, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t
    
        
# run the code
ug = CompleteBipartiteGraphs()
ug.output_results(10,10, True)
︡3d1b516a-2f49-4ee3-bebe-512eff89296e︡{"stdout":"CompleteBipartiteGraphsResults done"}︡{"stdout":"\n"}︡{"done":true}









