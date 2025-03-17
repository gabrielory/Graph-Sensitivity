︠55e5a70e-80f8-4607-b999-d0c30a21f22a︠
attach('../GraphFamily.sage')
attach('../corona_product.sage')
from tabulate import tabulate

# defines a class representing Km(K1 ∨ Kn) graphs that inherits from GraphFamily
class GenWindmillIIIGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "GenWindmillGraphsType3"
        self.min_n = 2
        self.min_m = 2

    
    # returns a Km(K1 ∨ Kn) graph with the current values for n and m
    def graph(self, graphDetails):
    
        m = graphDetails.m
        n = graphDetails.n
        
        kn = graphs.CompleteGraph(n)
        km = graphs.CompleteGraph(m)
        
        
        windmill = corona_product(km, kn)
        #windmill.show()
        
        graphDetails.graph = windmill
         
        #print(f"n = {n}")
        #print(f"m = {m}")
      
        return windmill
  

    # prints or returns a table of graph information with values of n from min_n to n using formulas
    def table_by_formulas(self, n, m, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, n + 1):
            
            alpha = m
            sigma = 1
            deg = n_value+m-1
            
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
graph = GenWindmillIIIGraphs()
graph.output_results(10,10, True)
graph.sensitivity_output_table()
︡c7716ab1-228f-4d1b-8cc6-ab4355638280︡{"stdout":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n"}︡{"stdout":"\nGenWindmillGraphsType3Results done"}︡{"stdout":"\n"}︡{"stdout":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n\n\n\n\n\n\n"}︡{"stdout":"\n\n\n\n"}︡{"stdout":"\n\n\nGenWindmillGraphsType3SensitivityResults done"}︡{"stdout":"\n"}︡{"done":true}









