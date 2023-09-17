#!/bin/bash
#grep -oP 'LCC3-$i.*?class="coluna"' index.html | grep  -o '<b> Usuário(s) logado(s).*<br>' novo.html | grep -oP '<br>.*<br>' | tr -d '<br>'


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

lccFind(){

	
echo "<=====================================================$1===============================================>"
for i in $(seq -w 2 1 $2)
do

	Aluno=$(grep -oP "$1-$i.*?class=\"coluna\"" /home/solomonKANE/git/arm_lcc/index.html |
		grep -o '<b> Usuário(s) logado(s).*<br>' |
		grep -oP '<br>.*<br>'|
		sed 's/<br>//g'
	)

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





