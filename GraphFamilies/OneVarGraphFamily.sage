attach('../GraphFamily.sage')

class OneVarGraphFamily(GraphFamily):
    def __init__(self, min_n = 2 ):
        super().__init__()
        self.table_columns = ["n", "|V|", "|E|", "deg", "alpha", "sigma"]
        self.table_columns_2 = ["n", "deg", "alpha", "sigma"]
       
        # defines a class to store the details of the graph (n, graph, alpha)
        class GraphDetails(GraphFamily.GraphDetails):
            def __init__(self, n = None, graph = None, alpha = None):
                super().__init__(n = n, graph = graph, alpha = alpha)

    
    # prints or returns a table of graph information with values of n from min_n to max_n using graphs
    def table(self, max_n, min_s = 0, print_table = false):
        
        t = [self.table_columns]
        
        for n in range(self.min_n, max_n + 1):
            gd = self.GraphDetails(n = n)
            graph = self.graph(gd)
            alpha = self.get_alpha(gd)
            sigma = self.get_sensitivity(gd)
            deg = self.max_degree(graph) if graph.order() > 0 else 0
            row = [n, graph.order(), graph.size(), deg, alpha, sigma]
            if sigma >= min_s:
                t.append(row)

        if print_table:
            print(self.name)
            print(table(t))
            print("\n\n")
        else:
            return t
        
    # returns the adjacency matrices for n = lower to n = upper
    def get_matrices(self, lower, upper):
        
        matrices = []
        
        for count in range(lower, upper + 1): 
            
            gd = self.GraphDetails(n = count)
            graph = self.graph(gd)
   
            matrices.append([count, graph.adjacency_matrix()])
            
        return matrices
    
    
    # returns a table of graph information with values of n from min_n to n and adjacency matrices using graphs (less operations than calling both seperately)
    def table_and_matrices(self, max_n, lower = 6, upper = 8, min_s = 0):

        t = [self.table_columns]
        matrices = []
        eigenvalues = []
        eigenvectors = []
        
        # set a threshold for tiny imaginary parts
        threshold = 1e-10
        
        for n_value in range(self.min_n, max_n + 1):
            
            gd = self.GraphDetails(n = n_value)
            graph = self.graph(gd)
            alpha = self.get_alpha(gd)
            sigma = self.get_sensitivity(gd)
            deg = self.max_degree(graph) if graph.order() > 0 else 0
            row = [n_value, graph.order(), graph.size(), deg, alpha, sigma]
            if sigma >= min_s:
                t.append(row)
             
            if ((n_value >= lower and n_value <= upper)):
                matrices.append([n_value, graph.adjacency_matrix()])
                
                eigenvalue, eigenvector =  np.linalg.eig(np.array(graph.adjacency_matrix()))
              
                eigenvalue = np.where(np.abs(eigenvalue.imag) < threshold, eigenvalue.real, eigenvalue)
                eigenvector = [np.where(np.abs(element.imag) < threshold, element.real, element) for element in eigenvector]
                
                eigenvalues.append(eigenvalue)
                eigenvectors.append(eigenvector)
                
                
        return [t, matrices, eigenvalues, eigenvectors]
    
    # write the table for n = min_n to n = max_n and some adjacency matrices to an output file
    def output_results(self, max_n, show_eigenvectors = False, lower = 6, upper = 8, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + min_s_str + ".txt", 'w')
        
        try:
            f.write(f"Notation = {self.notation}\n\n")
        except:
            pass
        
        matrices = [] 
        eigenvalues = []
        eigenvectors = []
        
        f.write("Tables using graphs: \n")
        t_m = self.table_and_matrices(max_n, lower, upper)
            
        t = t_m[0]
        matrices = t_m[1]
        eigenvalues = t_m[2]
        eigenvectors = t_m[3]
                      
        f.write(str(table(t)))
                   
        f.write("\n\nTable using formulas: \n")
        t2 = self.table_by_formulas(max_n)
        f.write(str(table(t2)))
          
        f.write("\n\nAdjacency matrices: \n")
        
        for element in range(len(matrices)):
            
             if (len(matrices[element]) != 0):
                    
                f.write("n = ")
                f.write(str(matrices[element][0]))
                f.write("\n")
                f.write(str(matrices[element][1]))
                f.write("\n")
                
                f.write("\nEigenvalues: ")
            
                combined = list(zip(eigenvalues[element], eigenvectors[element]))

                # sort the combined list by the eigenvalues values
                sorted_combined = sorted(combined, key=lambda x: x[0])

                # unzip the combined list back into two lists
                sorted_eigenvalues, sorted_eigenvectors = zip(*sorted_combined)

                count = 1
                for eigenvalue in sorted_eigenvalues:
                    f.write("\n" + str(count) + ": ")
                    f.write(str(eigenvalue))
                    count += 1
                f.write("\n")
                
                if show_eigenvectors:
                    f.write("\nEigenvectors: ")
                    count = 1
                    for eigenvector in sorted_eigenvectors:
                        f.write("\n" + str(count) + ": ")
                        f.write(str(eigenvector))
                        count += 1
                    f.write("\n")
       
                f.write("\n")
        f.close()

        print(self.name + "Results done")
        
        return 