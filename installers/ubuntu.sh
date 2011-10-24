#!/bin/bash

# Set variables for the installation
set -e
mongo_install_dir="/usr/local/mongodb"
version=0.4
bash_script_dir="$( cd "$( dirname "$0" )" && pwd )"

echo "***  Installing Amon $version ..."

# Install easy_install if necessary

	#wget "http://peak.telecommunity.com/dist/ez_setup.py" 
	#sudo python ez_setup.py
	#rm -rf ez_setup.py

# Install Amon

    wget "http://cloud.github.com/downloads/martinrusev/amon/amon-$version.tar.gz"
	tar -zxvf "amon-$version.tar.gz" > /dev/null
	cd "amon-$version"

	# Ensure that we have the pymongo driver dependecies
	echo ""
	#sudo apt-get install gcc python-dev 
	#sudo python setup.py install
	cd "$bash_script_dir"
	sudo cp $bash_script_dir/amon-$version/contrib/amon/amond /etc/init.d/amond
	
	# make the daemon executable
	sudo chmod +x /etc/init.d/amond
	sudo update-rc.d amond defaults 

# Copy Amon configuration files


# Install MongoDB

	install_mongodb()
	{

		#wget "http://fastdl.mongodb.org/linux/mongodb-linux-i686-2.0.0.tgz"
		echo "***  Extracting MongoDB ..."
		tar -zxvf "$mongo_dir.tgz" > /dev/null

	}

	configure_mongodb()
	{

		echo ""
		echo "***  MongoDB will be installed in $mongo_install_dir." 
		echo "If you are not running as root, the installer will ask for your root password"

		sudo mkdir $mongo_install_dir $mongo_install_dir/data $mongo_install_dir/bin && sudo touch /var/log/mongodb.log
		sudo cp $mongo_dir/bin/mongod $mongo_install_dir/mongod
		sudo cp $mongo_dir/bin/mongo /usr/bin/mongo

		wget http://get.amon.cx/mongodb.conf 
		sudo cp mongodb.conf /etc/init/mongodb.conf

	}

	# Cleanup the current directory and start Mongo
	start_mongodb()
	{
		rm -rf $mongo_extract_dir
		rm -rf mongodb.conf
		echo "*** Starting MongoDB"
		echo ""
		sudo start mongodb
	}
	
	echo "***  Amon stores the data in a Mongo database. If you already have it on the system, please skip this step"
	
	read -n1 -s -p "Install MongoDB (y/n)?"
	

	if [ "$REPLY" == "y" ]; then
		install_mongodb
		configure_mongodb
		start_mongodb
	fi


	echo "*** Installing local configuration files..."


# Show a message about where to go for help.

	print_troubleshooting_instructions() {
		echo
		echo "For troubleshooting instructions, please see the Amon User Guide :"
		echo "http://amon.cx/guide/"
		echo
		echo "To uninstall Amon, \`curl get.amon.cx/uninstall.sh | sh\`"
	}


# All done!

  echo "*** Installed"
  print_troubleshooting_instructions
