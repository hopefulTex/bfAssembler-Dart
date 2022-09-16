# bf Assembler
This is an assembler(?), written in dart, for my W.I.P. bfCPU running in Logisim.

## How To Assemble
- Install Dart from https://dart.dev/get-dart
- Clone then 'cd' this repository
- Exectute ```dart run bin/translator.dart -i infilename -o outfilename``` without the quotes


## How To Run Machine
- Get Java (sorry)
- Grab logisim from https://sourceforge.net/projects/circuit/
- Run ```java -jar path/to/logisim.jar```
- Click 'File', 'Open...'
- Open the .circ file from the logisim program
- Right click the ROM towards the left
- Click "Load Image..."
- Select your .lgsm 'binary' file
- Click 'Simulate', 'Simulation Enabled'
- Click 'Simulate', 'Ticks Enabled'
