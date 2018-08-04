open.ballot: open.ballot.cpp
	eosiocpp -o open.ballot.wast open.ballot.cpp
	eosiocpp -g open.ballot.abi open.ballot.cpp

test:
	init_chain.sh

clean:
	rm *.wasm *.wast
