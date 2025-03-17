︠cb987d3e-3b80-4da6-b4d2-455b58e49526s︠
attach('../GraphFamily.sage')
from itertools import combinations_with_replacement
import string
import copy
import heapq

# gets rid of duplicate graphs that occur when using for loops
def get_combinations(min_vertices = 1, max_vertices = 10, num_parts = 3):

    # define the range of numbers
    numbers = range(min_vertices, max_vertices + 1)

    # generate all combinations of possible numbers of vertices for a complete multipartite graph with num_parts
    combinations = list(combinations_with_replacement(numbers, num_parts))
    
    # convert tuples to lists
    combinations = [list(combo) for combo in combinations]

    return combinations

# get letters to represent the number of vertices in each part
def get_letters(start_letter = "n", num_parts = 3):
    
    alphabet = string.ascii_lowercase
    
    # starting position of the start_letter
    start_index = alphabet.index(start_letter)
    
    # create the sequence by slicing and wrapping around
    sequence = [alphabet[(start_index + i) % len(alphabet)] for i in range(num_parts)]
    
    return sequence

# defines a class representing complete multipartite graphs that inherits from GraphFamily
class CompleteMultipartiteGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "CompleteMultipartiteGraphs"
        self.table_columns = ["|V|", "|E|", "deg", "alpha", "sigma"]
        self.table_columns_2 = ["deg", "alpha", "sigma"]      
            
    # returns a complete multipartite graph with the current values in combination
    def graph(self, graphDetails, combination):
    
        n = combination[0]
          
        # create a graph with 0 vertices and 0 edges
        cmg = graphs.EmptyGraph()
        
        # make cmg = K'n by adding n vertices to empty
        for i in range(n):
            cmg.add_vertex()
        
        # join K'n with other empty graph parts
        for element in combination[1:]:
            
            empty = graphs.EmptyGraph()
            for count in range(element):
                empty.add_vertex()
            
            # offset vertex labels
            vertex_map = dict()
            for vertex in empty.vertices():
                vertex_map[vertex] = vertex + n      
            empty.relabel(vertex_map)
            
            cmg = cmg.join(empty)
             
        # cmg.show()
        
        graphDetails.graph = cmg
        
        return cmg
    
    # prints or returns a table of graph information for graphs with num_parts parts and all possible combination of vertex counts given min_vertices and max_vertices
    def table(self, min_vertices, max_vertices, num_parts, min_s = 0, print_table = False):

        t = get_letters("n", num_parts)
        t.extend(self.table_columns)
        t = [t]
        
        combinations = get_combinations(min_vertices, max_vertices, num_parts)
        for combination in combinations:
            
            gd = self.GraphDetails()
            graph = self.graph(gd, combination)
            alpha = self.get_alpha(gd)
            sigma = self.get_sensitivity(gd)
            deg = self.max_degree(graph) if graph.order() > 0 else 0
            
            combination.extend([graph.order(), graph.size(), deg, alpha, sigma])
            if sigma >= min_s:
                t.append(combination)

        if print_table:
            print(self.name)
            print(table(t))
            print("\n\n")
        else:
            return t
    
    # prints or returns a table of graph information using formulas
    def table_by_formulas(self, min_vertices, max_vertices, num_parts, print_table = False):
        
        t = get_letters("n", num_parts)
        t.extend(self.table_columns_2)
        t = [t]
        
        combinations = get_combinations(min_vertices, max_vertices, num_parts)
        for combination in combinations:
            
            alpha = max(combination)
            
            largest_two = heapq.nlargest(2, combination)
            
            big = largest_two[0]
            small = largest_two[0]
            
            if (small <= math.floor((big + 1) / 2)):
                sigma = big - small + 1
            else:
                sigma = math.ceil((big + 1) / 2)
            
            # deg = sum(heapq.nlargest((num_parts - 1), combination))
            deg = sum(combination) - min(combination)
            
            combination.extend([deg, alpha, sigma])
            t.append(combination)

        if print_table:
            print(self.name)
            print(table(t))
            print("\n\n")
        else:
            return t

    # returns the adjacency matrices for graphs whose parts contain vertex counts between min_vertices and max_vertices
    def get_matrices(self, min_vertices = 6, max_vertices = 8, num_parts = 3):
        
        matrices = []
        
        combinations = get_combinations(min_vertices, max_vertices, num_parts)
        
        for combination in combinations: 
            
            gd = self.GraphDetails()
            graph = self.graph(gd, combination)
               
            combination.extend([graph.adjacency_matrix()])
            matrices.append(combination)
            
        return matrices
    
    # returns a table of graph information and adjacency matrices (less operations than calling both seperately)
    def table_and_matrices(self, min_vertices = 1, max_vertices = 10, num_parts = 3, lower = 6, upper = 8, min_s = 0):

        t = get_letters("n", num_parts)
        t.extend(self.table_columns)
        t = [t]
        
        matrices = []
        eigenvalues = []
        eigenvectors = []
        
        combinations = get_combinations(min_vertices, max_vertices, num_parts)
        for combination in combinations: 
            
            gd = self.GraphDetails()
            graph = self.graph(gd, combination)
            alpha = self.get_alpha(gd)
            sigma = self.get_sensitivity(gd)
            deg = self.max_degree(graph) if graph.order() > 0 else 0
            
            row = copy.deepcopy(combination)
            row.extend([graph.order(), graph.size(), deg, alpha, sigma])
            if sigma >= min_s:
                t.append(row)
             
            if all(lower <= x <= upper for x in combination):
                combination.extend([graph.adjacency_matrix()])
                matrices.append(combination)
                eigenvalue, eigenvector = eig(np.array(graph.adjacency_matrix()))
                
                eigenvalues.append(eigenvalue)
                eigenvectors.append(eigenvector)
                       
        return [t, matrices, eigenvalues, eigenvectors]
                
       
    # write the tables and adjacency matrices to an output file
    def output_results(self, min_vertices = 1, max_vertices = 10, num_parts = 3, show_eigenvectors = False, lower = 6, upper = 8, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + str(num_parts) + min_s_str + ".txt", 'w')
        
        f.write("Tables using graphs: \n")
        
        t_m = self.table_and_matrices(min_vertices, max_vertices, num_parts, lower, upper, min_s)
        t = t_m[0]
        matrices = t_m[1]
        eigenvalues = t_m[2]
        eigenvectors = t_m[3]
     
        f.write(str(table(t)))
        f.write("\n\n")

        f.write("\nTables using formulas: \n")
        t2 = self.table_by_formulas(min_vertices, max_vertices, num_parts)
        f.write(str(table(t2)))
        f.write("\n\n")
            
        f.write("\nAdjacency matrices: \n")

        letters = get_letters("n", num_parts) 
        
        # set a threshold for tiny imaginary parts
        threshold = 1e-10

        # remove tiny imaginary parts
        eigenvalues = [np.where(np.abs(element.imag) < threshold, element.real, element) for element in eigenvalues]
        eigenvectors = [np.where(np.abs(element.imag) < threshold, element.real, element) for element in eigenvectors]
        
        for element in range(len(matrices)):

                if (len(matrices[element]) != 0):
   
                    for i in range(len(matrices[element])-1):
                        f.write(letters[i])
                        f.write("= ")
                        f.write(str(matrices[element][i]))
                        f.write("\n")
                    
                    f.write(str(matrices[element][-1]))
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

        print(self.name + str(num_parts) + "Results done")
 
        
# run the code
cmg = CompleteMultipartiteGraphs()
cmg.output_results(1, 4, 3, True, 3, 4)
cmg.output_results(1, 4, 4, True, 3, 4)
cmg.output_results(1, 4, 5, True, 3, 4)
︡61ac1510-330e-4bdb-978b-f882696d8a31︡{"stdout":"CompleteMultipartiteGraphs3Results done"}︡{"stdout":"\n"}︡{"stdout":"CompleteMultipartiteGraphs4Results done"}︡{"stdout":"\n"}︡{"stdout":"CompleteMultipartiteGraphs5Results done"}︡{"stdout":"\n"}︡{"done":true}









