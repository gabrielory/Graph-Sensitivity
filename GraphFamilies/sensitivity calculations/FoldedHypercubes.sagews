︠63e929c7-8f51-4dec-8f43-eaaf4ea394a2︠
attach('../OneVarGraphFamily.sage')
attach('../VTGraphFamily.sage')

# defines a class representing folded hypercube graphs that inherits from OneVarGraphFamily and VTGraphFamily
class FoldedHypercubes(OneVarGraphFamily, VTGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "FoldedHypercubes"
        self.min_n = 1
       
    # returns a folded hypercube graph with the current n
    def graph(self, graphDetails):
        
        n = graphDetails.n
        
        g = graphs.CubeGraph(n)
        
        for v in g.get_vertices():
           
            u = [(int(x) + 1) % 2 for x in list(v)]
            u = "".join(map(str, u))
            g.add_edge(v, u)
        
        graphDetails.graph = g
        g.show()
        print(g.edges(sort=True))
    
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
        

# run the code
fh = FoldedHypercubes()
fh.output_results(5, True, 2, 4)
︡4c30d7af-e6d0-41d1-997c-9f3eed707047︡{"file":{"filename":"/tmp/tmpqqed_8hl/tmp_3cialgfb.svg","show":true,"text":null,"uuid":"6a5d77bc-bc92-4f8f-8e9f-d0183bae1624"},"once":false}︡{"stdout":"[('0', '1', None)]"}︡{"stdout":"\n"}︡{"file":{"filename":"/tmp/tmpqqed_8hl/tmp_8g752khs.svg","show":true,"text":null,"uuid":"c06c8ca8-69e7-483d-8f84-dc78fb48ee05"},"once":false}︡{"stdout":"[('00', '01', None), ('00', '10', None), ('00', '11', None), ('01', '10', None), ('01', '11', None), ('10', '11', None)]\n"}︡{"file":{"filename":"/tmp/tmpqqed_8hl/tmp_flis35mw.svg","show":true,"text":null,"uuid":"8c301c21-570e-4d60-8326-9ec5ae191be3"},"once":false}︡{"stdout":"[('000', '001', None), ('000', '010', None), ('000', '100', None), ('000', '111', None), ('001', '011', None), ('001', '101', None), ('001', '110', None), ('010', '011', None), ('010', '101', None), ('010', '110', None), ('011', '100', None), ('011', '111', None), ('100', '101', None), ('100', '110', None), ('101', '111', None), ('110', '111', None)]"}︡{"stdout":"\n"}︡{"file":{"filename":"/tmp/tmpqqed_8hl/tmp_e041c5jf.svg","show":true,"text":null,"uuid":"9151eaa2-e7b8-42e1-8693-a1855ac8ccdd"},"once":false}︡{"stdout":"[('0000', '0001', None), ('0000', '0010', None), ('0000', '0100', None), ('0000', '1000', None), ('0000', '1111', None), ('0001', '0011', None), ('0001', '0101', None), ('0001', '1001', None), ('0001', '1110', None), ('0010', '0011', None), ('0010', '0110', None), ('0010', '1010', None), ('0010', '1101', None), ('0011', '0111', None), ('0011', '1011', None), ('0011', '1100', None), ('0100', '0101', None), ('0100', '0110', None), ('0100', '1011', None), ('0100', '1100', None), ('0101', '0111', None), ('0101', '1010', None), ('0101', '1101', None), ('0110', '0111', None), ('0110', '1001', None), ('0110', '1110', None), ('0111', '1000', None), ('0111', '1111', None), ('1000', '1001', None), ('1000', '1010', None), ('1000', '1100', None), ('1001', '1011', None), ('1001', '1101', None), ('1010', '1011', None), ('1010', '1110', None), ('1011', '1111', None), ('1100', '1101', None), ('1100', '1110', None), ('1101', '1111', None), ('1110', '1111', None)]"}︡{"stdout":"\n"}︡{"file":{"filename":"/tmp/tmpqqed_8hl/tmp_tjop9cs8.svg","show":true,"text":null,"uuid":"e0ce295c-e4fb-43a8-af1d-7c50a97e33d1"},"once":false}︡{"stdout":"[('00000', '00001', None), ('00000', '00010', None), ('00000', '00100', None), ('00000', '01000', None), ('00000', '10000', None), ('00000', '11111', None), ('00001', '00011', None), ('00001', '00101', None), ('00001', '01001', None), ('00001', '10001', None), ('00001', '11110', None), ('00010', '00011', None), ('00010', '00110', None), ('00010', '01010', None), ('00010', '10010', None), ('00010', '11101', None), ('00011', '00111', None), ('00011', '01011', None), ('00011', '10011', None), ('00011', '11100', None), ('00100', '00101', None), ('00100', '00110', None), ('00100', '01100', None), ('00100', '10100', None), ('00100', '11011', None), ('00101', '00111', None), ('00101', '01101', None), ('00101', '10101', None), ('00101', '11010', None), ('00110', '00111', None), ('00110', '01110', None), ('00110', '10110', None), ('00110', '11001', None), ('00111', '01111', None), ('00111', '10111', None), ('00111', '11000', None), ('01000', '01001', None), ('01000', '01010', None), ('01000', '01100', None), ('01000', '10111', None), ('01000', '11000', None), ('01001', '01011', None), ('01001', '01101', None), ('01001', '10110', None), ('01001', '11001', None), ('01010', '01011', None), ('01010', '01110', None), ('01010', '10101', None), ('01010', '11010', None), ('01011', '01111', None), ('01011', '10100', None), ('01011', '11011', None), ('01100', '01101', None), ('01100', '01110', None), ('01100', '10011', None), ('01100', '11100', None), ('01101', '01111', None), ('01101', '10010', None), ('01101', '11101', None), ('01110', '01111', None), ('01110', '10001', None), ('01110', '11110', None), ('01111', '10000', None), ('01111', '11111', None), ('10000', '10001', None), ('10000', '10010', None), ('10000', '10100', None), ('10000', '11000', None), ('10001', '10011', None), ('10001', '10101', None), ('10001', '11001', None), ('10010', '10011', None), ('10010', '10110', None), ('10010', '11010', None), ('10011', '10111', None), ('10011', '11011', None), ('10100', '10101', None), ('10100', '10110', None), ('10100', '11100', None), ('10101', '10111', None), ('10101', '11101', None), ('10110', '10111', None), ('10110', '11110', None), ('10111', '11111', None), ('11000', '11001', None), ('11000', '11010', None), ('11000', '11100', None), ('11001', '11011', None), ('11001', '11101', None), ('11010', '11011', None), ('11010', '11110', None), ('11011', '11111', None), ('11100', '11101', None), ('11100', '11110', None), ('11101', '11111', None), ('11110', '11111', None)]"}︡{"stdout":"\nFoldedHypercubesResults done"}︡{"stdout":"\n"}︡{"done":true}









