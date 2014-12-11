#!/bin/bash


# Install crosswalk and cordova

echo "Installing cordova and crosswalk ?"

select yn in "Yes" "No"; do
	if [[ $yn == "Yes" ]]; then
		install_cordova="npm install -g cordova-android-crosswalk cordova@3.5.0-0.2.7"

		if [[ -w /usr/local/bin ]]; then
			# Directory is writable, no need to use sudo
			${install_cordova}
		else
			sudo ${install_cordova}
		fi

		break
	else
		break
	fi
done


# Detect if ANDROID_HOME is set and add directories to PATH

if [[ -z ${ANDROID_HOME} ]]; then
	echo "ANDROID_HOME is not set. Add it to your .bash_profile ?"

	select yn in "Yes" "No"; do
		if [[ $yn == "Yes" ]]; then
			while [[ -z ${android_home} ]]; do
				echo "Please enter the path to the Android SDK. e.g.- /Applications/Android Studio.app/Contents/sdk"
				read "android_home"
			done

			echo "export ANDROID_HOME=\"${android_home}\"" >> ~/.bash_profile
			echo "export PATH=\"\${PATH}:\${ANDROID_HOME}/tools:\${ANDROID_HOME}/platform-tools\"" >> ~/.bash_profile

			break
		else
			break
		fi
	done

fi


# Setup Apache ant

if [[ ! `command -v ant` ]]; then
	echo "Apache ant is not installed. Install Apache ant ?"

	select yn in "Yes" "No"; do
		if [[ $yn == "Yes" ]]; then
			if [[ `command -v brew` ]]; then
				brew install ant
			elif [[ `command -v apt-get` ]]; then
				sudo apt-get install ant
			elif [[ `command -v dnf` ]]; then
				sudo dnf install ant
			fi

			echo "Adding ANT_HOME and ANT_OPTS to your .bash_profile"

			echo "export ANT_HOME=\"$(ant -diagnostics 2>&1 | grep ant.home | head -n1 | cut -d: -f2 | sed -e 's/^ *//' -e 's/ *$//')\"" >> ~/.bash_profile
			echo "export ANT_OPTS=\"-Xmx256M\"" >> ~/.bash_profile

			break
		else
			break
		fi
	done
fi


# Setup multilib stuff

if [[ $(uname -m) == "x86_64" ]] && [[ `command -v apt-get` || `command -v dnf` ]]; then
	echo "64-bit detected. Install 32-bit stdc++ library ?"

	select yn in "Yes" "No"; do
		if [[ $yn == "Yes" ]]; then
			if [[ `command -v apt-get` ]]; then
				sudo apt-get install lib32stdc++6
			elif [[ `command -v dnf` ]]; then
				sudo dnf install libstdc++.i686
			fi

			break
		else
			break
		fi
	done
fi


# Finishing touches

echo "You might need to restart the Terminal or run 'source ~/.bash_profile'"
