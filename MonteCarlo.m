function I = MonteCarlo( x, y, tol )
    n = length(x);
    %{
        -Mai intai aflam domeniul pe care e definit cel mai mic patrat.
        -Il largim cu marimea tolerantei pentru evitarea cazului in care curba inchisa
    e definita pe marginea patratului intrucat un punct ales aleator pe marginea 
    patratului desi ar fi in exterior ar intersecta o singura data marginea curbei si s-ar pune ca punct interior
    %}
    fmin = min(y);
    fmax = max(y);
    xmin = min(x);
    xmax = max(x);

    A = ( fmax - fmin ) * ( xmax - xmin );%aria patratului

    %{
    Prima data luam un numar de 8 puncte aleatoare in interiorul patratului
    %}
    m = 8;
    [pctx2 , pcty2]=Gen2DPoints(m, xmin, xmax, fmin, fmax);%generez punctele aleatoare

    int = 0;%numarul de puncte din interior initializat cu 0
    for i = 1:m%verificare in toate punctelele alese aleator
        nr = 0; %initializare numar intersesctie dreapta cu marginea dreptunghiului si initializare puncte din interior
        for j = 1:n-1
            %{
            Initial avem 4 puncte :
                -punctul ales aleator si punctul dintr-un colt al patratului(Trebuia un punct de pe marginea dreptunghiului) 
                care determina o dreapta;
                -2 puncte alaturate de pe curba.Curba fiind reprezentata printr-un numar finit de puncte
                trebuie interpolata(Eu o interpolez liniar)ca nu cumva dreapta 1 sa treaca printre punctele curbei fara sai fie
                contorizata
                -Trebuie verificat daca punctul de intersectie se afla pe unul din cele 2 segmente determinate de cele 4 puncte
            %}
            if ( intersectie( pctx2(i) , pcty2(i) , xmax , fmax , x(j) , y(j) , x(j+1) , y(j+1))  )   nr=nr+1;%daca cele 2 segmente se intersecteaza nr creste
            end
        end
        if( mod(nr,2) == 1 ) int = int + 1;%daca numarul de intersectii e impar punctul de afla in interior
        end
    end 
    S1 = A * int / m;%produsul dintre aria patratului si raportul dintre punctele din interior si punctele totale

    
    
    %{
    A doua oara dublam numarul de puncte aleatoare din interiorul patratului
    %}
    m = 16;
    [pctx2 , pcty2]=Gen2DPoints(m, xmin, xmax, fmin, fmax);%generez punctele aleatoare
 
    int = 0;%numarul de puncte din interior initializat cu 0
    for i = 1:m%verificare in toate punctelele alese aleator
        nr = 0; %initializare numar intersesctie dreapta cu marginea dreptunghiului si initializare puncte din interior
        for j = 1:n-1
            %{
            Initial avem 4 puncte :
                -punctul ales aleator si punctul dintr-un colt al patratului(Trebuia un punct de pe marginea dreptunghiului) 
                care determina o dreapta;
                -2 puncte alaturate de pe curba.Curba fiind reprezentata printr-un numar finit de puncte
                trebuie interpolata(Eu o interpolez liniar)ca nu cumva dreapta 1 sa treaca printre punctele curbei fara sai fie
                contorizata
                -Trebuie verificat daca punctul de intersectie se afla pe unul din cele 2 segmente determinate de cele 4 puncte
            %}
            if ( intersectie( pctx2(i) , pcty2(i) , xmax , fmax , x(j) , y(j) , x(j+1) , y(j+1))  )   nr=nr+1;%daca cele 2 segmente se intersecteaza nr creste
            end
        end
        if( mod(nr,2) == 1 ) int = int + 1;%daca numarul de intersectii e impar punctul de afla in interior
        end
    end 
    S2 = A * int / m;%produsul dintre aria patratului si raportul dintre punctele din interior si punctele totale
 
    while( S2-S1 > tol || S2-S1==0)%cat timp diferenta dintre S1 si S2 e diferita de 0 si mai mare ca tol 
        S1 = S2;
        m = m * 2;
        [pctx2 , pcty2] = Gen2DPoints( m , xmin , xmax , fmin , fmax );
        a = zeros( 1 , m ); b = zeros( 1 , m );
        int = 0;
        for i = 1:m%verificare in toate punctelele alese aleator
            nr = 0; %initializare numar intersesctie dreapta cu marginea dreptunghiului si initializare puncte din interior
            for j = 1:n-1
                if ( intersectie( pctx2(i) , pcty2(i) , xmax , fmax , x(j) , y(j) , x(j+1) , y(j+1))   )  nr = nr+1;%verifica daca punctul se afla pe cele 2 segmente
                end
            end
            if( mod( nr , 2) == 1) int = int+1;%daca numarul de intersectii e impar punctul de afla in interior
            end
        end 
        
        
        S2=A*int/m;%produsul dintre aria patratului si raportul dintre punctele din interior si punctele totale
    end
    I=S2;  
end

function rez = intersectie( x1,y1,x2,y2,x3,y3,x4,y4)
    if(x2 == x1 || x3==x4)
       rez=0;
       return;
    end
    a1=(y2-y1)/(x2-x1);
    b1=y1-x1*(y2-y1)/(x2-x1);
    %^Ecuatia primei drepte
    a2=(y4-y3)/(x4-x3);
    b2=y3-x3*(y4-y3)/(x4-x3);
    %^Ecuatia celei de-a 2-a drepte
    x=(b1-b2)/(a2-a1);
    y=b1+a1*(b1-b2)/(a2-a1);
    %^Aflarea punctului de intersectie
    
    if(x<=max(x1,x2) && x<=max(x3,x4) && x>=min(x1,x2) && x>=min(x3,x4) && y<=max(y1,y2) && y<=max(y3,y4) && y>=min(y1,y2) && y>=min(y3,y4))
        rez=1;
    else 
        rez=0;
    end
end