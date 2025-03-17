from abc import ABC, abstractmethod
import sys
from sage.groups.perm_gps.permgroup_element import make_permgroup_element
import numpy as np
from numpy.linalg import eig

attach("../../PriorityQueue.sage")

class GraphFamily(ABC):

    def __init__(self):
        self.table_columns = ["n", "m", "|V|", "|E|", "deg", "alpha", "sigma"]
        self.table_columns_2 = ["n", "m", "deg", "alpha", "sigma"]
        self.out_dir = "../../out/"

    @abstractmethod
    def graph(self): pass

    # prints or returns a table of graph information with values of n from min_n to max_n using graphs
    def table(self, max_n, m, min_s = 0, print_table = False):

        t = [self.table_columns]
        
        for n_value in range(self.min_n, max_n + 1):
            
            gd = self.GraphDetails(n = n_value, m = m)
            graph = self.graph(gd)
            alpha = self.get_alpha(gd)
            sigma = self.get_sensitivity(gd)
            deg = self.max_degree(graph) if graph.order() > 0 else 0
            row = [n_value, m, graph.order(), graph.size(), deg, alpha, sigma]
            if sigma >= min_s:
                t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t

    # returns the adjacency matrices for n = lower1 to n = upper1 and m = lower2 to m = upper2
    def get_matrices(self, lower_n = 6, upper_n = 8, lower_m = 6, upper_m = 8):
        
        matrices = []
        
        for n_value in range(lower_n, upper_n + 1): 
            
            for m_value in range(lower_m, upper_m + 1):
                
                gd = self.GraphDetails(n = n_value, m = m_value)
                graph = self.graph(gd)
               
                matrices.append([n_value, m_value, graph.adjacency_matrix()])
            
        return matrices
    
    # returns a table of graph information with values of n from min_n to max_n and adjacency matrices using graphs (less operations than calling both seperately)
    def table_and_matrices(self, max_n, m, lower_n = 6, upper_n = 8, lower_m = 6, upper_m = 8, min_s = 0):

        t = [self.table_columns]
        matrices = []
        eigenvalues = []
        eigenvectors = []
 
        # set a threshold for tiny imaginary parts
        threshold = 1e-10
        
        for n_value in range(self.min_n, max_n + 1):
                
            gd = self.GraphDetails(n = n_value, m = m)
            graph = self.graph(gd)
            alpha = self.get_alpha(gd)
            sigma = self.get_sensitivity(gd)
            deg = self.max_degree(graph) if graph.order() > 0 else 0
            row = [n_value, m, graph.order(), graph.size(), deg, alpha, sigma]
            if sigma >= min_s:
                t.append(row)
             
            if ((n_value >= lower_n and n_value <= upper_n) and (m >= lower_m and m <= upper_m)):
                
                adj_matrix = graph.adjacency_matrix()
                
                matrices.append([n_value, m, adj_matrix])
                
                eigenvalue, eigenvector =  np.linalg.eig(np.array(adj_matrix))
              
                eigenvalue = np.where(np.abs(eigenvalue.imag) < threshold, eigenvalue.real, eigenvalue)
                eigenvector = [np.where(np.abs(element.imag) < threshold, element.real, element) for element in eigenvector]
                
                eigenvalues.append(eigenvalue)
                eigenvectors.append(eigenvector)
                
        return [t, matrices, eigenvalues, eigenvectors]

    # write the table for n = min_n to n = max_n to an output file
    def output_results(self, max_n, max_m, show_eigenvectors = False, lower_n = 6, upper_n = 8, lower_m = 6, upper_m = 8, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + min_s_str + ".txt", 'w')
        
        matrices = []
        eigenvalues = []
        eigenvectors = []
       
        try:
            f.write(f"Notation: {self.notation}\n\n")
        except: 
            pass
            
        f.write("Tables using graphs: \n")
        for m in range(self.min_m, max_m + 1):
            
            t_m = self.table_and_matrices(max_n, m, lower_n, upper_n, lower_m, upper_m, min_s)
            
            t = t_m[0]
            matrices.append(t_m[1])
            eigenvalues.append(t_m[2])
            eigenvectors.append(t_m[3])
                                      
            f.write(str(table(t)))
            f.write("\n\n")
            
        f.write("\nTables using formulas: \n")
        for m in range(self.min_m, max_m + 1):
            t2 = self.table_by_formulas(max_n, m)
            f.write(str(table(t2)))
            f.write("\n\n")
            
        f.write("\nAdjacency matrices: \n")
        
        for index in range(len(matrices)):
            for element in range(len(matrices[index])):
        
                if len(matrices[index][element]) != 0:
            
                    f.write("n = ")
                    f.write(str(matrices[index][element][0]))
                    f.write("\nm = ")
                    f.write(str(matrices[index][element][1]))
                    f.write("\n")
                    f.write(str(matrices[index][element][2]))
                                     
                    f.write("\n\nEigenvalues: ")
            
                    combined = list(zip(eigenvalues[index][element], eigenvectors[index][element]))

                    # sort the combined list by eigenvalues
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
        
    @abstractmethod
    def table_by_formulas(self): pass

    #@abstractmethod
    #def results_suite(self): pass

    class GraphDetails:
        def __init__(self, graph = None, n = None, m = None, alpha = None):
            self.graph = graph
            self.n = n
            self.m = m
            self.alpha = alpha

            
     
    ## Sensitivity methods ##

    def get_alpha(self, graphDetails):
        alpha = len(graphDetails.graph.independent_set())
        graphDetails.alpha = alpha
        return alpha
    
    def max_degree(self, graph):
        return max(graph.degree())

    # creates an induced subgraph of the graph based on a list of vertex indices, then computes and returns the max degree of the subgraph
    def _lowerbound(self, graph, indices):
        return self.max_degree(graph.subgraph(vertices = [graph.vertices()[i] for i in indices]))
    
    # creates an induced subgraph of the graph with the given vertices, then computes and returns the max degree of the subgraph
    def _lowerbound2(self, graph, verts):
        return self.max_degree(graph.subgraph(vertices = verts))

    def _depth(self, soln):
        return len(soln["vertices"])

    
    def get_sensitivity(self, graphDetails):
        
        graph = graphDetails.graph
        n = graph.order()
        a = graphDetails.alpha if graphDetails.alpha != None else self.get_alpha(graphDetails)
        bssf = self.sensitivity_estimate(graphDetails) # initial sensitivity estimate
        if bssf <= 1: return bssf

        # initializes a BinaryHeap instance with a single dictionary containing the list [0] (a starting vertex) and a lower bound of 0
        q = BinaryHeap([0], 0)    # set of active subproblems
        
        
        for v in range(1, n - a):
            q.insert([v], 0) # inserts items into the heap: {"vertices": [1], "lb": 0}, {"vertices": [2], "lb": 0}, ..., {"vertices": [n-a], "lb": 0}
        
        while not q.isEmpty():
           
            soln = q.deleteMin()    # select solution - get highest priority item and remove it from the heap
            
            # if the lower bound of soln is greater than or equal to bssf, it’s pruned (skipped) because it cannot improve the best sensitivity found so far
            if soln["lb"] >= bssf: continue # prune solution
            
            # if the depth of soln (number of vertices) equals a + 1, it means it is a candidate solution
            # - updates bssf with the lower bound of this solution
            # - if bssf becomes less than or equal to 1, returns bssf 
            elif self._depth(soln) == a + 1:    # candidate solution, update bssf
                bssf = soln["lb"]
                if bssf <= 1: return bssf
            
            # for a partial solution, generates new vertex sets by adding one more vertex and calculates their lower bounds 
            # if the new lower bound is better than bssf, the new vertex set is inserted into the heap
            # if not, the new vertex set is pruned (skipped)
            # EXAMPLE: q = [{'vertices': [0], 'lb': 0}, {'vertices': [1], 'lb': 0}] might become q = [{'vertices': [0, 2], 'lb': 0}, {'vertices': [1], 'lb': 0}, {'vertices': [0, 1], 'lb': 1}] then restart while loop
            else:                        # partial solution, expand
          
                for v in range(soln["vertices"][-1] + 1, n - a + self._depth(soln)):
                    
                    newVertices = soln["vertices"].copy()
                    newVertices.append(v)
        
                    newlb = self._lowerbound(graph, newVertices)
                    if newlb < bssf: q.insert(newVertices, newlb) # add new solution to active set
                    # else new solution is pruned
              
        return bssf

    
    # gets the smallest max degree of the induced subgraph on alpha + 1 vertices by greedy search
    def sensitivity_estimate(self, graphDetails):
        graph = graphDetails.graph
        n = graph.order()
        a = graphDetails.alpha if graphDetails.alpha != None else self.get_alpha(graphDetails)
        if n <= a: return 0

        # greedy - get a sensitivity estimate
        
        remaining = graph.vertices().copy() # get all vertices in the graph
        vertices = [remaining.pop(0)] # gets the first vertex to start with, REMOVING it from remaining
        
        for i in range(a):    # add alpha more vertices one vertex at a time, checking all options and choosing whichever gives the induced subgraph the smallest max degree   THINK MORE ABOUT THIS
            best = sys.maxsize
            index = 0
            for j in range(len(remaining)):
                lb = self._lowerbound2(graph, vertices + [remaining[j]])
                if lb < best:
                    best = lb
                    index = j
            vertices.append(remaining.pop(index))

        # local search - improve the sensitivity estimate
        
        improved = True
        best = self._lowerbound2(graph, vertices) # max degree of the induced subgraph on alpha + 1 vertices found in greedy search
        
        # swaps each vertex in vertices with each vertex in remaining to iteratively improve the lowerbound
        # if the lowerbound is improved, the process is repeated with the new set of vertices 
        # if no improvement is found after a full pass, the local search terminates
        while improved:
            improved = False
            for i in range(len(vertices)): 
                for j in range(len(remaining)):
                    vertices[i], remaining[j] = remaining[j], vertices[i]
                    lb = self._lowerbound2(graph, vertices)
                    if lb < best:
                        best = lb
                        improved = true
                    else:
                        vertices[i], remaining[j] = remaining[j], vertices[i]

        return self._lowerbound2(graph, vertices)

    
    ## k-sensitivity methods ##

   
    def get_induced_subgraphs(self, graph, num_vertices):

        subgraphs = []

        # generate all combinations of x vertices from the graph
        for vertices_subset in Subsets(graph.vertices(), num_vertices):
            
            # create the subgraph induced by this subset of vertices
            subgraph = graph.subgraph(vertices_subset)
            subgraphs.append(subgraph)

            #print(subgraph.is_subgraph(graph, induced = True)) # code to test and confirm it is an induced subgraph
            
        return subgraphs


    def get_ksensitivity(self, k, graphDetails):
        
        if k <= 0:
            return 0
        
        graph = graphDetails.graph
        a = graphDetails.alpha if graphDetails.alpha != None else self.alpha(graphDetails)
        
        if k <= graph.order() - a:
        
            num_vertices = a + k
       
            # start at max degree of whole graph
            k_sen = self.max_degree(graph) if graph.order() > 0 else 0
            
            subgraphs = self.get_induced_subgraphs(graph, num_vertices)
            
            for subgraph in subgraphs:
                deg = self.max_degree(subgraph) if graph.order() > 0 else 0
                
                if deg < k_sen:
                    k_sen = deg
        
        # indicates invalid k value
        else:
            k_sen = -1
            
        return k_sen





