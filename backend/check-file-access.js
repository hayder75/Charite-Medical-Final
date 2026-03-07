const fs = require('fs');
const path = require('path');

const filePathRelative = 'uploads/patient-gallery/1770852982036-618522917.jpg';
const filePathAbsolute = path.join(__dirname, filePathRelative);

console.log('Checking file:', filePathAbsolute);

if (fs.existsSync(filePathAbsolute)) {
    console.log('File exists!');
    try {
        const stats = fs.statSync(filePathAbsolute);
        console.log('Size:', stats.size);
        console.log('Permissions:', stats.mode);

        // Try reading
        const content = fs.readFileSync(filePathAbsolute);
        console.log('Read success. First 10 bytes:', content.subarray(0, 10));
    } catch (e) {
        console.error('Error reading file:', e.message);
    }
} else {
    console.error('File does NOT exist!');

    // List directory to see what is there
    const dir = path.dirname(filePathAbsolute);
    console.log('Listing directory:', dir);
    if (fs.existsSync(dir)) {
        console.log(fs.readdirSync(dir));
    } else {
        console.log('Directory does not exist');
    }
}
