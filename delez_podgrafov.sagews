︠e7891c88-78b4-4b5c-86f8-a732f4be32dbs︠
n = 2
G = graphs.CubeGraph(n) # 3D hiperkocka
S = Subsets(G.vertices())

b = 0
c = 0

for s in S:
    if len(s) == 0:
        continue
    Gs = G.subgraph(s)
    b = b + 1
    p = MixedIntegerLinearProgram(maximization = True)
    y = p.new_variable(binary = True)

    for u in G.vertices():
        p.add_constraint(sum([y[u, v] for v in Gs.vertices()]) == 1)

    for v in Gs.vertices():
        p.add_constraint(y[v,v]==1)

    for u, v in G.edges(labels=False):
        for w, z in Gs.complement().edges(labels=False):
            p.add_constraint(y[u, w]+y[v, z]<=1)
            p.add_constraint(y[u, z]+y[v, w]<=1)

    for u, v in G.edges(labels=False):
        for z in Gs.vertices():
            p.add_constraint(y[u,z]+y[v,z]<=1)

    try:
        p = p.solve()
        #Gs.vertices()
        c = c + 1
    except:
        pass
c/b
︡01c01c9f-b056-4be7-b35e-4ed0d68d19bf︡{"stdout":"3/5\n"}︡{"done":true}︡









