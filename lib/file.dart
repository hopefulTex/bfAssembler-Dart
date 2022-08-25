// TODO: MOVE get() TO HELPER FUNC, RECURSIVE INCLUDES IMPLEMENTATION
// TODO: CHECK FOR INFINITE LOOPING INCLUDES
// TODO: INSERT INCLUDES

import 'dart:io';

Future<bool> exists(String file) async {
  return await File.fromUri(Uri(path: file)).exists();
}

Future<List<String>> get(String file) async {
  List<String> lines = [];

  lines = await open(file);

  // expand imports

  return lines;
}

List<String> getImports(List<String> lines) {
  List<String> imports = [];

  imports.addAll(lines.where((element) => element.startsWith('use ')));

  return imports;
}

Future<List<String>> open(String file) async {
  List<String> lines = await File(file).readAsLines();

  //expand(lines);

  return lines;
}

void expand(List<String> lines) {}

void write(String path, String lines) {
  File file = File(path);
  if (file.existsSync()) {
    file.copySync('$path.old');
  }
  file.createSync(recursive: true);
  file.writeAsStringSync(lines);
}
