#!/bin/bash

# Define an array of machine names


lccFind(){


	RED="\e[31m"
	GREEN="\e[32m"
	YELLOW="\e[33m"
	END="\e[0m"


	wget -q --no-check-certificate https://lcc.ufcg.edu.br/

	local machines=() # need to make it empty every time ..... try without to see it .....

	for i in {1..56}; do
	    machine=$(printf "%03d" $i)
	    machines+=("$machine")  # Add the machine name to the array
	done


	index_value=0
	isDownN=0
	comAluno=0
	upSemAluno=0





	echo "<===========================================================================$1===========================================================================>"
	for i in $(seq -w 01 $2)
	do
		Aluno=$(grep -oP "<b>$1-$i.*?</b><br><br>" index.html |
			grep -o '<b> Usuário(s) logado(s).*<br>' |
			grep -oP '<br>.*<br>'|
			sed 's/<br>//g'
		)
		isDOWN=$(grep -oP "<b>$1-$i.*?</b><br><br>" index.html | grep -oP "<b>$1-$i -.*N" | grep -oP '\- .*' | tr -d "-" | tr -d " ")

		
		if [ "$isDOWN" == "DOWN" ];then
			isDownN=$((isDownN + 1))
			machines[index_value]="${RED}${machines[index_value]}X${END}"
		elif [ "$Aluno" == "" ] ;then
			upSemAluno=$((upSemAluno + 1))
			machines[index_value]="${YELLOW}${machines[index_value]}N${END}"
		else
			comAluno=$((comAluno + 1))
			machines[index_value]="${GREEN}${machines[index_value]}A${END}"
			
		fi

		index_value=$((index_value+1))

	done


	left=13
	right=42
	incremento=1
	for i in $(seq 1 1 14); do
		lef_one=$((left + incremento))
		right_one=$((right - incremento))
		echo "______        ______   ______      ______"
		echo "|    |        |    |   |    |      |    |"
		echo -e "|${machines[left]}|        |${machines[lef_one]}|   |${machines[right_one]}|      |${machines[right]}|"
		echo "''''''        ''''''   ''''''      ''''''"
		incremento=$((incremento + 2))
		left=$((left - 1))
		right=$((right + 1))
	done


	echo "maquinas down $isDownN"
	echo "maquinas com Aluno $comAluno"
	echo "maquinas nenhum aluno $upSemAluno"
	echo -e "N --->Nenhum aluno\nX--->Down\nA--->Com aluno"
	rm index.html
}

nlcc2andlcc1=56
lcc2String="LCC2"
lcc1String="LCC1"
lccFind $lcc1String $nlcc2andlcc1
lccFind $lcc2String $nlcc2andlcc1
./lab_cli_status.sh
