# Installing Autopsy on Mac

## Download Autopsy

Download the latest version of Autopsy from the official website
at <https://www.sleuthkit.org/autopsy/download.php>. 
The zip file is about 1.2 GB.

## Instructions 

Instructions for Mac and Linux are included in the download. 
See the online page at <https://github.com/sleuthkit/autopsy/blob/develop/Running_Linux_OSX.md>.

## Make Provided Scripts Executable As You Work

For security reasons, you may not be able to run a script (.sh) file by default. 
To enable execution, open a terminal in the downloaded subfolder linux_macos_install_scripts and run chmod +x scriptfilename. 
From a terminal in the linux_macos_install_scripts folder, the commands look like this:

```shell
chmod +x install_prereqs_macos.sh
```

## Verify Success at each Step

**Important: Verify each step has successfully completed before continuining on to the next step.**
Each step must complete successfully for the installation to work. 

## 1. Install Homebrew Package Manager 

The provided scripts require the package manager: [Homebrew](https://brew.sh/), which has installation steps on their site.

Verify installation by opening a terminal and running:

```shell
brew --version
```

## 2. Install Prerequisites

Run [`linux_macos_install_scripts/install_prereqs_macos.sh`](./linux_macos_install_scripts/install_prereqs_macos.sh).
From a terminal in the linux_macos_install_scripts folder, after installing Homebrew and making the script executable:

```shell
chmod +x install_prereqs_macos.sh

./install_prereqs_macos.sh
```

After installing. After installation, it will ask for your Mac login password.
After successfully entering your user password,
it will display the path to the Java 17 installation.
You will need that path later.

```shell
Password:
Java 17 path: /opt/homebrew/Cellar/openjdk@17/17.0.10/libexec/openjdk.jdk/Contents/Home
```

## 3. Set JAVA_HOME and Install The Sleuth Kit

Ensure that for this session, your `JAVA_HOME` variable is set to the java 17 installation by running `export JAVA_HOME=$(/usr/libexec/java_home -v 17)`.  

```shell
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
```

Then, install The Sleuth Kit from source by running [`linux_macos_install_scripts/install_tsk_from_src.sh`](./linux_macos_install_scripts/install_tsk_from_src.sh),
which will download, build, and install The Sleuth Kit.
Make sure the path ends with /sleuthkit and the tag is the one from the [repository](https://github.com/sleuthkit/sleuthkit). 
The release tag is currently 4.12.1. 

```shell
chmod +x install_tsk_from_src.sh

./install_tsk_from_src.sh -p ~/src/sleuthkit -b sleuthkit-4.12.1
```
 
Important: The path must end in "sleuthkit" and the release must match the repo lastest release. 

At some point, it will ask for your user login password on the Mac.
After successfully entering your password, it will continue. 

## 4. Installing Autopsy

You should have already downloaded the Autopsy zip file.
It is available at [repository releases](https://github.com/sleuthkit/autopsy/releases).  
The file will be tagged with a release (i.e. "autopsy-4.21.0.zip").

To install Autopsy, run [`install_application.sh`](./linux_macos_install_scripts/install_application.sh) 
with the following parameters: `install_application.sh [-z zip_path] [-i install_directory] [-j java_home]`.  

For example, from a terminal open in the downloaded, extracted autopsy subfolder linux_macos_install_scripts and run the following to make it executable and to ensure the correct location of your JVM.
Adjust the final command as necessary - two options are offered as examples. 

```shell
chmod +x install_application.sh

/usr/libexec/java_home -v 17

#Update your command as needed

./install_application.sh -z ~/Downloads/autopsy-4.21.0.zip -i ~/autopsy -j /usr/lib/jvm/java-1.17.0-openjdk-amd64

./install_application.sh -z ~/Downloads/autopsy-4.21.0.zip -i ~/autopsy -j /opt/homebrew/Cellar/openjdk@17/17.0.10/libexec/openjdk.jdk/Contents/Home
```

The path to the Java 17 home is the last output from the [prequisites installation scripts](#installing-prerequisites),
but typically, the path will be in the result of running `/usr/libexec/java_home -v 17` on macOS.

After successful completion, you should see something like the following. 

```shell
---------------------------------------------
Checking prerequisites and preparing autopsy:
---------------------------------------------
~/autopsy/autopsy-4.21.0 ~/autopsy/autopsy-4.21.0
Checking for PhotoRec...Checking for Java...Checking for Sleuth Kit Java bindings...found in /usr/local/share/java
Copying sleuthkit-4.12.1.jar into the autopsy directory...done
~/autopsy/autopsy-4.21.0

Application is now configured. You can execute bin/autopsy to start it
```

## 5. Running Autopsy

Our terminal during installation is in the scripts subfolder.
We need to move to our installed autopsy location and the bin (binary) subfolder to run the executable. 
Use Finder to go to your username/autopsy-4.21.0/bin folder and open a terminal there.

From a terminal in the username/autopsy-4.21.0/bin folder, run `ls` to verify the existance of a file named autopsy (no file extension).
Make the script executable, then run autopsy.
For example:

```shell
ls

chmod +x autopsy

./autopsy
```


## Optional: Setup macOS JNA paths

Run [linux_macos_install_scripts/add_macos_jna.sh](./linux_macos_install_scripts/add_macos_jna.sh) to properly setup the jna path to get things like gstreamer working.
Gstreamer is used for multimedia (audio and video) processing and analysis.
Enabling this requires editing config files such as <autopsy_install_location>/etc/autopsy.conf.
It can be ommitted for now. 

```shell
chmod +x add_macos_jna.sh

./add_macos_jna.sh -i ~/autopsy
```

## Troubleshooting 

See the original [Running_Linux_OSX.md](https://github.com/sleuthkit/autopsy/blob/develop/Running_Linux_OSX.md)

- If you see something like "Cannot create case: javafx/scene/paint/Color" it is an indication that Java FX
  is not being found.  Confirm that the file `$JAVA_HOME/jre/lib/ext/jfxrt.jar` exists. If it does not exist, return to the Java
  setup steps above.
- If you see something like "An illegal reflective access operation has occurred" it is an indication that
  the wrong version of Java is being used to run Autopsy.
  Check the version of Java reported in the `messages.log` file in the log directory.  The log directory can be found by opening Autopsy, and, with no cases open, go to 'Help' > 'Open Log Folder'. `messages.log` should contain lines that looks like:
  ```
  Java; VM; Vendor        = 17.0.7; OpenJDK 64-Bit Server VM 17.0.7+7-Ubuntu-0ubuntu122.04.2; Private Build
  Runtime                 = OpenJDK Runtime Environment 17.0.7+7-Ubuntu-0ubuntu122.04.2
  Java Home               = /usr/lib/jvm/java-17-openjdk-amd64
  ```

  If your `messages.log` file indicates that Java 17 is not being used:
  - Confirm that you have a version of Java 17 installed
  - Confirm that your java path environment variable is set correctly.  Autopsy first uses the value of `jdkhome` in `<autopsy_install_location>/etc/autopsy.conf`, so look for an uncommented line (not starting with '#') that looks like `jdkhome=<java path>`.  If that is not set, check your `$JAVA_HOME` environment variable by running `echo $JAVA_HOME`.
- If you see something like "cannot be opened because the developer cannot be verified." it is an indication that Gatekeeper is running and is stopping a file from being executed.  To fix this open a new terminal window and enter the following command `sudo spctl --master-disable`, you will be required to enter your password.  This will allow any program to be be downloaded from anywhere and executed.
- On initial run, Autopsy shows a window that can appear behind the splash screen.  This looks like Autopsy has stalled during startup.  The easiest way to get around this issue for the first run is to run autopsy with the `--nosplash` flag, which will hide the splash screen on startup.  There will be a lag where no window appears for a bit, so please be patient.
- If a script fails to run due to operation not permitted or something along those lines, you may need to run `chmod u+x <path to script>` from the command line to allow the script to run.
- If you encounter an error like: `getcwd: cannot access parent directories: Operation not permitted` on Mac, you can do the following:
  1. Select System Preferences -> Security & Privacy -> Full Disk Access
  2. Click the lock to make changes
  3. Click '+'
  4. Press 'cmd' + 'shift' + '.' to show hidden files
  5. Select `/bin/sh`
  *Source: [Symscape](https://www.symscape.com/node/1727)*

## Known Issues

- Not all current features in Autopsy are functional in a Linux and Mac environment including but not limited to:
  - Recent Activity
  - The LEAPP processors
  - HEIF processing
  - Video thumbnails
  - VHD and VMDK files not supported on OS X
