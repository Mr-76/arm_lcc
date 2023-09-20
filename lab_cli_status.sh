#!/bin/bash
lccFind(){


	wget -q --no-check-certificate https://lcc.ufcg.edu.br/
	index_value=0

	#Build list 120 maquians
	for i in {1..120}; do
	    machine=$(printf "%03d" $i) #formato 001
	    machines+=("$machine")  #add nome pra lista
	done



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
			machines[index_value]="${machines[index_value]}X"
		elif [ "$Aluno" == "" ] ;then
			upSemAluno=$((upSemAluno + 1))
			machines[index_value]="${machines[index_value]}N"
		else
			comAluno=$((comAluno + 1))
			machines[index_value]="${machines[index_value]}A"
			
		fi

		index_value=$((index_value+1))

	done

	j=119 #poderia ser $2 -1
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
		echo "maquinas com Aluno $comAluno"
		echo "maquinas nenhum aluno $upSemAluno"
		echo -e "N --->Nenhum aluno\nX--->Down\nA--->Com aluno"

	rm index.html
}

nlcc3=120
lcc3String="LCC3"
lccFind $lcc3String $nlcc3
