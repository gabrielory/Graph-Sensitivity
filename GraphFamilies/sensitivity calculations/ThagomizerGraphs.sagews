︠cb50a9dd-f327-4450-9fb1-fd72f14a1afb︠
attach('../OneVarGraphFamily.sage')

# defines a class representing thagomizer graphs that inherits from OneVarGraphFamily
class ThagomizerGraphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "ThagomizerGraphs" 
        self.min_n = 1

    # returns a thagomizer graph with the current n
    def graph(self, graphDetails):
        
        n = graphDetails.n
        star = graphs.StarGraph(n) # k1 join k'n
        
        thagomizer = star.join(graphs.CompleteGraph(1))
        
        graphDetails.graph = thagomizer
        thagomizer.show()
        
        return thagomizer
    
    # prints or returns a table of graph information with values of n from min_n to max_n using formulas
    def table_by_formulas(self, max_n, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, max_n + 1):
            
            alpha = n_value
            sigma = n_value
            deg = n_value + 1
            
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
tg = ThagomizerGraphs()
tg.output_results(10, True)
#tg.output_ksensitivity(100)
︡53c7df70-2f45-4e57-93ea-5bf64ad1f87f︡{"file":{"filename":"/tmp/tmpfa9059a3/tmp_sg4ndck_.svg","show":true,"text":null,"uuid":"f1350102-578c-4d0e-a4be-ac9e0a82fb70"},"once":false}︡{"file":{"filename":"/tmp/tmpfa9059a3/tmp_i0mjq2dl.svg","show":true,"text":null,"uuid":"7c7ba050-08de-4922-98e7-007dbdf00037"},"once":false}︡{"file":{"filename":"/tmp/tmpfa9059a3/tmp_1jf6h0fi.svg","show":true,"text":null,"uuid":"3ec2a7ff-98a0-4645-85b0-f1983f465b24"},"once":false}︡{"file":{"filename":"/tmp/tmpfa9059a3/tmp_o2q9xb03.svg","show":true,"text":null,"uuid":"b4ef1c6f-477a-4f5f-8a38-44fc63403863"},"once":false}︡{"file":{"filename":"/tmp/tmpfa9059a3/tmp_9vf6o85k.svg","show":true,"text":null,"uuid":"ca4415a7-73dd-49f2-8609-b227aee84e6a"},"once":false}︡{"file":{"filename":"/tmp/tmpfa9059a3/tmp_bbgzne30.svg","show":true,"text":null,"uuid":"09f41aff-8a3f-4ef9-b349-2f0bbe6eb798"},"once":false}︡{"file":{"filename":"/tmp/tmpfa9059a3/tmp_jzzsa7ru.svg","show":true,"text":null,"uuid":"00840540-6d77-48e7-84c3-d9db13ef7a37"},"once":false}︡{"file":{"filename":"/tmp/tmpfa9059a3/tmp_z9ujqn75.svg","show":true,"text":null,"uuid":"92f71273-f9f5-4ea9-87b0-636088b5546b"},"once":false}︡{"file":{"filename":"/tmp/tmpfa9059a3/tmp_42aey2q1.svg","show":true,"text":null,"uuid":"421f921a-1e66-4eba-9184-5c3e5b9b58c3"},"once":false}︡{"file":{"filename":"/tmp/tmpfa9059a3/tmp_e4grvm5x.svg","show":true,"text":null,"uuid":"c55314fe-4409-47d5-a9b7-822e6a3edfbb"},"once":false}︡{"stdout":"ThagomizerGraphsResults done"}︡{"stdout":"\n"}︡{"done":true}









