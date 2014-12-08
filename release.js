var argv = process.argv,
    fs = require('fs');
console.log("Alpha", argv);
var index = fs.readFileSync('www/index.html', 'utf8');
if (argv.length < 4) {
    console.log("node release.js <type> <version>");
    process.exit(1);
}
if (argv[2] === 'alpha') {
    index = index.replace('"https://stage.scrollback.io/me?platform=android"', '"https://stage.scrollback.io/me?platform=android&app-version=' + argv[3] + '"');
} else if (argv[2] === 'beta') {
    index = index.replace('"https://stage.scrollback.io/me?platform=android"', '"https://scrollback.io/me?platform=android&app-version=' + argv[3] + '"');
}
console.log("Index:", index);
fs.writeFileSync("www/index.html", index, 'utf8');
