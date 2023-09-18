#!/bin/bash


#Mr-76 A.K.A Careca
#Script para pegar alunos do lcc's por maquina

nlcc3=120
reeng=61
nlcc2andlcc1=56

lcc3String="LCC3"
lcc2String="LCC2"
lcc1String="LCC1"
reengString=""




wget --no-check-certificate https://lcc.ufcg.edu.br/

#grep -oP 'LCC3-017.*?class="coluna"' index.html | grep -oP '<b>LCC3-017 -.*N' | grep -oP '\- .*' | tr -d "-"

lccFind(){

	
echo "<=====================================================$1===============================================>"
for i in $(seq -w 2 1 $2)
do

	Aluno=$(grep -oP "$1-$i.*?class=\"coluna\"" /home/solomonKANE/git/arm_lcc/index.html |
		grep -o '<b> Usuário(s) logado(s).*<br>' |
		grep -oP '<br>.*<br>'|
		sed 's/<br>//g'
	)


	
	isDOWN=$(grep -oP "$1-$i.*?class=\"coluna\"" index.html | grep -oP "<b>$1-$i -.*N" | grep -oP '\- .*' | tr -d "-" | tr -d " ")

	
	if [ "$isDOWN" == "DOWN" ];then
		echo "maquina $i is DOWN"
		continue
	fi

	if [ "$Aluno" == "" ]; then

		echo "maquina $1-$i com ninguem "
		continue
	fi

	echo "maquina Lcc3-$i com aluno $Aluno"
done

}


lccFind $lcc3String $nlcc3
lccFind $lcc2String $nlcc2andlcc1
lccFind $lcc1String $nlcc2andlcc1
rm index.html
