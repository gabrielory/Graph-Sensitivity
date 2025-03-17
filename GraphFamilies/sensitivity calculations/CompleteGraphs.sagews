︠5e026b78-23f6-4677-bc3f-4a27c4de1224s︠
attach('../OneVarGraphFamily.sage')

# defines a class representing complete graphs that inherits from OneVarGraphFamily
class CompleteGraphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "CompleteGraphs"
        self.min_n = 2
   
    # returns a complete graph with the current n
    def graph(self, graphDetails):
        n = graphDetails.n
        g = graphs.CompleteGraph(n)
        graphDetails.graph = g
        return g

    # prints or returns a table of graph information with values of n from 2 to n using formulas
    def table_by_formulas(self, max_n, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, max_n + 1): # must be non-empty, so start n at 2
            
            alpha = 1
            sigma = 1
            deg = n_value-1
            
            row = [n_value, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t
    
    # write the tables for k-sensitivity to an output file
    def output_ksensitivity(self, max_n):
           
        f = open(self.out_dir + self.name + "KSensitivityResults" + ".txt", 'w')
        
        for n_value in range(self.min_n, max_n + 1):
    
            t = [['n','k', 'alpha', 'k-sensitivity']]
            gd = self.GraphDetails(n = n_value)
            graph = self.graph(gd)
            alpha = self.get_alpha(gd)
            
            for k in range(1, graph.order() - alpha + 1):
                ksens = self.get_ksensitivity(k, gd)
                row = [n_value, k, alpha, ksens]
                t.append(row)
            
            f.write(str(table(t)))
            f.write("\n\n")
            
        f.close
        
        print(self.name + "KSensitivityResultsDone")
        return
        
# run the code
cg = CompleteGraphs()
cg.output_results(10,True)
#cg.output_ksensitivity(10)
︡8870ff0a-4242-46e7-a005-47eb8fefa8cc︡{"stdout":"CompleteGraphsResults done\n"}︡{"done":true}









