// TODO: CALL OPTIMIZATION (after cpu refactoring)
// TODO: ADD HELP TO ARGS

import 'package:translator/translator.dart' as translator;
import 'package:translator/file.dart' as file;
import 'package:args/args.dart';

Future<int> main(List<String> arguments) async {
  // args
  ArgParser parser = ArgParser();
  parser.addFlag('compressed', abbr: 'c', defaultsTo: true);
  parser.addFlag('logisim', abbr: 'l', defaultsTo: true);
  parser.addOption('infile', abbr: 'i', defaultsTo: 'main.bf');
  parser.addOption('outfile', abbr: 'o', defaultsTo: 'main.lgsm');
  //parser.addFlag('optimize', abbr: 'o', defaultsTo: false);
  var results = parser.parse(arguments);

  // compressed implies using logisim
  bool compressed = results['compressed'];
  bool logisim = results['logisim'] || compressed;
  //bool optimized = results['optimize'];

  String outFile = results['outfile'];
  String inFile = results['infile'];

  if (!await file.exists(inFile)) {
    print('Error: file $inFile not found');
    return 1;
  }

  print('main: getting file');
  List<String> inputLines = await file.get(inFile);
  print('main: got file');

  print('main: making bin');
  String binLines = translator.toBin(inputLines, logisim, compressed);
  print('main: made bin');

  print(binLines);
  // if (compressed) {
  //   binLines = translator.compress(binLines);
  //   if (optimized) {
  //     binLines = translator.optimize(binLines);
  //   }
  // }

  print('main: writing file');
  file.write(outFile, binLines);
  print('main: wrote file');

  return 0;
}
