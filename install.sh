#!/bin/bash

#####################################################################################
#                                   ADS-B RECEIVER                                  #
#####################################################################################
#                                                                                   #
#  A set of scripts created to automate the process of installing the software      #
#  needed to setup a Mode S decoder as well as feeders which are capable of         #
#  sharing your ADS-B results with many of the most popular ADS-B aggregate sites.  #
#                                                                                   #
#  Project Hosted On GitHub: https://github.com/jprochazka/adsb-receiver            #
#                                                                                   #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                                   #
# Copyright (c) 2015-2016 Joseph A. Prochazka                                       #
#                                                                                   #
# Permission is hereby granted, free of charge, to any person obtaining a copy      #
# of this software and associated documentation files (the "Software"), to deal     #
# in the Software without restriction, including without limitation the rights      #
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell         #
# copies of the Software, and to permit persons to whom the Software is             #
# furnished to do so, subject to the following conditions:                          #
#                                                                                   #
# The above copyright notice and this permission notice shall be included in all    #
# copies or substantial portions of the Software.                                   #
#                                                                                   #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR        #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,          #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE       #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER            #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,     #
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE     #
# SOFTWARE.                                                                         #
#                                                                                   #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## VARIABLES

PROJECTROOTDIRECTORY="$PWD"
BASHDIRECTORY="$PROJECTROOTDIRECTORY/bash"
LOGDIRECTORY="$PROJECTROOTDIRECTORY/logs"

## USAGE 

usage()
{   
    echo -e ""
    echo -e "Usage: $0 [OPTIONS] [ARGUMENTS]"
    echo -e ""
    echo -e "Option     GNU long option     Meaning"
    echo -e "-h         --help              Shows this message."
    echo -e "-l         --log-output        Logs all output to a file in the logs directory."
    echo -e "-v         --verbose           Provides extra confirmation at each stage of the install"
    echo -e ""
}

## CHECK FOR OPTIONS AND ARGUMENTS

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            # Display a help message.
            usage
            exit 0
            ;;
        -l|--log-output)
            # Enable logging to a file in the logs directory.
            ENABLE_LOGGING="true"
            shift
            ;;
        -v|--verbose)
            # Provides extra confirmation at each stage of the install.
            VERBOSE="true"
            shift 
            ;;
        *)
            # Unknown options were set so exit.
            echo -e "Error: Unknown option: $1" >&2
            usage
            exit 1
            ;;
    esac
done

## EXECUTE BASH/INIT.SH

chmod +x $BASHDIRECTORY/init.sh
if [ ! -z $ENABLE_LOGGING ] && [ $ENABLE_LOGGING = "true" ]; then
    # Execute init.sh logging all output to the log drectory as the file name specified.
    $BASHDIRECTORY/init.sh 2>&1 | tee -a "$LOGDIRECTORY/install_$(date +"%m_%d_%Y_%H_%M_%S").log"
else
    # Execute init.sh without logging any output to the log directory.
    $BASHDIRECTORY/init.sh
fi

## 

if [ $? -ne 0 ]; then
    exit 1
fi
