def corona_product(G, H):
        
        k1vH = graphs.CompleteGraph(1).join(H)
        k1vH.relabel(range(k1vH.num_verts()))
        
        for v in G.vertices():
            
            k1vH_copy = k1vH
            
            # fix vertex labels
            old_vertices = k1vH.vertices()
            vertex_map = dict()
            
            for vertex in k1vH.vertices():
                vertex_map[vertex] = vertex + len(old_vertices) + G.num_verts()
            
            k1vH_copy.relabel(vertex_map)

            G.add_vertices(k1vH_copy.vertices())
            G.add_edges(k1vH_copy.edges())
            
            for neighbor in G.neighbors(v):
                G.add_edge(k1vH_copy.vertices()[0], neighbor)
            G.delete_vertex(v)
        
        G.relabel(range(G.num_verts()))
        return G
  