︠b22cbf75-6343-4ced-a615-226fd4052342s︠
#%time
import scipy.stats
from random import shuffle

n = 2
G = graphs.CubeGraph(n)
b = 0
c = 0
k = 2^n
d = scipy.stats.binom(k, 0.5)

m=200
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
(c/b)
︡c85feefa-9584-4def-817e-7740941924d6︡{"stdout":"115/187\n"}︡{"done":true}︡









