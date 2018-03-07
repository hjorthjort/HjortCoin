function present(instance) { print = console.log; printNumber = bigN => print(bigN.toNumber()); instance.name.call().then(print); instance.symbol.call().then(print); instance.totalSupply.call().then(printNumber); }
HjortCoin.deployed().then(present);

