function [x, OUT ] = fonctionsObjectifs()
    
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
         
    min_f = [-1 -1 -1 -1 -1 -1];



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


    f1 = -(3*mp1+4*mp2+2*mp3) -(2*m1 + 2*m2 + m3+m4+2*m5+3*m6+3*m7)/60 + [55 47 60 45 35 50]; %mettre -f1
    f2 = [1 1 1 1 1 1]; %mettre -f2
    
    %on rajoute une contrainte pour simuler que l'entreprise soit en
    %activité
     
     A3 = [8 15 0 15 0 10
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
     
        % nouvelle contrainte : l'entreprise considéré en activité si elle
        % produit au minimum 75% de sa capacité max 
    b3 = [4800 4800 4800 4800 4800 4800 4800 0 0 0 0 0 0 750 620 815 -296.4191];

         
     f3 = [1 1 1 1 1 1] + mp1 + mp2 + mp3;
     % f3bis = f3*[0 175.3128 90.0298 0 21.2314 136.8818]';
     %disp(f3bis);
    
      % d'après la documentation,
      % x correspond au min de f'*X (X vecteur des variables)
      % OUT correspond à f'*x (le même x défini plus haut)
      
% resultat f1
%      [x,OUT]=linprog(-f1,A,b);
%      disp(x)
%      disp(-OUT)

% resultat f2
%      [x,OUT]=linprog(-f2,A,b);
%      disp(x)
%      disp(-OUT)

% resultat f3
     [x,OUT]=linprog(f3,A3,b3); 
     disp(x)
     disp(OUT)
     
    % responsable du personnel
     
    Benefice = [];
    Machine2 = [];
    Machine7 = [];
    for i = 1:1:75

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


        f1 = -(3*mp1+4*mp2+2*mp3) -(2*m1 + 2*m2 + m3+m4+2*m5+3*m6+3*m7)/60 + [55 47 60 45 35 50]; %mettre -f1
        f2 = [1 1 1 1 1 1]; %mettre -f2

        A5 = [8 15 0 15 0 10
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
             -f1];

        b5 = [4800 3300 4800 4800 4800 4800 3300 0 0 0 0 0 0 750 620 815 -i*15570/100];

        Aeq = [ 1 1 1 -1 -1 -1];

        beq = [0];

        f5 = m2+m7;

         [x,OUT]=linprog(f5,A5,b5);
         Benefice(i) = f1*x;
         Machine2(i) = m2*x;
         Machine7(i) = m7*x;
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