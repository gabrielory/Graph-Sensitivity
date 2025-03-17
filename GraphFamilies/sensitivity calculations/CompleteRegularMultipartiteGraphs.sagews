︠0b66d0ce-b480-4cc1-8639-66c061c36b9as︠
attach('../GraphFamily.sage')

# defines a class representing complete regular multipartite graphs that inherits from GraphFamily
class CompleteRegularMultipartiteGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "CompleteRegularMultipartiteGraphs"
        self.min_n = 1
        self.min_m = 3

    # returns a complete regular multipartite graph with the current values for n and m
    def graph(self, graphDetails):
    
        m = graphDetails.m
        n = graphDetails.n
          
        # create a graph with 0 vertices and 0 edges
        crmg = graphs.EmptyGraph()
        
        # make crmg = K'n by adding n vertices to empty
        for i in range(n):
            crmg.add_vertex()
        
        for i in range(m-1):
            
            empty = graphs.EmptyGraph()
            
            # make empty2 = K'n by adding n vertices to empty
            for i in range(n):
                empty.add_vertex()
            
            # offset vertex labels
            vertex_map = dict()
            for vertex in empty.vertices():
                vertex_map[vertex] = vertex + n      
            empty.relabel(vertex_map)
            
            crmg = crmg.join(empty)
             
        # crmg.show()
        
        graphDetails.graph = crmg
        
        return crmg
    
    # prints or returns a table of graph information with values of n from 1 to n using formulas
    def table_by_formulas(self, max_n, m, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, max_n + 1):
            
            alpha = n_value
            sigma = math.ceil((n_value+1)/2)
            deg = (m-1)*n_value
            
            row = [n_value, m, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t
 
        
# run the code
crmg = CompleteRegularMultipartiteGraphs()
crmg.output_results(8, 4, True, 6, 8, 3, 4)
︡05eef9cd-fac6-4668-8540-74f9ba0ca7db︡{"stdout":"CompleteRegularMultipartiteGraphsResults done"}︡{"stdout":"\n"}︡{"done":true}









