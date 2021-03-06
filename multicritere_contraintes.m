       

mp1 = [1 2 1 1 1 2];
mp2 = [2 2 1 2 2 1];
mp3 = [1 0 3 2 2 0];
m1 = [8 15 0 15 0 10];
m2 = [17 11 12 15 7 12];
m3 = [8 1 11 0 10 25];
m4 = [2 10 5 4 13 7];
m5 = [15 0 0 7 10 25];
m6 = [15 5 3 12 8 0];
m7 = [15 13 15 18 10 7];

% A et b pour la mod�lisation des contraintes
A = [8 15 0 15 0 10
     17 11 12 15 7 12
     8 1 11 0 10 25
     2 10 5 4 13 7
     15 0 0 7 10 25
     15 5 3 12 8 0
     15 13 15 18 10 7
     -1 0 0 0 0 0
     0 -1 0 0 0 0
     0 0 -1 0 0 0
     0 0 0 -1 0 0
     0 0 0 0 -1 0
     0 0 0 0 0 -1
     1 2 1 1 1 2
     2 2 1 2 2 1
     1 0 3 2 2 0];
b = [4800 4800 4800 4800 4800 4800 4800 0 0 0 0 0 0 750 620 815];

fonctionComptable = -(3*mp1+4*mp2+2*mp3) -(2*m1 + 2*m2 + m3+m4+2*m5+3*m6+3*m7)/60 + [55 47 60 45 35 50];
fonctionRespAtelier = [1 1 1 1 1 1];
fonctionRespStock = [1 1 1 1 1 1] + mp1 + mp2 + mp3;
[~,NbFabMax] = respAtelier(A,b,fonctionRespAtelier);
respStock2(fonctionRespStock,NbFabMax,fonctionComptable);



% d'apr�s la documentation,
% la premi�re sortie de linprog correspond au min de f'*X (X vecteur des variables)
% la deuxi�me correspond � f'*x (le m�me x d�fini plus haut)


function [X, NbFab] = respAtelier(A,b,f)
     % -f car on cherche � maximiser le nb de fabrications
     [X,NbFab]=linprog(-f,A,b);
     disp(X)
     disp(-NbFab)
end
function [X, NbStock] = respStock2(f, NbFabMax, fComptable)
    % nouvelle contrainte : 
    m2 = [17 11 12 15 7 12];
    m7 = [15 13 15 18 10 7];
    
    A = [8 15 0 15 0 10
         17 11 12 15 7 12
         8 1 11 0 10 25
         2 10 5 4 13 7
         15 0 0 7 10 25
         15 5 3 12 8 0
         15 13 15 18 10 7
         -1 0 0 0 0 0
         0 -1 0 0 0 0
         0 0 -1 0 0 0
         0 0 0 -1 0 0
         0 0 0 0 -1 0
         0 0 0 0 0 -1
         1 2 1 1 1 2
         2 2 1 2 2 1
         1 0 3 2 2 0
         -fComptable
         ];
     b = [4800 3800 4800 4800 4800 4800 3800 0 0 0 0 0 0 750 620 815 -11075 ];
     % modification des contraintes sur les temps machines m2 et m7
     % ajout d'une contrainte sur le b�n�fice
     
     [X,NbStock]=linprog(f,A,b);
     disp(X) % quantit� de produits finis
     disp(fComptable*X)
     disp(m2*X) % temps machine2
     disp(m7*X)% temps machine 7
     disp(NbStock)% Nb stock
end

