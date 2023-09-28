#!/bin/bash
cd /home/alarm/git/Raspberry-ssd1306/


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

isDownN=0
isNotDownWithAluno=0
isNotDownWithNoAluno=0


	
echo "<=====================================================$1===============================================>"
for i in $(seq -w 01 $2)
do


	if [[ "$1" == "LCC2" || "$1" == "LCC1" ]];then
		noleading0=$(expr $i + 0)
		echo "valor agora eh $noleading0"
		if [ "$i" -gt 10 ]; then
			i=$noleading0
		fi
	fi


	Aluno=$(grep -oP "<b>$1-$i.*?</b><br><br>" index.html |
		grep -o '<b> Usuário(s) logado(s).*<br>' |
		grep -oP '<br>.*<br>'|
		sed 's/<br>//g'
	)



#	echo "maquinas down $isDownN"
#	echo "maquinas normais $isNotDownWithAluno"
#	echo "maquinas nenhum aluno $isNotDownWithNoAluno"

	isDOWN=$(grep -oP "<b>$1-$i.*?</b><br><br>" index.html | grep -oP "<b>$1-$i -.*N" | grep -oP '\- .*' | tr -d "-" | tr -d " ")

	
	if [ "$isDOWN" == "DOWN" ];then
		isDownN=$((isDownN + 1))
		continue
	fi

	if [ "$Aluno" == "" ]; then
		isNotDownWithNoAluno=$((isNotDownWithNoAluno + 1))
		continue
	fi

	isNotDownWithAluno=$((isNotDownWithAluno + 1))


done


	./oled r #reloads
	./oled +1 "lab->$1"
	./oled +2 "DOWN->$isDownN"
	./oled +3 "UP->$isNotDownWithNoAluno"
	./oled +4 "Em uso $isNotDownWithAluno"
	./oled s #print to screen
	sleep 9

}

lccFind $lcc3String $nlcc3
lccFind $lcc2String $nlcc2andlcc1
lccFind $lcc1String $nlcc2andlcc1
rm index.html
