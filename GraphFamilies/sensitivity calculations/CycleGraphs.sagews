︠15c2732a-e6b3-4583-90b2-00b3c133c11fs︠
attach('../OneVarGraphFamily.sage')

# defines a class representing cycle graphs that inherits from OneVarGraphFamily
class CycleGraphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "CycleGraphs"
        self.min_n = 3
    
    # returns a cycle graph with the current n
    def graph(self, graphDetails):
        n = graphDetails.n
        g = graphs.CycleGraph(n)
        graphDetails.graph = g
        g.show()
        return g
        
    # prints or returns a table of graph information with values of n from min_n to max_n using formulas
    def table_by_formulas(self, max_n, print_table = False):
        
        t = [self.table_columns_2]
        
        for n_value in range(self.min_n, max_n + 1): 
            
            alpha = math.floor(n_value/2)
            sigma = 1 if n_value != 4 else 2
            deg = 2
            
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
cg = CycleGraphs()
cg.output_results(10, True)
cg.output_ksensitivity(10)
︡6d2d29a0-05b6-4f5e-959b-155cac2ddb98︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_2axw8jea.svg","show":true,"text":null,"uuid":"3f70b049-92e5-4cca-84f1-48aa842717ce"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_0w3r9r0j.svg","show":true,"text":null,"uuid":"e5437601-bc31-4bf0-9316-4b58c6c7c82a"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_bhm6hzp8.svg","show":true,"text":null,"uuid":"fe757837-4d1b-45b1-88cc-c1520aa0a649"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_99m0t44g.svg","show":true,"text":null,"uuid":"17971ccd-cc19-478e-9696-b2002e37ce4a"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_j3qcwltu.svg","show":true,"text":null,"uuid":"ad47566a-6cef-446f-a5f7-6ca1678cbac4"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_w7itvgta.svg","show":true,"text":null,"uuid":"e6ba22b5-80b9-4d56-82e3-b5424ed5233c"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_497v6v2f.svg","show":true,"text":null,"uuid":"38d5a14c-fe46-4389-8b4f-65debab54f20"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_2rd9pp7w.svg","show":true,"text":null,"uuid":"e7032492-e4bf-48b5-8028-b0760b5aacbd"},"once":false}︡{"stdout":"CycleGraphsResults done"}︡{"stdout":"\n"}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_o0g63z52.svg","show":true,"text":null,"uuid":"2324d4fe-246c-4286-a381-65d9858e0a76"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_8wnr3gwj.svg","show":true,"text":null,"uuid":"1d7e3fbc-379c-4929-b911-30f7c1ad2dff"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_m3n6t9ok.svg","show":true,"text":null,"uuid":"d305abca-dfe1-464b-9bbc-045f7d6ac25f"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_xfvl7fxx.svg","show":true,"text":null,"uuid":"5a8ef2cc-4b45-49e9-98e2-8faf6bf37cff"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_e2p6r2h1.svg","show":true,"text":null,"uuid":"a45e4559-f3f1-480b-a05b-506107a4cdcd"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_f_saaech.svg","show":true,"text":null,"uuid":"d7f51525-461b-47f1-b89c-93c53af0143c"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_zwkgkf0o.svg","show":true,"text":null,"uuid":"55b11041-a9d3-4fad-a55e-cdf23410ca34"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_4vv9fc76.svg","show":true,"text":null,"uuid":"5722ac41-9524-430c-a9c2-506d57daa984"},"once":false}︡{"stdout":"CycleGraphsKSensitivityResultsDone"}︡{"stdout":"\n"}︡{"done":true}









