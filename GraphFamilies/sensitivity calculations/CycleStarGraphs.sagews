︠7ebb49d3-5624-4cfa-aa8b-e00423458e58s︠
attach('../GraphFamily.sage')
from tabulate import tabulate

# defines a class representing cycle-star graphs that inherits from GraphFamily
class CycleStarGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "CycleStarGraphs"
        self.min_n = 1
        self.min_m = 3

    # returns a cycle-star graph with the current values for n and m
    def graph(self, graphDetails):
    
        m = graphDetails.m
        n = graphDetails.n
    
        # create cycle
        cyclestar = graphs.CycleGraph(m)
        
        # add n vertices to the graph
        for i in range(n):
            cyclestar.add_vertex()
    
        # attach each of the new vertices to a specific vertex in the cycle (e.g., vertex 0)
        for i in range(m, m + n):
            cyclestar.add_edge(0, i)  
   
        #print(f"n = {n}")
        #print(f"m = {m}")

        graphDetails.graph = cyclestar
        # cyclestar.show()
    
        return cyclestar
    
    # prints or returns a table of graph information with values of n from 1 to n using formulas
    def table_by_formulas(self, n, m, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, n + 1):
            
            alpha = math.floor(m/2) + n_value
            sigma = 2 if m == 4 else 1
            deg = n_value + 2
            
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
graph = CycleStarGraphs()
graph.output_results(10,10, True)
#graph.sensitivity_output_table()
︡ba90508a-3f4f-4ff8-b302-72aac37bcf86︡{"stdout":"CycleStarGraphsResults done"}︡{"stdout":"\n"}︡{"done":true}
︠dd6cbe41-33f9-4bb9-b8b8-ce3f9f260282︠









