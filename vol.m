function [V1,V2] = vol( tol ,dirName)
    files = dir(dirName);
    fileIndex = find(~[files.isdir]);
    
    load(strcat(dirName,files(fileIndex(1)).name));
    f1=eval(strcat('heart',num2str(1)));
    %{
        "Metoda" pe care o folosesc considera suprafata de sus si suprafata de jos ca baza mica si baza mare a unui trunchi de piramida
        In continuare aplic formula aflarii unui volum de piramida V=(h/3)*(S1+S2+ sqrt(S1*S2))
    %}
    %incarc cele 2 matrici
    V=0;V2=0;%initiali
    %{
        Calculez la fiecare pas volumul dintre 2 suprafete alaturate
    %}
    n=length(f1);%lungimea vectoruluif1
    x1=f1(1:n,1);%elementele de pe prima coloana
    y1=f1(1:n,2);%functia in elementele de pe prima conoala...
    z1=f1(1,3);%coordonata pe axa normala
    S1=Trapez(x1,y1);%suprafata aflata cu metoda trapezului
    S11=MonteCarlo(x1,y1,tol);%suprafata cu metoda Monte Carlo
    
    load(strcat(dirName,files(fileIndex(2)).name));
    f1=eval(strcat('heart',num2str(2)));
    n=length(f1);
    x1=f1(1:n,1);
    y1=f1(1:n,2);
    z2=f1(1,3);
    S2=Trapez(x1,y1);
    S22=MonteCarlo(x1,y1,tol);

    h=abs(z2-z1);%distanta dintre cele 2 suprafete
    V=V+(h/3)*(S1+S2+sqrt(S1*S2));
    V2=V2+(h/3)*(S11+S22+sqrt(S11*S22));%volumele cu cele 2 metode
     
    for i=3:9
        load(strcat(dirName,files(fileIndex(i)).name));
        f1=eval(strcat('heart',num2str(i)));
        S1=S2;
        S11=S22;
        h=abs(z2-z1);
        z1=z2;
        n=length(f1);
        x1=f1(1:n,1);
        y1=f1(1:n,2);
        z2=f1(1,3);
        S2=Trapez(x1,y1);
        S22=MonteCarlo(x1,y1,tol);
        V=V+(h/3)*(S1+S2+sqrt(S1*S2));
        V2=V2+(h/3)*(S11+S22+sqrt(S11*S22));
    end
    V1=abs(V);
    V2=abs(V2);%rezutatele finale
end

