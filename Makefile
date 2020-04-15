BUNDLES=${HOME}/Library/Application Support/TextMate/Managed/Bundles
OSCRIPT=OScript.tmbundle
TARGET=${BUNDLES}/${OSCRIPT}

test ::
	plutil info.plist Preferences/* Syntaxes/*

install ::
	mkdir -p "${TARGET}/Preferences" "${TARGET}/Syntaxes"
	cp README.mdown "${TARGET}/"
	cp Changes.json "${TARGET}/"
	plutil -convert binary1 -o "${TARGET}/info.plist" info.plist
	plutil -convert binary1 -o "${TARGET}/Preferences/Comments.tmPreferences" Preferences/Comments.tmPreferences
	plutil -convert binary1 -o "${TARGET}/Preferences/Folding.tmPreferences" Preferences/Folding.tmPreferences
	plutil -convert binary1 -o "${TARGET}/Preferences/Indent.tmPreferences" Preferences/Indent.tmPreferences
	plutil -convert binary1 -o "${TARGET}/Syntaxes/OScript.tmLanguage" Syntaxes/OScript.tmLanguage

uninstall ::
	rm -r ${TARGET}

changes ::
	git log \
    --pretty=format:'{"commit":"%H","date":"%aI","author":"%aN","summary":"%f"},' | \
    perl -pe 'BEGIN{print "{\"commits\":["}; END{print "],\"name\":\"OScript\"}"}' | \
    perl -pe 's/},]/}]/' > Changes.json
