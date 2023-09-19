#!/bin/bash


nlcc3=120

lcc3String="LCC3"




wget --no-check-certificate https://lcc.ufcg.edu.br/

#grep -oP 'LCC3-017.*?class="coluna"' index.html | grep -oP '<b>LCC3-017 -.*N' | grep -oP '\- .*' | tr -d "-"

lccFind(){

index_value=0

for i in {1..120}; do
    machine=$(printf "%03d" $i)
    machines+=("$machine")  # Add the machine name to the array
done



isDownN=0
isNotDownWithAluno=0
isNotDownWithNoAluno=0

GREEN='\033[0;32m'


	
echo "<===========================================================================$1===========================================================================>"
for i in $(seq -w 01 $2)
do
	Aluno=$(grep -oP "$1-$i.*?class=\"coluna\"" index.html |
		grep -o '<b> Usuário(s) logado(s).*<br>' |
		grep -oP '<br>.*<br>'|
		sed 's/<br>//g'
	)
	isDOWN=$(grep -oP "$1-$i.*?class=\"coluna\"" index.html | grep -oP "<b>$1-$i -.*N" | grep -oP '\- .*' | tr -d "-" | tr -d " ")

	
	if [ "$isDOWN" == "DOWN" ];then
		isDownN=$((isDownN + 1))
		machines[index_value]="${machines[index_value]}D"
		index_value=$((index_value+1))
		continue
	fi

	if [ "$Aluno" == "" ]; then
		isNotDownWithNoAluno=$((isNotDownWithNoAluno + 1))
		machines[index_value]="${machines[index_value]}O"
		index_value=$((index_value+1))
		continue
	fi

	isNotDownWithAluno=$((isNotDownWithAluno + 1))
	machines[index_value]="${machines[index_value]}U"
	index_value=$((index_value+1))


done

j=119
loopvar=1
loopvar2=1
for i in $(seq 1 1 10); do
	
	
	if ((loopvar == 6)); then
		echo "																
																	
																		
													
		"
	fi
	if ((loopvar % 2 == 0)); then
		final=$((j+11))
		echo " _______      ______      ______      ______      ______      ______		      ______      ______      ______      ______      ______      ______"
		echo "|      |      |    |      |    |      |    |      |    |      |    |      	      |    |      |    |      |    |      |    |      |    |      |    |"
		echo "|${machines[j]}  |      |${machines[j+1]}|      |${machines[j+2]}|      |${machines[j+3]}|      |${machines[j+4]}|      |${machines[j+5]}|		      |${machines[j+6]}|      |${machines[j+7]}|      |${machines[j+8]}|      |${machines[j+9]}|      |${machines[j+10]}|      |${machines[final]}|"
		echo "'''''''       ''''''      ''''''      ''''''      ''''''      ''''''		      ''''''      ''''''      ''''''      ''''''      ''''''      ''''''"
		j=$((final - 12))
	else
		final=$((j-11))
		echo " _______      ______      ______      ______      ______      ______		      ______      ______      ______      ______      ______      ______"
		echo "|      |      |    |      |    |      |    |      |    |      |    |      	      |    |      |    |      |    |      |    |      |    |      |    |"
		echo "|${machines[j]}  |      |${machines[j-1]}|      |${machines[j-2]}|      |${machines[j-3]}|      |${machines[j-4]}|      |${machines[j-5]}|		      |${machines[j-6]}|      |${machines[j-7]}|      |${machines[j-8]}|      |${machines[j-9]}|      |${machines[j-10]}|      |${machines[final]}|"
		echo "'''''''       ''''''      ''''''      ''''''      ''''''      ''''''		      ''''''      ''''''      ''''''      ''''''      ''''''      ''''''"
		j=$((final - 12))
	fi
	loopvar=$((loopvar+1))
	loopvar2=$((loopvar2+1))
done

	echo "maquinas down $isDownN"
	echo "maquinas normais $isNotDownWithAluno"
	echo "maquinas nenhum aluno $isNotDownWithNoAluno"
}

lccFind $lcc3String $nlcc3
rm index.html
