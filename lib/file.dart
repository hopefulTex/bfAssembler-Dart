// TODO: MOVE get() TO HELPER FUNC

import 'dart:io';

Future<bool> exists(String file) async {
  return await File.fromUri(Uri(path: file)).exists();
}

Future<List<String>> get(String file) async {
  return await open(file);
}

Future<List<String>> open(String file) async {
  return await File(file).readAsLines();
}

void write(String path, String lines) {
  File file = File(path);
  if (file.existsSync()) {
    file.copySync('$path.old');
  }
  file.createSync(recursive: true);
  file.writeAsStringSync(lines);
}
