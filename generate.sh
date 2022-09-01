# Constants
CWD=$(pwd)
SCRIPT_PATH=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
OS=$(lsb_release -sd)

# Variables
TARGET=$1
TEMPLATE=$2

# Polyfill
if [[ -z $TARGET ]]
then
    echo -n "Quantity: "
    read TARGET
fi

if [[ -z $TEMPLATE ]]
then
    TEMPLATE="default"
fi

# Work variables
QUANTITY=$(echo $TARGET | grep '[0-9]*' -o)
FORCE=$(echo $TARGET | grep '!' -o | wc -l)
TEMPLATE_FILE=$SCRIPT_PATH/templates/$TEMPLATE.java
SCRIPTS_PATH=$SCRIPT_PATH/scripts

# Check template files
if [[ ! -d $SCRIPTS_PATH ]]
then
    echo "Scripts directory not found"
    return
fi

if [[ ! -f $TEMPLATE_FILE ]]
then
    echo "Template file not found"
    return
fi

# Cleanup files
if [[ $FORCE -ge 3 ]]
then
    rm -f $CWD/*.java
fi

# Generate files
for i in $(seq $QUANTITY)
do
    FILENAME=$CWD/Activity$i.java
    if [[ -f $FILENAME && $FORCE -lt 1 ]]
    then
        echo "File $FILENAME already exists, skipping"
    else
        cat $TEMPLATE_FILE | awk -v "iter=$i" -v "os=$OS" '{gsub(/\[\[ITER\]\]/,iter);gsub(/\[\[OS\]\]/,os)}1' > $FILENAME
    fi
done

cp -r $SCRIPTS_PATH/ $CWD/

. $CWD/scripts/init.sh

unset CWD
unset SCRIPT_PATH
unset OS
unset TARGET
unset TEMPLATE
unset QUANTITY
unset FORCE
unset TEMPLATE_FILE
unset SCRIPTS_PATH
unset FILENAME
unset i