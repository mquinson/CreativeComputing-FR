# Define the page at which each section starts and stops
FRONT=$(shell seq   1  10)
UNIT0=$(shell seq  11  26)
UNIT1=$(shell seq  27  42)
UNIT2=$(shell seq  42  58)
UNIT3=$(shell seq  59  74)
UNIT4=$(shell seq  75  92)
UNIT5=$(shell seq  93 112)
UNIT6=$(shell seq 113 136)
BACK=$(shell seq 137 154)



ProgrammationCreative.pdf: fr-front.pdf fr-unit0.pdf #unit1.pdf unit2.pdf unit3.pdf unit4.pdf unit5.pdf unit6.pdf back.pdf
	pdfjoin --outfile $@ $^


fr-front.pdf: $(foreach n,$(FRONT),svgs/fr-p$(n).pdf)
	pdfjoin --outfile $@ $^	
$(foreach n,$(FRONT),svgs/fr-p$(n).svg): $(foreach n,$(FRONT),svgs/en-p$(n).svg) traductions/front.fr.po
	po4a config/front.po4a


fr-unit0.pdf: $(foreach n,$(UNIT0),svgs/fr-p$(n).pdf)
	pdfjoin --outfile $@ $^	
$(foreach n,$(UNIT0),svgs/fr-p$n.svg) : $(foreach n,$(UNIT0),svgs/en-p$n.svg) traductions/unit0.fr.po
	po4a config/unit0.po4a

fr-unit1.pdf: $(foreach n,$(UNIT1),svgs/fr-p$(n).pdf)
	pdfjoin --outfile $@ $^	
$(foreach n,$(UNIT1),svgs/fr-p$n.svg) : $(foreach n,$(UNIT1),svgs/en-p$n.svg) traductions/unit1.fr.po
	po4a config/unit1.po4a


svgs/fr-%.pdf: svgs/fr-%.svg
	inkscape -f $^ -A $@

page%.pdf: svgs/fr-p%.pdf
	pdfjam --outfile tmp.pdf svgs/CreativeComputing20140806.pdf $*
	pdfjoin --outfile $@ svgs/fr-p$(*).pdf tmp.pdf
	rm tmp.pdf
	

# Generate the english svg files directly from the main document
# Don't remove those files unless you love to click popups, and manually merging text areas.
#svgs/en-p%.svg: CreativeComputing20140806.pdf
#	pdfjam --outfile tmp.pdf CreativeComputing20140806.pdf $*
#	inkscape  -f tmp.pdf --verb=FileSaveAs --verb=FileQuit
#	mv tmp.svg $@

