CWD=$(pwd)
TARGET=$1
OUTPUT=$CWD/out

if [[ -z $TARGET ]]
then
    echo -n "Activity number: "
    read TARGET
fi

FILENAME=$OUTPUT/Activity$TARGET.class

if [[ ! -f $FILENAME ]]
then
    echo "Activity bytecode not found"
    exit 1
fi

java -cp $OUTPUT Activity$TARGET