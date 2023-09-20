#!/bin/bash

# Define an array of machine names


for i in {1..120}; do
    machine=$(printf "%03d" $i)
    machines+=("$machine")  # Add the machine name to the array
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
		echo "|${machines[j]}   |      |${machines[j+1]} |      |${machines[j+2]} |      |${machines[j+3]} |      |${machines[j+4]} |      |${machines[j+5]} |		      |${machines[j+6]} |      |${machines[j+7]} |      |${machines[j+8]} |      |${machines[j+9]} |      |${machines[j+10]} |      |${machines[final]} |"
		echo "'''''''       ''''''      ''''''      ''''''      ''''''      ''''''		      ''''''      ''''''      ''''''      ''''''      ''''''      ''''''"
		j=$((final - 12))
	else
		final=$((j-11))
		echo " _______      ______      ______      ______      ______      ______		      ______      ______      ______      ______      ______      ______"
		echo "|      |      |    |      |    |      |    |      |    |      |    |      	      |    |      |    |      |    |      |    |      |    |      |    |"
		echo "|${machines[j]}   |      |${machines[j-1]} |      |${machines[j-2]} |      |${machines[j-3]} |      |${machines[j-4]} |      |${machines[j-5]} |		      |${machines[j-6]} |      |${machines[j-7]} |      |${machines[j-8]} |      |${machines[j-9]} |      |${machines[j-10]} |      |${machines[final]} |"
		echo "'''''''       ''''''      ''''''      ''''''      ''''''      ''''''		      ''''''      ''''''      ''''''      ''''''      ''''''      ''''''"
		j=$((final - 12))
	fi
	loopvar=$((loopvar+1))
	loopvar2=$((loopvar2+1))
done
