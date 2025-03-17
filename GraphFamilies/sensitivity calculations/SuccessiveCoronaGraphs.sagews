︠a3b20da0-d70b-4b00-83e0-415e3fe86f63sr︠
attach('../OneVarGraphFamily.sage')
attach('../corona_product.sage')
from tabulate import tabulate

# returns a complete regular multipartite graph with the given values for n and m
def complete_regular_multipartite_graph(n,m):

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
        crmg.relabel(range(crmg.num_verts()))

    #crmg.show()

    return crmg


# defines a class representing successive corona graphs that inherits from OneVarGraphFamily
class SuccessiveCoronaGraphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "SuccessiveCoronaGraphs"
        self.notation = "((K_1^2 ⊙ K_2^2) ⊙ K_3^2) ... )⊙ K_n^2"
        self.out_dir = "../../out/Corona Graphs/"
        self.min_n = 2

    # returns a corona graph
    def graph(self, graphDetails, G, H):

        corona = corona_product(G, H)

        corona.show()

        graphDetails.graph = corona
        
        # print(corona.num_verts())

        return corona

    # prints or returns a table of graph information with values of n from 2 to n using formulas
    def table_by_formulas(self, max_n, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, max_n + 1): # must be non-empty, so start n at 2

            alpha = "not finished"
            sigma = math.ceil((n_value+1)/2)
            deg = "not finished"

            row = [n_value, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t

    # prints or returns a table of graph information with values of n from min_n to max_n using graphs
    def table(self, max_n, min_s = 0, print_table = false):

        t = [self.table_columns]

        G = complete_regular_multipartite_graph(1,2)

        for n in range(self.min_n, max_n + 1):

            H = complete_regular_multipartite_graph(n,2)

            gd = self.GraphDetails(n = n)
            G = self.graph(gd, G, H)

            alpha = self.get_alpha(gd)
            sigma = self.get_sensitivity(gd)

            deg = self.max_degree(G) if G.order() > 0 else 0
            row = [n, G.order(), G.size(), deg, alpha, sigma]

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

        G = complete_regular_multipartite_graph(1,2)

        for n in range(self.min_n, upper + 1):

            H = complete_regular_multipartite_graph(n,2)

            gd = self.GraphDetails(n = n)
            G = self.graph(gd, G, H)

            if n >= lower and n <= upper:

                matrices.append([n, G.adjacency_matrix()])

        return matrices


    # returns a table of graph information with values of n from min_n to n and adjacency matrices using graphs (less operations than calling both seperately)
    def table_and_matrices(self, max_n, lower = 6, upper = 8, min_s = 0):

        t = [self.table_columns]
        matrices = []
        eigenvalues = []
        eigenvectors = []

        # set a threshold for tiny imaginary parts
        threshold = 1e-10

        G = complete_regular_multipartite_graph(1,2)

        for n_value in range(self.min_n, max_n + 1):

            H = complete_regular_multipartite_graph(n_value,2)

            gd = self.GraphDetails(n = n_value)
            G = self.graph(gd, G, H)

            alpha = self.get_alpha(gd)
            sigma = self.get_sensitivity(gd)

            deg = self.max_degree(G) if G.order() > 0 else 0
            row = [n_value, G.order(), G.size(), deg, alpha, sigma]

            if sigma >= min_s:
                t.append(row)

            if ((n_value >= lower and n_value <= upper)):
                matrices.append([n_value, G.adjacency_matrix()])

                eigenvalue, eigenvector =  np.linalg.eig(np.array(G.adjacency_matrix()))

                eigenvalue = np.where(np.abs(eigenvalue.imag) < threshold, eigenvalue.real, eigenvalue)
                eigenvector = [np.where(np.abs(element.imag) < threshold, element.real, element) for element in eigenvector]

                eigenvalues.append(eigenvalue)
                eigenvectors.append(eigenvector)


        return [t, matrices, eigenvalues, eigenvectors]


# run the code
scg = SuccessiveCoronaGraphs()
scg.output_results(3, False)


## extra code for displaying graphs without computing sensitivity ##

G = complete_regular_multipartite_graph(1,2)

max_n = 4 # adjust this to display more or less graphs; seems to run out of memory when above 4

for n in range(2, max_n + 1): 
    H = complete_regular_multipartite_graph(n ,2)
    gd = scg.GraphDetails(n = n)
    G = scg.graph(gd, G, H)

︡68fa7103-75ee-43ec-a851-deee4bfab1a2︡{"file":{"filename":"/tmp/tmp_z129n4w/tmp_qpy076c0.svg","show":true,"text":null,"uuid":"a60c8035-6e73-4622-8737-e8ab463db642"},"once":false}︡{"file":{"filename":"/tmp/tmp_z129n4w/tmp_mrtpe2zr.svg","show":true,"text":null,"uuid":"4e2328bc-be00-4cc6-ae95-8ac288001a64"},"once":false}









