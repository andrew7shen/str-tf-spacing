
#!/bin/bash

set -e

#path to reference file: /storage/resources/dbase/human/hg19/hg19.fa
#motifs stored in : my_motifs

for motiffile in $(ls my_motifs/*.meme)
do

	motif=$(echo $motiffile | cut -d '.' -f1 | cut -b 11-)
	fimo --oc my_motifs/$motif my_motifs/$motif.meme /storage/resources/dbase/human/hg19/hg19.fa
done

