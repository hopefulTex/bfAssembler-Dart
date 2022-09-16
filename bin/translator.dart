// TODO: CALL OPTIMIZATION (after cpu refactoring)
// TODO: ADD HELP TO ARGS

import 'package:translator/translator.dart' as translator;
import 'package:translator/file.dart' as file;
import 'package:translator/args.dart';

Future<int> main(List<String> arguments) async {
  // args
  Args args = Args();
  args.getArgs(arguments);
  bool verbose = args.verbose;
  if (!await file.exists(args.inFile)) {
    print('Error: file ${args.inFile} not found');
    return 1;
  }

  if (verbose) print('main: getting file');
  List<String> inputLines = await file.get(args.inFile);
  if (verbose) print('main: got file');

  if (verbose) print('main: making bin');
  String binLines =
      translator.toBin(inputLines, args.logisim, args.compressed, args.verbose);
  if (verbose) print('main: made bin');

  if (verbose) print(binLines);
  // if (compressed) {
  //   binLines = translator.compress(binLines);
  //   if (optimized) {
  //     binLines = translator.optimize(binLines);
  //   }
  // }

  if (verbose) print('main: writing file');
  file.write(args.outFile, binLines);
  if (verbose) print('main: wrote file');

  return 0;
}
