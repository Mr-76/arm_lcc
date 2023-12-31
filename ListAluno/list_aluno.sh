#!/bin/bash


#Mr-76 A.K.A Careca
#Lista aluno por maquina

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

	index_value=0
	isDownN=0
	isNotDownWithAluno=0
	isNotDownWithNoAluno=0


	echo "<===========================================================================$1===========================================================================>"
	for i in $(seq -w 01 $2)
	do
		Aluno=$(grep -oP "<b>$1-$i.*?</b><br><br>" index.html |
			grep -o '<b> Usuário(s) logado(s).*<br>' |
			grep -oP '<br>.*<br>'|
			sed 's/<br>//g'
		)
		isDOWN=$(grep -oP "<b>$1-$i.*?</b><br><br>" index.html | grep -oP "<b>$1-$i -.*N" | grep -oP '\- .*' | tr -d "-" | tr -d " ")


		AlunoNome=$(grep -oP "<b>$1-$i.*?</b><br><br>" index.html |
			grep -o '<b> Usuário(s) logado(s).*<br>' |
			grep -oP '<br>.*<br>'|
			sed 's/<br>//g' |
			grep -oP ".*?</div>" |
			head -n 1 | sed 's/<\/div>//g')



		
		if [ "$isDOWN" == "DOWN" ];then
			isDownN=$((isDownN + 1))
		elif [ "$Aluno" == "" ] ;then
			isNotDownWithNoAluno=$((isNotDownWithNoAluno + 1))
		else
			echo "Aluno $AlunoNome na maquina $1-$i"
			isNotDownWithAluno=$((isNotDownWithAluno + 1))
		fi

		index_value=$((index_value+1))

	done
	echo "maquinas down $isDownN"
	echo "maquinas Com aluno $isNotDownWithAluno"
	echo "maquinas nenhum aluno $isNotDownWithNoAluno"

}
lccfind3 $lcc3String $nlcc3
lccfind3 $lcc2String $nlcc2andlcc1
lccfind3 $lcc1String $nlcc2andlcc1
rm index.html
