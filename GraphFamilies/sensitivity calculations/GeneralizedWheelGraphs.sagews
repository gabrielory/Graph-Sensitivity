︠85b5e65e-6ba0-4c00-8db3-a3a86165c155s︠
attach('../GraphFamily.sage')

from tabulate import tabulate
import math

# defines a class representing generalized wheel graphs that inherits from GraphFamily
class GeneralizedWheelGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "GeneralizedWheelGraphs"
        self.min_n = 3
        self.min_m = 1

    # returns a generalized wheel graph with the current values for n and m
    def graph(self, graphDetails):
    
        m = graphDetails.m
        n = graphDetails.n

        # create a graph g with 0 vertices and 0 edges
        g = graphs.EmptyGraph() 

        # make g = K'm by adding n vertices to g
        for i in range(m):
            g.add_vertex()
        
        # create Cn
        cn = graphs.CycleGraph(n)
        
        # create the generalized wheel graph
        gwg = g.join(cn)
            
        graphDetails.graph = gwg
        # gwg.show()
      
        return gwg
    
    # prints or returns a table of graph information with values of n from 3 to n using formulas
    def table_by_formulas(self, n, m, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(3, n + 1):
            
            alpha_cn = math.floor(n_value/2)
            alpha = max(m, alpha_cn)
            
            if m <= alpha_cn and n_value > 4:
                sigma = 1
            elif alpha_cn < m < n_value:
                sigma = "<=2"
            elif m >= n_value:
                sigma = f">={m + 1 - n_value}"
            else: 
                sigma = "not accounted for yet"
            
            deg = max(m+2,n_value)
            
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
        f = open(self.out_dir + self.name + "SensitivityResults" + min_s_str + ".txt", 'w')

        m_row = []
        mplusone_row = []
        n_col = []
        ceilnover2_col = []
        sensitivity = []

        for m in range(self.min_m, max_m + 1):
            m_row.append(m)
            mplusone_row.append(m + 1)

            t = self.table(max_n, m, min_s)
            sensitivity.append([t[row + 1][6] for row in range(len(t) - 1)])
            
        for n in range(self.min_n, max_n + 1):
            n_col.append(n)
            ceilnover2_col.append(math.ceil(n / 2))

        # create the header
        header = [
            ["", "", "m+1"] + [f"{element}" for element in mplusone_row],
            ["", "", "m"] + [f"{element}" for element in m_row],
            ["n", "ceil(n/2)", ""] + ["" for element in m_row],
        ]

        # create rows
        rows = []
        for i in range(len(n_col)):
            row = [n_col[i], ceilnover2_col[i], ""] + [element[i] for element in sensitivity]
            rows.append(row)

        # combine the header and rows
        table_data = header + rows
   
        f.write(tabulate(table_data, tablefmt="grid"))
        f.close()

        print(self.name + "SensitivityResults done")
        
    # write an alternate table to an output file
    def formula_output_table(self, max_n = 10, max_m = 10, min_s = 0):

        min_s_str = ("_s>=" + str(min_s)) if min_s > 0 else ""
        f = open(self.out_dir + self.name + "FormulaResults" + min_s_str + ".txt", 'w')

        m_row = []
        mplusone_row = []
        n_col = []
        floornover2_col = []
        sensitivity = []

        for m in range(self.min_m, max_m + 1):
            m_row.append(m)
            mplusone_row.append(m + 1)

            t = self.table_by_formulas(max_n, m, min_s)
            sensitivity.append([t[row + 1][4] for row in range(len(t) - 1)])
        
        for n in range(self.min_n, max_n + 1):
            n_col.append(n)
            floornover2_col.append(math.floor(n / 2))

        # create the header
        header = [
            ["", "", "m+1"] + [f"{element}" for element in mplusone_row],
            ["", "", "m"] + [f"{element}" for element in m_row],
            ["n", "floor(n/2)", ""] + ["" for element in m_row],
        ]

        # create rows
        rows = []
        for i in range(len(n_col)):
            row = [n_col[i], floornover2_col[i], ""] + [element[i] for element in sensitivity]
            rows.append(row)

        # combine the header and rows
        table_data = header + rows
   
        f.write(tabulate(table_data, tablefmt="grid"))
        f.close()

        print(self.name + "FormulaResults done")
        
# run the code
gwg = GeneralizedWheelGraphs()
#gwg.output_results(10,10, True)
#gwg.sensitivity_output_table()
gwg.formula_output_table()
︡b8de3d29-63ed-4dac-938e-da1673e30764︡{"stdout":"GeneralizedWheelGraphsFormulaResults done\n"}︡{"done":true}









