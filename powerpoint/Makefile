

FILES="preambule unit0 unit1 unit2 unit3 unit4 unit5 unit6 appendix"

all: unit0.fr.pptx


#
# Convert from pptx to odp (in English)
#######
temp/preambule.odp: orig/preambule.pptx
	libreoffice -env:UserInstallation=file:///tmp/LibO_Conversion --headless --convert-to odp $< --outdir temp
	rm -rf /tmp/LibO_Conversion
temp/unit0.odp: orig/unit0.pptx
	libreoffice -env:UserInstallation=file:///tmp/LibO_Conversion --headless --convert-to odp $< --outdir temp
	rm -rf /tmp/LibO_Conversion
temp/unit1.odp: orig/unit1.pptx
	libreoffice -env:UserInstallation=file:///tmp/LibO_Conversion --headless --convert-to odp $< --outdir temp
	rm -rf /tmp/LibO_Conversion
temp/unit2.odp: orig/unit2.pptx
	libreoffice -env:UserInstallation=file:///tmp/LibO_Conversion --headless --convert-to odp $< --outdir temp
	rm -rf /tmp/LibO_Conversion
temp/unit3.odp: orig/unit3.pptx
	libreoffice -env:UserInstallation=file:///tmp/LibO_Conversion --headless --convert-to odp $< --outdir temp
	rm -rf /tmp/LibO_Conversion
temp/unit4.odp: orig/unit4.pptx
	libreoffice -env:UserInstallation=file:///tmp/LibO_Conversion --headless --convert-to odp $< --outdir temp
	rm -rf /tmp/LibO_Conversion
temp/unit5.odp: orig/unit5.pptx
	libreoffice -env:UserInstallation=file:///tmp/LibO_Conversion --headless --convert-to odp $< --outdir temp
	rm -rf /tmp/LibO_Conversion
temp/unit6.odp: orig/unit6.pptx
	libreoffice -env:UserInstallation=file:///tmp/LibO_Conversion --headless --convert-to odp $< --outdir temp
	rm -rf /tmp/LibO_Conversion
temp/appendix.odp: orig/appendix.pptx
	libreoffice -env:UserInstallation=file:///tmp/LibO_Conversion --headless --convert-to odp $< --outdir temp
	rm -rf /tmp/LibO_Conversion

# Translate stuff:
#  - updates the po files on (rare) need and
#  - reinjects the translation strings into the %.fr.odp file
#######
temp/%.fr.odp: temp/%.odp #%.po
	po4a config/$(*).po4a

# Convert back to (translated) pptx
#######

%.fr.pptx: temp/%.fr.odp
	libreoffice -env:UserInstallation=file:///tmp/LibO_Conversion --headless --convert-to pptx $< --outdir .
	rm -rf /tmp/LibO_Conversion


# Cleanup the mess
#######
clean:
	rm temp/*