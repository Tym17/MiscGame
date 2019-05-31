const fs = require('fs');

fs.readFile('old.cfg', 'utf8', (err, data) => {
    if (err) throw err;
    data = data.replace(/[\r<>\"]/gim, '');
    let lines = data.split('\n');

    let block = '';
    let family = '';
    let maxnb = 0;
    let newData = [];

    for (let line of lines) {
        if (line.charAt(0) == '#') {
            newData.push(line);
            continue;
        }

        let item = line.split(':');
        if (family !== item[0] || block != item[1]) {
            if (family == '') {
                family = item[0];
                maxnb = 0;
                block = item[1];
                continue;
            }
            newData.push(`"${family}:${block}"${maxnb > 0 ? `:0-${maxnb}` : ''}`);
            maxnb = 0;
        }
        family = item[0];
        block = item[1];
        if (item[2] > maxnb) {
            maxnb = item[2];
        }
    }

    newData = newData.join('\r\n');

    fs.writeFileSync('new.cfg', newData);
});