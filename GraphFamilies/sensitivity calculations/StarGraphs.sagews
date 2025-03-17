︠a8a636ad-457a-46e9-a39b-1537737daf62︠
attach('../OneVarGraphFamily.sage')

# defines a class representing star graphs that inherits from OneVarGraphFamily
class StarGraphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "StarGraphs" # k1 v k'n
        self.min_n = 1

    # returns a star graph with the current n
    def graph(self, graphDetails):
        
        n = graphDetails.n
        star = graphs.StarGraph(n)
        graphDetails.graph = star
        # star.show()
        
        return star
    
    # prints or returns a table of graph information with values of n from min_n to max_n using formulas
    def table_by_formulas(self, max_n, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, max_n + 1):
            
            alpha = n_value
            sigma = n_value
            deg = n_value
            
            row = [n_value, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t


# run the code
sg = StarGraphs()
sg.output_results(10, True)
︡393a90e4-2cef-4627-a0b2-556ff13926e2︡{"stdout":"StarGraphsResults done\n"}︡{"done":true}









