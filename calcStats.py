#Function: calculates hits, lengths, eSTR qualifications for the hipstr master output file


#clears stats_final.txt file
import os
os.remove("stats_final.txt")


#f1 (full intersectBed output), f2 (basic stats file), f3 (all analyzed STRs file), f4 (all eSTRs file), f5 (output file, "stats_final.txt")
f1 = open("intersect_master.bed", "r")
f1_split = f1.readlines()
f2 = open("tfpair_summary_hipstr.txt", "r")
f2_split = f2.readlines()
f3 = open("/storage/mgymrek/gtex-estrs/revision/misc/all_analyzed_strs_v2.tab", "r")
f3_split = f3.readlines()
f4 = open("/storage/mgymrek/gtex-estrs/revision/figures/SuppTable_CAVIAR.tsv", "r")
f4_split = f4.readlines()
f5 = open("stats_final.txt", "a")

counter = 0
for line2 in f2_split:
	L = ""
	line2_split = line2.split()

	if counter == 0:
		L = L + line2_split[0] + "\t" + line2_split[1] + "\t" + line2_split[2] + "\t" + line2_split[3] + "\t" + line2_split[4] + "\t" + line2_split[5] + "\t" + line2_split[6] + "\t" + line2_split[7] + "\t" + line2_split[8] + "\t" + line2_split[9] + "\t" + line2_split[10] + "\t" + line2_split[11] + "\t" + line2_split[12] + "\t" + line2_split[13] + "\t" + line2_split[14] + "\t" + line2_split[15] + "\n"
		counter = counter+1
	else:
		L = L + line2_split[0] + "\t" + line2_split[1] + "\t" + line2_split[2] + "\t" + line2_split[3] + "\t"
		
		hit_count = 0
		ones = 0
		twos = 0
		threes = 0
		fours = 0
		fives = 0
		sixes = 0
		analyzed = "No"
		eSTR = "No"
		pval = 0
		beta = 0
		score = 0
		for line1 in f1_split:
			line1_split = line1.split()

			#print(line1_split[18] + " and " + line2_split[0])

			if line1_split[18] == line2_split[0]:
				hit_count = hit_count+1
				if line1_split[3] == "1":
					ones = ones+1
				if line1_split[3] == "2":
		                        twos = twos+1
				if line1_split[3] == "3":
					threes = threes+1
				if line1_split[3] == "4":
	        	                fours = fours+1
				if line1_split[3] == "5":
	                        	fives = fives+1
				if line1_split[3] == "6":
	        	                sixes = sixes+1
			
			print("hits and length calculated")			

			for line3 in f3_split:
	                        line3_split = line3.split()
        	                if (line3_split[0] == line1_split[0]) and (line3_split[1] == line1_split[1]) and (line3_split[2] == line1_split[2]):
					analyzed = "Yes"
					
			print("all analyzed calculated")
			
			for line4 in f4_split:
                                line4_split = line4.split()
				if (line4_split[0] == line1_split[0]) and (line4_split[1] == line1_split[1]) and (line4_split[9] == line1_split[2]):
                                        eSTR = "Yes"
					pval = line4_split[5]
					beta = line4_split[6]
					score = line4_split[7]

			print("eSTR calculated")
			
		L = L + str(hit_count) + "\t" + str(ones) + "\t" + str(twos) + "\t" + str(threes) + "\t" + str(fours) + "\t" + str(fives) + "\t" + str(sixes) + "\t" + analyzed + "\t" + eSTR + "\t" + str(pval) + "\t" + str(beta) + "\t" + str(score) + "\n" 
	f5.write(L)
	print(line2_split[0] + " finished")
