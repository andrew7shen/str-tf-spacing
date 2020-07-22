#!/bin/bash

#Function: compares all the FIMO output files in a directory by running closestBed and filtering for values within 50bp apart,
#	   runs calcStartEnd.py for more formatting

#tf_paths is an array of the paths of the transcription factor fimo files
tf_paths=()

for tf in $(ls my_fimo_all)
do
	tf_paths+=(my_fimo_all/${tf})	

done

#ACCESS item i:echo ${tf_paths[$i]}
for (( i=0; i<=${#tf_paths[@]}-1; i++ ))
do
	for (( j=i+1; j<=${#tf_paths[@]}-1; j++ ))
	do
		tf1=$(basename ${tf_paths[$i]})
		tf2=$(basename ${tf_paths[$j]})
		pair_name=${tf1}_${tf2}
		mkdir my_comp_all/${pair_name}
		#echo $pair_name
		
		#CLOSEST_BED
		closestBed -a ${tf_paths[$i]}/${tf1}_sorted.bed -b ${tf_paths[$j]}/${tf2}_sorted.bed -d > my_comp_all/${pair_name}/${pair_name}_closest.bed

		#ONLY VALUES 50BP APART
		#ISSUE: how can it recognize tf1 and tf2
		awk -v"tf1=$tf1" -v"tf2=$tf2" '{ if($9<50) print $1 "\t" "START" "\t" "END" "\t" tf1 "\t" $4 "\t" $2 "\t" $3 "\t" tf2 "\t" $8 "\t" $6 "\t" $7}' my_comp_all/${pair_name}/${pair_name}_closest.bed > my_comp_all/${pair_name}/${pair_name}_organized.bed

		#INCLUDE START/END
		python calcStartEnd.py my_comp_all/${pair_name}/${pair_name}_organized.bed > my_comp_all/${pair_name}/${pair_name}_final.bed
	done
done
