︠a8a636ad-457a-46e9-a39b-1537737daf62s︠
attach('../GraphFamily.sage')

# defines a class representing dandelion graphs that inherits from GraphFamily
class DandelionGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "DandelionGraphs"
        self.min_n = 2
        self.min_m = 1

    # returns a dandelion graph with the current values for n and m
    def graph(self, graphDetails):
    
        m = graphDetails.m
        n = graphDetails.n # number of path vertices
    
        # create Pn-1
        p = graphs.PathGraph(n-1)

        # create K1
        k1 = graphs.CompleteGraph(1)

        # create an empty graph g with no vertices
        empty = graphs.EmptyGraph()

        # make empty = K'm
        for i in range(m):
            empty.add_vertex()
            
        # make g = K1 v K'm
        g = k1.join(empty)
        g.relabel([element for element in range(m+1)])
        
        g_vertices = g.vertices()
        p_vertices = [v + len(g_vertices) for v in p.vertices()]
        
        # add Pn vertices/edges to g
        g.add_vertices(p_vertices)
        
        # add edges between first vertex in Pn and center of K1 v K'm
        g.add_edge(g_vertices[0], p_vertices[0])
        
        # add path edges
        for v in range(len(p.edges())):
            g.add_edge(p_vertices[v], p_vertices[v+1])
        
        graphDetails.graph = g
        
        # g.show()
   
        return g

        
    # prints or returns a table of graph information with values of n from 2 to n using formulas
    def table_by_formulas(self, n, m, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(1, n + 1):
            
            alpha = m + math.floor(n_value/2)
            sigma = m + 1 if n == 2 else 2 if m == 1 and n == 4 else 1
            deg =  m + 1
            
            row = [n_value, m, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(n))
            print(table(t))
            print("\n\n")
        else:
            return t

        
# run the code
dg = DandelionGraphs()
dg.output_results(10,10, True)
︡aef0b99f-e96e-4bbf-b72b-4027898fd1a4︡{"stdout":"DandelionGraphsResults done"}︡{"stdout":"\n"}︡{"done":true}









