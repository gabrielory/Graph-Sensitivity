︠b91b152f-adcd-47e3-98c0-3a0a3dfcb194s︠
attach('../GraphFamily.sage')

# defines a class representing windmill graphs that inherits from GraphFamily
class WindmillGraphs(GraphFamily):
    def __init__(self):
        super().__init__()
        self.name = "WindmillGraphs"
        self.min_n = 2
        self.min_m = 1

    # returns a windmill graph with the current values for n and m
    def graph(self, graphDetails):

        m = graphDetails.m
        n = graphDetails.n

        # create K1
        k1 = graphs.CompleteGraph(1)

        # create Kn
        mkn = graphs.CompleteGraph(n)

        for count in range(m-1):

            kn = graphs.CompleteGraph(n)

            old_vertices = mkn.vertices()

            vertex_map = dict()
            for vertex in kn.vertices():

                vertex_map[vertex] = vertex + len(old_vertices)

            kn.relabel(vertex_map)

            mkn = mkn.disjoint_union(kn)

        windmill = k1.join(mkn)
        windmill.show()

        graphDetails.graph = windmill

        return windmill

    # prints or returns a table of graph information with values of n from 2 to n using formulas
    def table_by_formulas(self, max_n, m, print_table = False):

        t = [self.table_columns_2]

        for n_value in range(self.min_n, max_n + 1):

            alpha = m
            sigma = 1
            deg = n_value * m

            row = [n_value, m, deg, alpha, sigma]
            t.append(row)

        if print_table:
            print(self.name + ", n = " + str(max_n))
            print(table(t))
            print("\n\n")
        else:
            return t

