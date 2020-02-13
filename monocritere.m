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
     ];
b = [4800 4800 4800 4800 4800 4800 4800 0 0 0 0 0 0 750 620 815];


fonctionComptable = -(3*mp1+4*mp2+2*mp3) -(2*m1 + 2*m2 + m3+m4+2*m5+3*m6+3*m7)/60 + [55 47 60 45 35 50];
% comptable(A,b,fonctionComptable);

fonctionRespAtelier = [1 1 1 1 1 1];
% respAtelier(A,b,fonctionRespAtelier);

fonctionRespStock = [1 1 1 1 1 1] + mp1 + mp2 + mp3;
% [~,NbFabMax] = respAtelier(A,b,fonctionRespAtelier);
% respStock(fonctionRespStock,NbFabMax);

% respCommercial ?

fonctionRespPersonnel = m2+m7;
respPersonnel(fonctionRespPersonnel,fonctionComptable,m2,m7);

% d'après la documentation,
% la première sortie de linprog correspond au min de f'*X (X vecteur des variables)
% la deuxième correspond à f'*x (le même x défini plus haut)

function [X, Benef] = comptable(A,b,f)
     % -f car on cherche à maximiser le bénéfice
     [X,Benef]=linprog(-f,A,b);
     disp(X)
     disp(-Benef)
end
function [X, NbFab] = respAtelier(A,b,f)
     % -f car on cherche à maximiser le nb de fabrications
     [X,NbFab]=linprog(-f,A,b);
     disp(X)
     disp(-NbFab)
end
function [X, NbStock] = respStock(f, NbFabMax)
    % nouvelle contrainte : l'entreprise considéré en activité si elle
    % produit au minimum 75% de sa capacité max de fabrication
    % contrainte modèlisée par l'inégalité suivamte : 
    % A*b >= nbFabMax*tauxActivite
    tauxActivite = 0.75;
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
         -1 -1 -1 -1 -1 -1
         ];
     b = [4800 4800 4800 4800 4800 4800 4800 0 0 0 0 0 0 750 620 815 tauxActivite*NbFabMax];
     
     [X,NbStock]=linprog(f,A,b);
     disp(X)
     disp(NbStock)
     % f3bis = f3*[0 175.3128 90.0298 0 21.2314 136.8818]';
     % disp(f3bis); calcul du stock à partir de la capacité max de
     % fabrication sans nouvelle contrainte
end
function [X, NbFab] = respPersonnel(fRespPersonnel,fComptable,m2,m7)
    Benefice = zeros(75);
    Machine2 = zeros(75);
    Machine7 = zeros(75);
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
         -fComptable];

    for i = 1:1:75
    b = [4800 3300 4800 4800 4800 4800 3300 0 0 0 0 0 0 750 620 815 -i*15570/100];

     [X,NbFab]=linprog(fRespPersonnel,A,b);
     Benefice(i) = fComptable*X;
     Machine2(i) = m2*X;
     Machine7(i) = m7*X;
    end
    figure(1)
    plot(Benefice,Machine7+Machine2)
    legend('Bénéfice de Machine 2 et Machine 7')

    figure(2)
    plot(Benefice,Machine2)
    hold on
    plot(Benefice,Machine7)

    legend('Bénéfice de Machine 2', 'Bénéfice de Machine 7')
    hold off
end

