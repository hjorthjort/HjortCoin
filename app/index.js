const express = require('express');
const app = express();
const fs = require('fs')

function serveFile(at, path, contentType) {
    app.get(at, (req, res) => {
        res.writeHead(200, {'Content-Type': contentType});
        fs.readFile(path, 'utf8', (err, data) => {
            if (err) console.error(err);
            else res.end(data);
        });
    });
}

function main() {
    function serve(filename, res) {
        return res.write(fs.readFileSync(filename, 'utf8'));
    }
    app.get('/', (req, res) => {
        res.writeHead(200, {'Content-Type': 'text/html'});
        serve('./head.html', res);
        var userContract = fs.readFileSync('../build/contracts/HjortUser.json', 'utf8' );
        res.write('<script>var userContractJson = ' + userContract + '</script>');
        serve('./index.html', res);
        serve('./foot.html', res);
        res.end();
    });
}
serveFile('/app.js', './app.js', 'application/javascript');
serveFile('/HjortUser', '../build/contracts/HjortUser.json', 'application/json');
main();

app.listen(3000, () => console.log('Listeing on localhost:3000'));
