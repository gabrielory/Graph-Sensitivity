︠15a4f5d7-0367-4864-93dd-78ee30bb9bb6s︠
attach('../OneVarGraphFamily.sage')

# defines a class representing half cubes that inherits from OneVarGraphFamily
class HalfCubes(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "HalfCubes"
        self.min_n = 2

    # returns a half cube graph with the current n
    def graph(self, graphDetails):
        n = graphDetails.n
        g = graphs.HalfCube(n)
        graphDetails.graph = g  
        g.show()
   
        return g 

    # prints or returns a table of graph information with values of n from min_n to max_n using formulas
    def table_by_formulas(self, max_n, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, max_n + 1):

            alpha = "not finished"
            sigma = "not finished"
            deg = "not finished"

            row = [n_value, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t
        

# runs the code to get the out file
hc = HalfCubes()
hc.output_results(6,True,5,7)
︡fb4733d5-fb35-4c84-a505-4ee5616afd73︡{"file":{"filename":"/tmp/tmp_rnsan82/tmp_lzcdlu9w.svg","show":true,"text":null,"uuid":"156f432a-1cc3-4ac4-943c-5d6442bed3db"},"once":false}︡{"file":{"filename":"/tmp/tmp_rnsan82/tmp_20nf2udu.svg","show":true,"text":null,"uuid":"1ae530a8-ff2b-46a2-b3c9-f03391f4d642"},"once":false}︡{"file":{"filename":"/tmp/tmp_rnsan82/tmp_5g1bqdbn.svg","show":true,"text":null,"uuid":"288f080b-083e-47e5-9d5d-68360db0a136"},"once":false}︡{"file":{"filename":"/tmp/tmp_rnsan82/tmp_vqb9yd71.svg","show":true,"text":null,"uuid":"bf511e0e-35ad-42de-8fb0-69c0a83887fc"},"once":false}︡{"file":{"filename":"/tmp/tmp_rnsan82/tmp_kus3b7wm.svg","show":true,"text":null,"uuid":"018fc2c9-8f60-463b-a769-d7a4cf918d9b"},"once":false}︡{"stdout":"HalfCubesResults done"}︡{"stdout":"\n"}︡{"done":true}









