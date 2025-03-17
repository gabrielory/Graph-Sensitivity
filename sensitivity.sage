# copy of Davis's sensitivity code

import sys
from sage.groups.perm_gps.permgroup_element import make_permgroup_element


# independence number of a graph
def alpha(g):
    return len(g.independent_set())

# maximum degree of a graph's vertices
def max_degree(g):
    return max(g.degree())

# minimum degree of a graph's vertices
def min_degree(g):
    return min(g.degree())

sigma = sys.maxsize
sigma2 = 0

# iterates through all vertex subsets of a certain size,
# calculates their max degree, and updates the global minimum variable (sigma)
def iterateSubsetsMin(g, data, start, end, i, size):
    global sigma

    if i == size:
        maxDegree = max_degree(g.subgraph(vertices = data))
        if (maxDegree < sigma):
            sigma = maxDegree
        return

    j = start
    while (j <= end) and (end - j + 1 >= size - i):
        data[i] = list(g.get_vertices())[j]
        iterateSubsetsMin(g, data, j + 1, end, i + 1, size)
        j += 1

# iterates through all vertex subsets of a certain size,
# calculates their min degree, and updates the global maximum variable (sigma2)
def iterateSubsetsMax(g, data, start, end, i, size):
    global sigma2

    if i == size:
        minDegree = min_degree(g.subgraph(vertices = data))
        if (minDegree > sigma2):
            sigma2 = minDegree
        return

    j = start
    while (j <= end) and (end - j + 1 >= size - i):
        data[i] = list(g.get_vertices())[j]
        iterateSubsetsMax(g, data, j + 1, end, i + 1, size)
        j += 1

# computes the sensitivity of a graph
def sensitivity(g):
    global sigma

    print(g)
    a = alpha(g)
    data = [None] * (a + 1)
    sigma = sys.maxsize
    iterateSubsetsMin(g, data, 0, g.order() - 1, 0, a + 1)
    return 0 if sigma == sys.maxsize else sigma

# computes the sensitivity using max of min degree and clique number
def sensitivity2(g):
    global sigma2

    o = g.clique_number()
    data = [None] * (o + 1)
    sigma2 = 0
    iterateSubsetsMax(g, data, 0, g.order() - 1, 0, o + 1)
    return sigma2










