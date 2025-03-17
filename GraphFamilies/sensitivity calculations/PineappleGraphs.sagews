︠a8a636ad-457a-46e9-a39b-1537737daf62︠
attach('../GraphFamily.sage')

# defines a class representing pineapple graphs that inherits from GraphFamily
class PineappleGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "PineappleGraphs"
        self.min_n = 1
        self.min_m = 1
        
    # returns a pineapple graph with the current values for n and m
    def graph(self, graphDetails):
    
        m = graphDetails.m
        n = graphDetails.n
    
        # create Km
        km = graphs.CompleteGraph(m)

        # create a graph g with 0 vertices and 0 edges
        g = graphs.EmptyGraph() 

        # make g = K'n by adding n vertices to g
        for i in range(n):
            g.add_vertex()
        
        # get the sets of vertices in km and g
        km_vertices = km.vertices()
        g_vertices = [vertex + len(km_vertices) for vertex in g.vertices()] # adding len(km_vertices) adjusts vertex labels 

        # create a new graph that will include both km and g
        pineapple_graph = Graph()

        # add vertices and edges of km to pineapple_graph
        pineapple_graph.add_vertices(km_vertices)
        pineapple_graph.add_edges(km.edges())

        # add vertices of g to pineapple_graph
        pineapple_graph.add_vertices(g_vertices)

        # add edges between one vertex of km (choosing vertex 0) with every vertex of g
        pineapple_graph.add_edges([(km_vertices[0], v) for v in g_vertices])

        graphDetails.graph = pineapple_graph
        # pineapple_graph.show()
    
        return pineapple_graph

    # prints or returns a table of graph information with values of n from 1 to n using formulas
    def table_by_formulas(self, max_n, m, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, max_n + 1):
            
            alpha = n_value if m == 1 else n_value + 1
            sigma = n_value if m == 1 else n_value + 1 if m == 2 else 1
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
pg = PineappleGraphs()
pg.output_results(10,10, True)









