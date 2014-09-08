# Define the page at which each section starts and stops
FRONT=$(shell seq   1  10)
UNIT0=$(shell seq  11  26)
UNIT1=$(shell seq  27  42)
UNIT2=$(shell seq  43  58)
UNIT3=$(shell seq  59  74)
UNIT4=$(shell seq  75  92)
UNIT5=$(shell seq  93 112)
UNIT6=$(shell seq 113 136)
BACK=$(shell seq 137 154)

##
## Final document, by assembling parts

ProgrammationCreative.pdf: fr-front.pdf fr-unit0.pdf fr-unit1.pdf fr-unit2.pdf fr-unit3.pdf fr-unit4.pdf fr-unit5.pdf fr-unit6.pdf fr-back.pdf
	pdfjoin --outfile $@ $^

##
## For each unit, rules building the translated svg files and
##  combining them into a uniq pdf.

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

fr-unit2.pdf: $(foreach n,$(UNIT2),svgs/fr-p$(n).pdf)
	pdfjoin --outfile $@ $^	
$(foreach n,$(UNIT2),svgs/fr-p$n.svg) : $(foreach n,$(UNIT2),svgs/en-p$n.svg) traductions/unit2.fr.po
	po4a config/unit2.po4a

fr-unit3.pdf: $(foreach n,$(UNIT3),svgs/fr-p$(n).pdf)
	pdfjoin --outfile $@ $^	
$(foreach n,$(UNIT3),svgs/fr-p$n.svg) : $(foreach n,$(UNIT3),svgs/en-p$n.svg) traductions/unit3.fr.po
	po4a config/unit3.po4a

fr-unit4.pdf: $(foreach n,$(UNIT4),svgs/fr-p$(n).pdf)
	pdfjoin --outfile $@ $^	
$(foreach n,$(UNIT4),svgs/fr-p$n.svg) : $(foreach n,$(UNIT4),svgs/en-p$n.svg) traductions/unit4.fr.po
	po4a config/unit4.po4a

fr-unit5.pdf: $(foreach n,$(UNIT5),svgs/fr-p$(n).pdf)
	pdfjoin --outfile $@ $^	
$(foreach n,$(UNIT5),svgs/fr-p$n.svg) : $(foreach n,$(UNIT5),svgs/en-p$n.svg) traductions/unit5.fr.po
	po4a config/unit5.po4a

fr-unit6.pdf: $(foreach n,$(UNIT6),svgs/fr-p$(n).pdf)
	pdfjoin --outfile $@ $^	
$(foreach n,$(UNIT6),svgs/fr-p$n.svg) : $(foreach n,$(UNIT6),svgs/en-p$n.svg) traductions/unit6.fr.po
	po4a config/unit6.po4a

fr-back.pdf: $(foreach n,$(BACK),svgs/fr-p$(n).pdf)
	pdfjoin --outfile $@ $^	
$(foreach n,$(BACK),svgs/fr-p$n.svg) : $(foreach n,$(BACK),svgs/en-p$n.svg) traductions/back.fr.po
	po4a config/back.po4a


##
## translated svg->pdf automatic rule

svgs/fr-%.pdf: svgs/fr-%.svg
	inkscape -f $^ -A $@

##
## Debug rule, allowing to see the translated and original side by side

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

