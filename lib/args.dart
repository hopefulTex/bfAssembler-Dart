import 'package:args/args.dart';
import 'dart:io';

class Args {
  bool verbose = false;
  // logisim binary compression, not instruction compression
  bool compressed = true;
  bool logisim = true;
  //bool optimized = results['optimize'];
  String outFile = 'main.lgsm';
  String inFile = 'main.lgsm';

  void getArgs(List<String> arguments) {
    if (arguments.isNotEmpty) {
      useLib(arguments);
      return;
    }
    prompt();
    return;
  }

  void useLib(List<String> arguments) {
    ArgParser parser = ArgParser();
    parser.addFlag('compressed', abbr: 'c', defaultsTo: true);
    parser.addFlag('logisim', abbr: 'l', defaultsTo: true);
    parser.addFlag('verbose', abbr: 'v', defaultsTo: false);
    parser.addOption('infile', abbr: 'i', defaultsTo: 'main.bf');
    parser.addOption('outfile', abbr: 'o', defaultsTo: 'main.lgsm');
    //parser.addFlag('optimize', abbr: 'o', defaultsTo: false);
    var results = parser.parse(arguments);

    verbose = results['verbose'];

    compressed = results['compressed'];
    logisim = results['logisim'] || compressed;
    //optimized = results['optimize'];
    outFile = results['outfile'];
    inFile = results['infile'];
  }

  void prompt() {
    print('Input file: ');
    String? tmp;
    while (tmp == null) {
      tmp = stdin.readLineSync();
    }
    inFile = tmp;
    tmp = null;

    print('Output file: ');
    while (tmp == null) {
      tmp = stdin.readLineSync();
    }
    outFile = tmp;
    tmp = null;

    while (tmp == null) {
      print('Compress output? (Default is yes) [y/n]: ');
      tmp = stdin.readLineSync();
      switch (tmp) {
        case 'Y':
          break;
        case 'y':
          break;
        case 'N':
          compressed = false;
          break;
        case 'n':
          compressed = false;
          break;
        default:
          tmp = null;
          break;
      }
    }
  }
}
