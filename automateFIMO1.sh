
#!/bin/bash

set -e

#This script automates the FIMO process, takes in no parameters
#Run with ./automateFIMO1.sh
#STEPS: 1.Look through my_motifs directory for files with .meme ending
# 	2.motiffile is edited as only the name of the transcription factor (motif)
#	3.For each TF in my_motifs, run fimo, output directory located in my_fimo/$motif
#	4.Converts and formats fimo file as bed file 


#path to reference file: /storage/resources/dbase/human/hg19/hg19.fa
#motifs stored in : my_motifs

#CHANGED my_motifs to my_motifs_all, my_fimo to	my_fimo_all

for motiffile in $(ls my_motifs_all)
do
	#RUNNING FIMO
	echo "RUNNING FIMO..."
	motif=$(basename ${motiffile} .meme)
	fimo --oc my_fimo_all/${motif} my_motifs_all/${motif}.meme /storage/resources/dbase/human/hg19/hg19.fa
	
	#CONVERTING TO BED FILE
	echo "CONVERTING TO BED..."
	cat my_fimo_all/${motif}/fimo.txt | awk '{print $3 "\t" $4 "\t" $5 "\t" $6}' | grep -v motif > my_fimo_all/${motif}/${motif}.bed

	#SORTING BED FILE
	echo "SORTING BED FILE..."
	sortBed -i my_fimo_all/${motif}/${motif}.bed > my_fimo_all/${motif}/${motif}_sorted.bed
#should output bedfile with <motifname>.bed as the name
	
	printf "Transcription factor ${motif} finished...\n\n"
done

