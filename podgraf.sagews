︠0374e836-55eb-45be-bdb8-f590093f3f76s︠
n = 3
G = graphs.CubeGraph(n) # 3D hiperkocka
H = G.subgraph(v for v in G if v not in ['000','010']) # podgraf brez nastetih vozlisc

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
    print("Ta podgraf je retrakt hiperkocke")
except:
    print("Ta podgraf ni retrakt hiperkocke")
︡050c860a-3da3-4d3a-861a-57d7e5529900︡{"stdout":"Ta podgraf je retrakt hiperkocke\n"}︡{"done":true}︡










