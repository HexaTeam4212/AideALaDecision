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

% A et b pour la modélisation des contraintes
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
     1 0 0 0 0 0
     0 1 0 0 0 0
     0 0 1 0 0 0
     ];
b = [4800 4800 4800 4800 4800 4800 4800 0 0 0 0 0 0 750 620 815 0 0 0];
%Ajout de trois contraintes pour annuler les produits A, B et C et ainsi
%maximiser la famille D,E,F on pourrait faire de m�me pour la famille
% A,B, C en d�calant les 1 de 3 colonnes vers la droites

% On utilise cette fonction afin de maximiser D,E,F au vu des 
%contraintes ajout�es sur A et b 
fonctionRespAtelier = [1 1 1 1 1 1];
respAtelier(A,b,fonctionRespAtelier);



% respCommercial(A,b,fonctionComptable,fonctionRespAtelier);
% d'après la documentation,
% la première sortie de linprog correspond au min de f'*X (X vecteur des variables)
% la deuxième correspond à f'*x (le même x défini plus haut)

function [X, NbFab] = respAtelier(A,b,f)
     % -f car on cherche à maximiser le nb de fabrications
     [X,NbFab]=linprog(-f,A,b);
     disp(X)
     disp(-NbFab)
end
