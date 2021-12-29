build: mylex.l
	flex++ --outfile programa.cpp mylex.l
	g++ programa.cpp -o CoronaVirusBase

clean:
	rm CoronaVirusBase
	rm programa.cpp