# run the code
wg = WindmillGraphs()
wg.output_results(10, 7, True, 6, 8, 5, 7) 
︡03560eb2-abc0-4307-b539-0141e3853e98︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp__rbgjhcq.svg","show":true,"text":null,"uuid":"fa607d82-cb60-4a63-88eb-1440d0719064"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_04aewi1k.svg","show":true,"text":null,"uuid":"cf89fd82-aaa6-4089-b915-783e69f8e98b"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_1loix_uh.svg","show":true,"text":null,"uuid":"4ea79643-f017-4fac-86cd-3c60785c556b"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_whi0zkb4.svg","show":true,"text":null,"uuid":"088bc64b-8526-47e9-bf07-29928e288444"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_2hauevw4.svg","show":true,"text":null,"uuid":"0d0b7d47-5f3a-4e8f-89a9-47fda4d06c93"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_caremlzp.svg","show":true,"text":null,"uuid":"68158d1b-a903-47b2-9869-ac93d3d41d15"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_8zlmvh5_.svg","show":true,"text":null,"uuid":"5981eb3b-5cb7-4615-95d7-3daa7a9a4377"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_2nx2md4e.svg","show":true,"text":null,"uuid":"589a28a0-d7e9-486c-9b95-091f1690107f"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_ii_zxphe.svg","show":true,"text":null,"uuid":"8fa2c939-9c2a-4424-b282-6cd680342387"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_4mf0rn0i.svg","show":true,"text":null,"uuid":"a08b41e5-7770-42d8-864f-136ef248deaa"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_mn2iocz5.svg","show":true,"text":null,"uuid":"51fde3ea-fafe-4498-8480-81edbedac9f5"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_uf259t_n.svg","show":true,"text":null,"uuid":"efe389bf-e458-4fce-8fb5-e42827e23122"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_x1twh2df.svg","show":true,"text":null,"uuid":"c67e98b1-3be1-4267-ad97-7e2fcc0cc628"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_ie069t3f.svg","show":true,"text":null,"uuid":"57ef96a7-0214-4b97-adc7-cff4be3f3ec8"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_q79ereh1.svg","show":true,"text":null,"uuid":"68328fe6-6739-44c2-8914-7a264a7600e7"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_lz7ognej.svg","show":true,"text":null,"uuid":"2719c4d6-51b7-4c8e-a508-e4ab718f4cc4"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_09n7o1by.svg","show":true,"text":null,"uuid":"858ad13d-c1ad-4733-bf7a-adad41f3118a"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_cv6aj69j.svg","show":true,"text":null,"uuid":"b68690b2-237c-4878-b224-c2117f8c6096"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_qfqu5hfy.svg","show":true,"text":null,"uuid":"7d084d43-930c-450d-9a0d-eccb622ce76f"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_mxuwfh6u.svg","show":true,"text":null,"uuid":"9921c59b-abd0-4b57-8550-1e73ca0a19b1"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_j0o2_xie.svg","show":true,"text":null,"uuid":"9a4559b9-535b-4690-93cb-396901d16683"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_xljwzl3y.svg","show":true,"text":null,"uuid":"d5498ba3-2ba4-4790-8bce-9b5b40fd1c12"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_m98tbacb.svg","show":true,"text":null,"uuid":"df69108d-b2d8-4027-8026-3798d08737c5"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_w0uoyaoz.svg","show":true,"text":null,"uuid":"c2a79f9e-ba15-44bc-946a-c56f23d90a1c"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_g9khyd9w.svg","show":true,"text":null,"uuid":"6bc23514-f18e-4569-8f42-b4172efad6e9"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_dt0ers_h.svg","show":true,"text":null,"uuid":"2878015b-fa71-473d-b95b-63ea44231c76"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_317reu5o.svg","show":true,"text":null,"uuid":"cfb7f30c-81cb-4eb8-9730-415e0bbc0b91"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_1uuw7qss.svg","show":true,"text":null,"uuid":"aa1fd3fa-178e-4306-adf0-3e9543d14a4d"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_hdm4f41c.svg","show":true,"text":null,"uuid":"604bc6e0-80e4-4734-817c-c4fefdb63deb"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_tsffhu33.svg","show":true,"text":null,"uuid":"438143a5-c53d-4b45-9094-92ed5fbce238"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_av22hknx.svg","show":true,"text":null,"uuid":"57baecf1-5291-4a6a-93a8-ce238744530c"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_by5mcmsn.svg","show":true,"text":null,"uuid":"862229ae-9b4e-41f6-9623-ef3c60eaff43"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_61abl7t8.svg","show":true,"text":null,"uuid":"587183d8-67af-4e3c-a72f-55d7f582df04"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_ae6n_w4x.svg","show":true,"text":null,"uuid":"85d9bee7-a59d-45d1-83a5-35c1c01b56de"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_o8wx5xca.svg","show":true,"text":null,"uuid":"36645017-3599-4466-beee-c9716231e346"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_nwcfmbkl.svg","show":true,"text":null,"uuid":"c3021d4c-4fac-4564-a89a-dce585f50f6e"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_enw2ptao.svg","show":true,"text":null,"uuid":"4ffde377-0769-47af-bf6b-8ce1706a6d49"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_6f4oojel.svg","show":true,"text":null,"uuid":"e6a301ab-babb-4378-9af2-45262ed57b63"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_5ja5w6g6.svg","show":true,"text":null,"uuid":"af42486b-cd7d-4a39-af3f-c9d1a370d5ea"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_0ws26ela.svg","show":true,"text":null,"uuid":"24c096b4-cd60-4315-9c2a-cdd82523cadc"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_tal80r18.svg","show":true,"text":null,"uuid":"ea1f97dd-3b45-406d-a5a0-f2799178c2e8"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_f1_czkbf.svg","show":true,"text":null,"uuid":"3e8aee28-96c0-4db8-807b-3a6376e25d21"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_r2fo2jz4.svg","show":true,"text":null,"uuid":"7de71d08-4ee7-40c6-be9e-81bb632ce26b"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_8d82uo98.svg","show":true,"text":null,"uuid":"68b5c4e3-e4f3-4297-a43c-80f0fa31ac9d"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp__2t6f2xj.svg","show":true,"text":null,"uuid":"62b18c95-4930-4054-a331-37673828b302"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_573gycse.svg","show":true,"text":null,"uuid":"76f66fc5-2840-4a95-b976-c8a858e845ac"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_ajpavsf_.svg","show":true,"text":null,"uuid":"14ec2ae3-f566-498a-8b45-675a0cba37fc"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_oq76wyl3.svg","show":true,"text":null,"uuid":"08b06f0f-77c4-4cd8-98c4-8407f65de549"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_epskfl15.svg","show":true,"text":null,"uuid":"87aa98de-17e9-477c-955d-51419b343ecb"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_4cspb_10.svg","show":true,"text":null,"uuid":"63f348b6-4ced-45db-b8c1-46b57a45cb2a"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_ekpr2tv2.svg","show":true,"text":null,"uuid":"564bebdb-de74-480b-b819-b022561be19b"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_lvpjem1i.svg","show":true,"text":null,"uuid":"30634b5c-63f9-44cb-920a-4eb7a471dd6b"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_ho1r196v.svg","show":true,"text":null,"uuid":"09748386-3cb5-49dc-9843-3074c7def5f5"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_zo06z1f9.svg","show":true,"text":null,"uuid":"edac6300-aa2a-4adc-a160-4c0729639e7e"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_9_tqwuuf.svg","show":true,"text":null,"uuid":"02e184d9-b385-4973-b450-57ffee726164"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_loclofhf.svg","show":true,"text":null,"uuid":"18bfc820-2ca6-49a8-80ba-c4e409fd7be1"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_vr023xk6.svg","show":true,"text":null,"uuid":"48aa991a-646c-4b44-a345-86dc5d97bf31"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_6qar1f4h.svg","show":true,"text":null,"uuid":"56c4482a-77db-486e-be89-8256dbfba3e7"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_9zww0i5h.svg","show":true,"text":null,"uuid":"409576eb-6f9d-4a5f-bdc4-5404511fe8ac"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_0ai4dmaw.svg","show":true,"text":null,"uuid":"8567bc06-d3fd-44de-bca3-b50b068f81c2"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_ngc5fipp.svg","show":true,"text":null,"uuid":"0969fdc9-6255-4ef7-84ec-a819b2f6c521"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp__zvxfa7j.svg","show":true,"text":null,"uuid":"bbc61265-4249-4fb2-97e1-5f7270706919"},"once":false}︡{"file":{"filename":"/tmp/tmp9pth4y_3/tmp_cafxgey3.svg","show":true,"text":null,"uuid":"7d6d8003-c6a6-436d-8808-b335d20b5ced"},"once":false}︡{"stdout":"WindmillGraphsResults done"}︡{"stdout":"\n"}︡{"done":true}









