var msg = $('#msg');

function metamaskHandler() {
    if (typeof web3 == 'undefined') {
        msg.html('Run MetaMask!');
        console.log(err);
        return false;
    }
    return true;
}

function clear(string) {
    $("#content").empty();
}
function updateWith(string) {
    $("#content").append(string);
}

// Requires we have access to web3.
function runApp() {
    var web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:7545'));
    web3.eth.defaultAccount = web3.eth.coinbase;

    var abi = userContractJson.abi;
    var address = userContractJson.networks['5777'].address;
    var userContract = web3.eth.contract(abi).at(address);

    updateWith( "<b>Users:</b>");
    updateWith('<ul id="users">');
    var userCount = userContract.getUsersCount();
    var allUsers = [];
    for (var i = 0; i < userCount; i++) {
        let user = userContract.getUserAt(i);
        let uName = user[0];
        allUsers[uName] = {'name': uName };

        let balFun = (balance) => {
            allUsers[uName].balance = balance;
            $('#' + uName).append(', ' + web3.fromWei(allUsers[uName].balance) + ' ETH');
        };

        web3.eth.getBalance(user[1], (error, bal) => balFun(bal));
        updateWith('<li id="'+ uName +'">' + web3.toAscii(uName) + '</li>')
    }
    
}

if (metamaskHandler()) runApp();

