function [x, OUT ] = contraites()
    
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
         ];
     
     A3bis = [8 15 0 15 0 10
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
        % produit au minimum 75% de sa capacité max (déduite à partir de
        % f2)
         b3 = [4800 4800 4800 4800 4800 4800 4800 0 -123 -63 0 -15 -96 750 620 815];
    b3bis = [4800 4800 4800 4800 4800 4800 4800 0 0 0 0 0 0 750 620 815 -338.7646];

         
     f3 = [1 1 1 1 1 1] + mp1 + mp2 + mp3;
      f3bis = f3*[0 175.3128 90.0298 0 21.2314 136.8818]'
    
    % resultat f1
%      [x,OUT]=linprog(-f1,A,b);
%      disp(x)
%      disp(-OUT)

% resultat f2
%      [x,OUT]=linprog(-f2,A,b);
%      disp(x)
%      disp(-OUT)

% resultat f3
     [x,OUT]=linprog(f3,A3bis,b3bis);
     disp(x)
     disp(OUT)

end