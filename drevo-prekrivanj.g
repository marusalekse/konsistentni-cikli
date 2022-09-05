LoadPackage("digraphs");

# gamma := [[2, 3, 4, 5], [1, 3, 4, 5], [1, 2, 4, 5], [1, 2, 3, 5], [1, 2, 3, 4]];
# G := AutomorphismGroup(Digraph(gamma));

drevoPrekrivanj := function (gamma, G)
  local G, T, v, u, P, G_v, G_u, S, R, P_, R_, S_, p, N, r, s, p_2, g, X_g, r_i, w, O, p_, r_, s_;


  T := [];

  v := 1;
  u := gamma[1][1];
  P := [[v, u]];

  G_v := Stabilizer(G, v);
  G_u := Stabilizer(G_v, u);

  S := [G_u];
  R := [gamma[v]];

  while P <> [] do
    P_ := [];
    R_ := [];
    S_ := [];

    for i in [1..Length(P)] do
      p := P[i];
      v := p[Length(p)];
      N := gamma[v];
      r := R[i];
      s := S[i];

      for u in N do
        p_2 := Concatenation([p{[2..Length(p)]}, [u]]);
        g := RepresentativeAction(G, p, p_2, OnTuples);

        if g <> fail then
          break;
        fi;
      od;
      
      X_g := [];

      for r_i in r do
        if Position(X_g, r_i^g) = fail then
          Append(X_g, [r_i^g]);
        fi;
      od;


      while X_g <> [] do
        w := X_g[1];
        O := [];
        for s_i in s do
          # Print(w, " ",s_i, " ", w^s_i, "\n");
          if Position(O, w^s_i) = fail then
            Append(O, [w^s_i]);
          fi;
        od;
        # Print(X_g, " ", O, "\n");

        l := Size(O);

        if l = 1 then
          p_ := Concatenation([p, [w]]);
          Append(T, [p_]);
          Remove(X_g, Position(X_g, w));
        else
          p_ := Concatenation(p, [w]);
          r_ := O;
          s_ := Stabilizer(s, w);
          Append(R_, [r_]);
          Append(S_, [s_]);
          Append(P_, [p_]);

          # Print(O);
          for O_i in O do
            Remove(X_g, Position(X_g, O_i));
          od;
        fi;
      od;
    od;
    P := P_;
    R := R_;
    S := S_;
  od;

  return T;
end;