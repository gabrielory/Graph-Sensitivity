︠df05dcc7-7e6a-4cfc-a207-be6b7d0bcb7cs︠
attach('../GraphFamily.sage')
from tabulate import tabulate

# defines a class representing Km[Pn] graphs that inherits from GraphFamily
class LexicographicProductGraphsP(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "LexicographicProductGraphs - P"
        self.min_n = 2
        self.min_m = 1

    # returns a Km[Pn] graph with the current values for n and m
    def graph(self, graphDetails):
    
        m = graphDetails.m
        n = graphDetails.n

        # create the Km graph
        complete = graphs.CompleteGraph(m) 
        
        # create the Pn graph
        path = graphs.PathGraph(n) 
        
        # create the lexicographic product graph
        graph = complete.lexicographic_product(path)
            
        graphDetails.graph = graph
        #graph.show()
      
        return graph
    
    # prints or returns a table of graph information with values of n from 2 to n using formulas
    def table_by_formulas(self, n, m, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, n + 1):
            
            alpha = math.ceil(n_value/2) # same as alpha_h
            
            sigma_h = 2 if n_value == 3 else 1
            
            sigma = min(sigma_h, math.ceil((alpha+1/2)) )
            deg = "not finished"
            
            row = [n_value, m, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(n))
            print(table(t))
            print("\n\n")
        else:
            return t
  
    # write an alternate table to an output file
    def sensitivity_output_table(self, max_n = 10, max_m = 10, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + " SensitivityResults" + min_s_str + ".txt", 'w')

        m_row = []
        n_col = []
        sensitivity = []

        for m in range(self.min_m, max_m + 1):
            m_row.append(m)

            t = self.table(max_n, m, min_s)
            sensitivity.append([t[row + 1][6] for row in range(len(t) - 1)])
            
        for n in range(self.min_n, max_n + 1):
            n_col.append(n)

        # create the header
        header = [
            ["", "m"] + [f"{element}" for element in m_row],
            ["n", ""] + ["" for element in m_row],
        ]

        # create rows
        rows = []
        for i in range(len(n_col)):
            row = [n_col[i], ""] + [element[i] for element in sensitivity]
            rows.append(row)

        # combine the header and rows
        table_data = header + rows
   
        f.write(tabulate(table_data, tablefmt="grid"))
        f.close()

        print(self.name + "SensitivityResults done")
        
        
# run the code
graph = LexicographicProductGraphsP()
graph.output_results(10,10, True)
#graph.sensitivity_output_table()
︡f1c22e70-5944-4fa9-8776-791a00280b21︡{"stdout":"LexicographicProductGraphs - PResults done"}︡{"stdout":"\n"}︡{"done":true}










