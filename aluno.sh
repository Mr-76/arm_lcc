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
#Fix  grep -P "<b>LCC3-017.*?<br>" index.html
#012 exemplo nao eh class acoluna mas sim class linha

lccfind3(){

echo "<=====================================================$1===============================================>"


for i in $(seq -w 2 1 $2)
do

	if [[ "$1" == "LCC2" || "$1" == "LCC1" ]];then
		noleading0=$(expr $i + 0)
		echo "valor agora eh $noleading0"
		if [ "$i" -gt 10 ]; then
			i=$noleading0
		fi
	fi

	Aluno=$(grep -oP "<b>$1-$i.*?</b><br><br>" /home/solomonKANE/git/arm_lcc/index.html |
		grep -o '<b> Usuário(s) logado(s).*<br>' |
		grep -oP '<br>.*<br>'|
		sed 's/<br>//g'
	)


	
	isDOWN=$(grep -oP "<b>$1-$i.*?</b><br><br>" index.html | grep -oP "<b>$1-$i -.*N" | grep -oP '\- .*' | tr -d "-" | tr -d " ")

	
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


lccfind3 $lcc3String $nlcc3
lccfind3 $lcc2String $nlcc2andlcc1
lccfind3 $lcc1String $nlcc2andlcc1
rm index.html
