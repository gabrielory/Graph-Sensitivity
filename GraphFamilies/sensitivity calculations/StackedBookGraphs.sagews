︠a8a636ad-457a-46e9-a39b-1537737daf62s︠
attach('../GraphFamily.sage')

# defines a class representing stacked book graphs that inherits from GraphFamily
class StackedBookGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "StackedBookGraphs"
        self.min_n = 2
        self.min_m = 1

    # returns a stacked book graph with the current values for n and m
    def graph(self, graphDetails):
    
        m = graphDetails.m
        n = graphDetails.n 
    
        star = graphs.StarGraph(m)
        path = graphs.PathGraph(n)
        
        book = star.cartesian_product(path)
        
        graphDetails.graph = book
        
        # book.show()
   
        return book
  
    # prints or returns a table of graph information with values of n from 2 to n using formulas
    def table_by_formulas(self, max_n, m, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, max_n + 1):
            
            alpha = m * math.ceil(n_value/2) + math.floor(n_value/2)
            
            if (m == 1):
                sigma = 2 if n_value % 2 == 0 else 1
            else:
                sigma = 2 if n_value == 3 else 1
                
            deg =  m+1 if n_value == 2 else m+2
            
            row = [n_value, m, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t
        
        
# run the code
sbg = StackedBookGraphs()
sbg.output_results(6, 6, True, 4, 6, 4, 6)
︡0f77e88e-3d23-4ca8-8af2-7a0e937220bc︡{"stdout":"StackedBookGraphsResults done"}︡{"stdout":"\n"}︡{"done":true}









