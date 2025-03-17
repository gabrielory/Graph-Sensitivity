attach('../GraphFamily.sage')

# defines a class representing type II generalized windmill graphs that inherits from GraphFamily
class TypeIIGeneralizedWindmillGraphFamily(GraphFamily):
    def __init__(self):
        super().__init__()
        self.table_columns = ["n", "m", "l", "|V|", "|E|", "deg", "alpha", "sigma"]
        self.table_columns_2 = ["n", "m", "l", "deg", "alpha", "sigma"]
        self.min_n = 1
        self.min_m = 1
       
    # returns a type II generalized windmill graph with the current values for n and m
    def graph(self, graphDetails, h):

        m = graphDetails.m
        n = graphDetails.n

        # create K'm
        empty = graphs.EmptyGraph()
        
        for i in range(m):
            empty.add_vertex()

        # create nh, which starts as 1h
        nH = h

        # create the rest of nh, so (n-1)h
        for count in range(n-1):
            
            H = h 
            
            # fix vertex labels
            old_vertices = nH.vertices()
            vertex_map = dict()
            for vertex in H.vertices():
                if isinstance(vertex, tuple):
                    print(f"Error: vertex is a tuple: {vertex}")
                else:
                    vertex_map[vertex] = vertex + len(old_vertices)
            H.relabel(vertex_map)

            nH = nH.disjoint_union(H)

        # k'm join nH
        windmill = empty.join(nH)
        #windmill.show()

        graphDetails.graph = windmill

        return windmill


    # prints or returns a table of graph information with values of n from min_n to max_n using graphs
    def table(self, max_n, m, l, h, min_s = 0, print_table = False):

        t = [self.table_columns]
        
        for n_value in range(self.min_n, max_n + 1):
            
            gd = self.GraphDetails(n = n_value, m = m)
            graph = self.graph(gd, h)
            alpha = self.get_alpha(gd)
            sigma = self.get_sensitivity(gd)
            deg = self.max_degree(graph) if graph.order() > 0 else 0
            row = [n_value, m, l, graph.order(), graph.size(), deg, alpha, sigma]
            
            if sigma >= min_s:
                t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t

    # returns the adjacency matrices for n = lower1 to n = upper1 and m = lower2 to m = upper2
    def get_matrices(self, l, h, lower_n = 2, upper_n = 4, lower_m = 2, upper_m = 4, lower_l = 2, upper_l = 4):
        
        matrices = []
        
        for n_value in range(lower_n, upper_n + 1): 
            
            for m_value in range(lower_m, upper_m + 1):
                
                if (l >= lower_l and l <= upper_l):
                    gd = self.GraphDetails(n = n_value, m = m_value)
                    graph = self.graph(gd, h)
               
                    matrices.append([n_value, m_value, l, graph.adjacency_matrix()])
            
        return matrices
    
    # returns a table of graph information with values of n from min_n to max_n and adjacency matrices using graphs (less operations than calling both seperately)
    def table_and_matrices(self, max_n, m, l, h, lower_n = 2, upper_n = 4, lower_m = 2, upper_m = 4, lower_l = 2, upper_l = 4, min_s = 0):

        t = [self.table_columns]
        matrices = []
        eigenvalues = []
        eigenvectors = []
 
        # set a threshold for tiny imaginary parts
        threshold = 1e-10
        
        for n_value in range(self.min_n, max_n + 1):
                
            gd = self.GraphDetails(n = n_value, m = m)
            graph = self.graph(gd, h)
            alpha = self.get_alpha(gd)
            sigma = self.get_sensitivity(gd)
            deg = self.max_degree(graph) if graph.order() > 0 else 0
            row = [n_value, m, l, graph.order(), graph.size(), deg, alpha, sigma]
            if sigma >= min_s:
                t.append(row)
             
            if ((n_value >= lower_n and n_value <= upper_n) and (m >= lower_m and m <= upper_m) and (l >= lower_l and l <= upper_l)):
                
                adj_matrix = graph.adjacency_matrix()
                
                matrices.append([n_value, m, l, adj_matrix])
                
                eigenvalue, eigenvector =  np.linalg.eig(np.array(adj_matrix))
              
                eigenvalue = np.where(np.abs(eigenvalue.imag) < threshold, eigenvalue.real, eigenvalue)
                eigenvector = [np.where(np.abs(element.imag) < threshold, element.real, element) for element in eigenvector]
                
                eigenvalues.append(eigenvalue)
                eigenvectors.append(eigenvector)
                
        return [t, matrices, eigenvalues, eigenvectors]

    @abstractmethod
    def output_results(self): pass
        
    @abstractmethod
    def table_by_formulas(self): pass








