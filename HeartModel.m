function   HeartModel(dirName,eps)

files = dir(dirName);%lista directorului
fileIndex = find(~[files.isdir]);%index cu toate fisierele din director

for i = 1:length(fileIndex) %de la 1 la numarul de fisiere din folder
load(strcat(dirName,files(fileIndex(i)).name));%incarca fisierele din primul fisier -- strcat concateneaza adresa directorului cu numele fisierului
f1=eval(strcat('heart',num2str(i)));%f1 transforma stringul in variabila
fprintf('%.3f ',Trapez(f1(1:length(f1),1),f1(1:length(f1),2)));%afiseaza pe un rand suprafetele calculate prin metoda trapezului
end

fprintf('\n');%newline

for i = 1:length(fileIndex)
load(strcat(dirName,files(fileIndex(i)).name));
f1=eval(strcat('heart',num2str(i)));
fprintf('%.3f ',MonteCarlo(f1(1:length(f1),1),f1(1:length(f1),2),eps));%afiseaza pe un rand suprafetele calculate cu metoda Monte Carlo
end

fprintf('\n');%newline

[V1,V2]=vol(eps,dirName);%calculeaza volumele prin cele 2 metode
fprintf('%.3f ',V1);%V1 Volumul calculat prin metoda trapezelor
fprintf('%.3f ',V2);%V2 Volumul calculat prin metoda Monte Carlo
fprintf('\n');

end

