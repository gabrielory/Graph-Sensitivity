# defines a function for getting any of the 10 graphs of small order at graphclasses.org with no isolated vertices: https://www.graphclasses.org/smallgraphs.html#nodes2

def get_h2(num):
    
    graph = Graph()
    
    if num == 1:
        graph = graphs.CompleteGraph(2)
        
    elif num == 2:
        graph = graphs.CompleteGraph(3)
        
    elif num == 3:
        graph = graphs.PathGraph(3)
        
    elif num == 4:
        graph = graphs.CompleteGraph(4)
        
    elif num == 5:
        graph = graphs.CycleGraph(4)
        graph.add_edge(0,2)
        
    elif num == 6:
        graph = graphs.CompleteGraph(3)
        graph.add_vertex(3)
        graph.add_edge(2,3)
        
    elif num == 7:
        graph = graphs.CycleGraph(4)
    
    elif num == 8:
        graph = graphs.StarGraph(3)
    
    elif num == 9:
        graph = graphs.PathGraph(4)
      
    elif num == 10:
        graph = graphs.CompleteGraph(5)
    
    return graph