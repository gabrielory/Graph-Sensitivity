︠5e026b78-23f6-4677-bc3f-4a27c4de1224s︠
attach('../OneVarGraphFamily.sage')

# defines a class representing path graphs that inherits from OneVarGraphFamily
class PathGraphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "PathGraphs"
        self.min_n = 2
    
    # returns a path graph with the current n
    def graph(self, graphDetails):
        n = graphDetails.n
        g = graphs.PathGraph(n)
        graphDetails.graph = g
        return g

    # prints or returns a table of graph information with values of n from min_n to max_n using formulas
    def table_by_formulas(self, max_n, print_table = False):

        t = [self.table_columns_2]

        for count in range(self.min_n, max_n + 1):

            alpha = math.ceil(count/2)
            sigma = 1 if count != 3 else 2
            deg = 1 if count == 2 else 2

            row = [count, deg, alpha, sigma]
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
pg = PathGraphs()
#pg.output_results(10, True)
pg.output_ksensitivity(10)
︡0cb7d272-8e01-4941-9a2a-fadc6d4cde90︡{"stdout":"PathGraphsKSensitivityResultsDone\n"}︡{"done":true}









