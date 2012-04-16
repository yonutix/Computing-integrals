function rez = Trapez( x,y ) 
    rez=abs(sum(((  x(2:length(x))  -  x(1:length(x)-1)  )./2)  .*  (  y(1:length(x)-1)  +  y(2:length(x))  ))); %aplic formula...
end

