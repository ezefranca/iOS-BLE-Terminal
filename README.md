iOS-BLE-Terminal
================

Sample iOS app to demonstrate the bidirectional communication with Red Bear Lab BLE Shield for Arduino.

## Overview

1. [System requirements](README.md#system-requirements)
2. [Dependencies](README.md#dependencies)
3. [Talking to Arduino](README.md#talking-to-arduino)
4. [Credits / Acknowledgements](README.md#credits--acknowledgements)
5. [License](README.md#license)

## System requirements

iOS 7.0+

## Dependencies

iOS-BLE-Terminal uses Red Bear Lab's [BLE framework](https://github.com/RedBearLab/iOS) to connect to the BLE Shield. After cloning the iOS-BLE-Terminal repository please run the following commands from a terminal to download the most recent version of NMSSH.
```
cd iOS-BLE-Terminal
git submodule update --init
```


## Talking to Arduino

Please refer to the Simple Chat example from [Red Bear Lab's Arduino library](https://github.com/RedBearLab/ble-sdk-arduino). 

## Credits / Acknowledgements

This project uses Red Bear Lab's [BLE framework](https://github.com/RedBearLab/iOS).

## License

The MIT License (MIT)

Copyright (c) 2014 Jens Meder

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
