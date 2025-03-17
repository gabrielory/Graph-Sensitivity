︠63e929c7-8f51-4dec-8f43-eaaf4ea394a2s︠
attach('../OneVarGraphFamily.sage')
attach('../VTGraphFamily.sage')

# defines a class representing hypercubes that inherits from OneVarGraphFamily and VTGraphFamily
class Hypercubes(OneVarGraphFamily, VTGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "Hypercubes"
        self.min_n = 1

    # returns a balanced hypercube graph with the current n
    def graph(self, graphDetails):
        
        n = graphDetails.n    
        g = graphs.CubeGraph(n)
    
        graphDetails.graph = g
        
        g.show()
        #print(g.edges(sort=True))
    
        return g
    
    # returns the indepencence number
    def alpha(self, graphDetails):
        alpha = graphDetails.graph.order()//2
        graphDetails.alpha = alpha
        return alpha

    # prints or returns a table of graph information with values of n from min_n to max_n using formulas
    def table_by_formulas(self, max_n, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, max_n + 1):

            alpha = "not finished"
            sigma = "not finished"
            deg = "not finished"

            row = [n_value, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t
     
    # make an out file with the eigenvalues for the adjacency matrix for Qn for n = 5, 6, 7, 8.
    def get_eigenvalues(self, min_n = 5, max_n = 8, show_eigenvectors = False):
        
        matrices = []
        eigenvalues = []
        eigenvectors = []
        
        # set a threshold for tiny imaginary parts
        threshold = 1e-10
 
        # get adjacency matrices, eigenvalues, and eigenvectors
        for n_value in range(min_n, max_n + 1):
                gd = self.GraphDetails(n = n_value)
                graph = self.graph(gd)
                matrices.append([n_value, graph.adjacency_matrix()])
                eigenvalue, eigenvector =  np.linalg.eig(np.array(graph.adjacency_matrix()))
                eigenvalue = np.where(np.abs(eigenvalue.imag) < threshold, eigenvalue.real, eigenvalue)
                eigenvector = [np.where(np.abs(element.imag) < threshold, element.real, element) for element in eigenvector]
                eigenvalues.append(eigenvalue)
                eigenvectors.append(eigenvector)
        
        # create and write to the output file
        f = open(self.out_dir + self.name + "Eigenvalues" + ".txt", 'w')
        f.write("Adjacency matrices: \n")

        for element in range(len(matrices)):
            
            # write adjacency matrices
            f.write("n = ")
            f.write(str(matrices[element][0]))
            f.write("\n")
            f.write(str(matrices[element][1]))
            f.write("\n")
                
            combined = list(zip(eigenvalues[element], eigenvectors[element]))
                
            # sort the combined list by the eigenvalues values
            sorted_combined = sorted(combined, key=lambda x: x[0])
                
            # unzip the combined list back into two lists
            sorted_eigenvalues, sorted_eigenvectors = zip(*sorted_combined)

            # write eigenvalues
            f.write("\nEigenvalues: ")
            count = 1
            for eigenvalue in sorted_eigenvalues:
                f.write("\n" + str(count) + ": ")
                f.write(str(eigenvalue))
                count += 1
            f.write("\n")
                
            # write eigenvectors
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
        print(self.name + "Eigenvalues done")
        
        return
        
        
# run the code
h = Hypercubes()
#h.output_results(5,False,3,5)

h.get_eigenvalues(4,5)
︡835231ac-f324-4ba6-836e-cf04c141b05d︡{"file":{"filename":"/tmp/tmp_rnsan82/tmp_u3flzcy1.svg","show":true,"text":null,"uuid":"c1c96c9a-5819-428e-bf43-854c3cbff0c4"},"once":false}︡{"file":{"filename":"/tmp/tmp_rnsan82/tmp_dlzha117.svg","show":true,"text":null,"uuid":"6a0c9509-d4d4-4e66-8a14-e01bce578f33"},"once":false}︡{"stdout":"HypercubesEigenvalues done"}︡{"stdout":"\n"}︡{"done":true}









