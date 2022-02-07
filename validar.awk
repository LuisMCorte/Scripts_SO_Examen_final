#!/usr/bin/awk -f
BEGIN{
        FS=""
}
{
	suma=0
        for (j=1; j<10;j++){

	     if (j%2==0 ) {

         	suma=suma+$j 
	     }

             else{

	     	val= $j*2
 
             	if (val>9){
		corr= val-9
		suma = suma + corr
		}
		else{
		suma = suma + val
		}
     	     }

	}
	dec_sup = int(suma/10) + 1
	dec_sup = dec_sup*10
	cedula = dec_sup - suma
	if (cedula == $10){
	print $0	
	}
	else{
	print "Cédula inválida"
	}

}
END {

}
