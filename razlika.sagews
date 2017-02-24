︠e82eb67a-6844-453e-8620-8b7dedc6df26s︠
import scipy.stats
from random import shuffle

G = graphs.CubeGraph(2)
b = 0
c = 0
k = 4
d = scipy.stats.binom(k, 0.5)

m=800
while m>0:
    vozlisca = G.vertices()
    shuffle(vozlisca)
    H = G.subgraph(vozlisca[:d.rvs()])
    if H.order()>0:
        b = b + 1
        p = MixedIntegerLinearProgram(maximization = True)
        y = p.new_variable(binary = True)

        for u in G.vertices():
            p.add_constraint(sum([y[u, v] for v in H.vertices()]) == 1)

        for v in H.vertices():
            p.add_constraint(y[v,v]==1)

        for u, v in G.edges(labels=False):
            for w, z in H.complement().edges(labels=False):
                p.add_constraint(y[u, w]+y[v, z]<=1)
                p.add_constraint(y[u, z]+y[v, w]<=1)

        for u, v in G.edges(labels=False):
            for z in H.vertices():
                p.add_constraint(y[u,z]+y[v,z]<=1)

        try:
            p = p.solve()
            #H.vertices()
            c = c + 1
        except:
            pass
    m = m - 1
abs((c/b)-0.6)
︡76b60f9e-9cdc-40c8-8f7c-de69483f4345︡{"stdout":"0.0252717391304348\n"}︡{"done":true}︡









