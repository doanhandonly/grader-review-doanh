#set -e
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'
files=$(find "student-submission" -name "*.java")

for file in $files
do 
    if [[ -f $file ]]
        then
            echo $file
            echo "Is a file"
        else
            echo "File not found"
    fi
done

cp -r lib grading-area
cp student-submission/ListExamples.java grading-area
cp -r TestListExamples.java grading-area

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" Server.java GradeServer.java 
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore GradeServer 4242 > result.txt 
cat result.txt 

substring=$(grep "Tests run: " result.txt)

if grep -q "OK" result.txt; then
    echo "All tests passed, congrats!"
else
    ran=${substring:11:1}
    fail=${substring:25:1}
    echo "You failed" $fail" "out of" "$ran "tests. Keep on trying, I believe in you"
fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
