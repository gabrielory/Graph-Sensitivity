︠03998464-0520-47b1-862c-7c48843956ees︠
attach('../OneVarGraphFamily.sage')

# defines a class representing crown graphs that inherits from OneVarGraphFamily
class CrownGraphs(OneVarGraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "CrownGraphs"
        self.min_n = 2

    # returns a crown graph with the current n
    def graph(self, graphDetails):
        n = graphDetails.n

        kn = graphs.CompleteGraph(n)
        k2 = graphs.CompleteGraph(2)

        crown = kn.tensor_product(k2)

        graphDetails.graph = crown
        crown.show()

        return crown

    # prints or returns a table of graph information with values of n from 2 to n using formulas
    def table_by_formulas(self, max_n, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, max_n + 1): # must be non-empty, so start n at 2

            alpha = n_value
            sigma = math.floor(n_value/2)
            deg = n_value-1

            row = [n_value, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t


# run the code
cg = CrownGraphs()
cg.output_results(10, True)
︡39da2cc1-fa34-43e8-ada1-31fa57bbd3f0︡{"file":{"filename":"/tmp/tmphfrekxhe/tmp_f7ma9hzc.svg","show":true,"text":null,"uuid":"5c9b5e34-83a1-4c0a-a9ec-f85b73c8f5d0"},"once":false}︡{"file":{"filename":"/tmp/tmphfrekxhe/tmp_oj879091.svg","show":true,"text":null,"uuid":"521c0de8-5e09-4daa-8679-2deb613c3053"},"once":false}︡{"file":{"filename":"/tmp/tmphfrekxhe/tmp_mvomp74v.svg","show":true,"text":null,"uuid":"aeceac67-cae4-46f1-99b5-4ad9715fea7b"},"once":false}︡{"file":{"filename":"/tmp/tmphfrekxhe/tmp_r_su8mvy.svg","show":true,"text":null,"uuid":"0a5e499c-0191-469d-a777-38b770843fa4"},"once":false}︡{"file":{"filename":"/tmp/tmphfrekxhe/tmp_k95sqs7x.svg","show":true,"text":null,"uuid":"2e763075-5ec2-4b85-86bb-125e159b1344"},"once":false}︡{"file":{"filename":"/tmp/tmphfrekxhe/tmp_wg1r_6sm.svg","show":true,"text":null,"uuid":"4465b81d-7ad0-4e2b-860c-008bb44f73ab"},"once":false}︡{"file":{"filename":"/tmp/tmphfrekxhe/tmp_c3u33h52.svg","show":true,"text":null,"uuid":"7f0b07cf-fc9b-45ca-b7f4-5f61f934b592"},"once":false}︡{"file":{"filename":"/tmp/tmphfrekxhe/tmp_2h4eyxcv.svg","show":true,"text":null,"uuid":"e11251e3-2621-4401-a97a-22b91bdafe1e"},"once":false}︡{"file":{"filename":"/tmp/tmphfrekxhe/tmp_1pbe93d8.svg","show":true,"text":null,"uuid":"648d9a63-6182-4453-88c9-866552823509"},"once":false}︡{"stdout":"CrownGraphsResults done"}︡{"stdout":"\n"}︡{"done":true}
︠660839bc-0c00-4468-9104-8bb17b15065cs︠

︡829d65bb-35a0-46f7-bae7-99db0fd8dbf8︡{"done":true}









