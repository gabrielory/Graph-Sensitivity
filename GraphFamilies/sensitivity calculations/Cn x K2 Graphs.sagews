︠8ffee4c1-475f-43ff-8bcb-1444db292df6︠
attach('../OneVarGraphFamily.sage')

# defines a class representing Cn x K2 graphs that inherits from OneVarGraphFamily
class CnxK2Graphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "Cn x K2 Graphs"
        self.notation = "Cn x K2"
        self.min_n = 3
   
    # returns a Cn x K2 graph with the current n
    def graph(self, graphDetails):
        
        n = graphDetails.n
        
        cn = graphs.CycleGraph(n)
        k2 = graphs.CompleteGraph(2)
        cnxk2 = cn.tensor_product(k2)
        
        graphDetails.graph = cnxk2
        
        return cnxk2

    # prints or returns a table of graph information with values of n from min_n to n using formulas
    def table_by_formulas(self, max_n, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, max_n + 1):
        
            alpha = n_value
            sigma = 2 if n_value == 4 else 1
            deg = 2
            
            row = [n_value, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t
    
        return
        
# run the code
g = CnxK2Graphs()
g.output_results(10,True)
︡bb62a32a-8985-4ac9-9250-ab12c621a74c︡{"stdout":"Cn x K2 GraphsResults done"}︡{"stdout":"\n"}︡{"done":true}










