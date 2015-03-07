**Prerequisites:**

Android SDK http://developer.android.com/sdk/installing/index.html
node.js http://nodejs.org/

After you got node.js running, install cordova and grunt

> npm install -g cordova
> npm install -g grunt-cli
> 

clone this repository
> git clone https://github.com/HSLteam1/hslnavi.git

go to repository and add android platform
> cordova platform add android

goto www directory
> cd www

install all dependencies
> npm install

build navigator (translates .coffe to .js)
> grunt

move up again
> cd ../

build apk
> cordova build

install apk
> adb install platforms\android\ant-build\MainActivity-debug.apk