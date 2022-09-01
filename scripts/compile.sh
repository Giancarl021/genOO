CWD=$(pwd)
TARGET=$1
OUTPUT=$CWD/out

mkdir -p $OUTPUT

if [[ -z $TARGET ]]
then
    TARGET=$CWD/*.java
fi

for FILE in $TARGET
do
    FILENAME=$(basename $FILE | grep '[0-9]*' -o)
    javac $CWD/Activity$FILENAME.java -d $OUTPUT
done