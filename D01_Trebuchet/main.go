package main

import (
	"bufio"
	"log"
	"os"
	"regexp"
	"strconv"
)

func main() {
	f, err := os.Open("D01_Trebuchet/input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer func(f *os.File) {
		err := f.Close()
		if err != nil {

		}
	}(f)

	scanner := bufio.NewScanner(f)
	calSum := 0
	lineCount := 0
	for scanner.Scan() {
		lineCount++
		stripRegex, err := regexp.Compile("[^0-9]+")
		if err != nil {
			log.Fatal(err)
		}
		str := stripRegex.ReplaceAllString(scanner.Text(), "")
		lineCalStr := string(str[0])
		lineCalStr += string(str[len(str)-1])
		num, err := strconv.Atoi(lineCalStr)
		if err != nil {
			log.Fatal(err)
		}
		calSum += num

	}

	println("Answer: ", calSum)
	if err := scanner.Err(); err == nil {
		log.Fatal(err)
	}
}
