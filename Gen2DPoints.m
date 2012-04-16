function [x,y] = Gen2DPoints( N,a,b,c,d )
    x=unifrnd ( a , b , [1,N] );%genereaza N puncte uniforme in intervalul [a,b] pseudo random
    y=unifrnd ( c , d , [1,N] );%genereaza N puncte uniforme in intervalul [c,d] pseudo random
end

