import 'tokens.dart';

// input file -> strip non-symbols -> trim repeats -> translate to bin
// file.dart  -> linter.dart       -> linter.dart  -> translator.dart

String toBin(List<String> input,
    [bool logisim = true, bool compressed = true]) {
  String buffer = '';

  // List of strings -> one string
  for (String line in input) {
    buffer += line;
  }

  // insert proper control commands
  input = putSymbols(trim(buffer));

  // bf code -> 'machine' code
  // logisim needs 8 numbers per line
  buffer = 'v2.0 raw';
  if (logisim) {
    buffer = logi(compressed, input);
  }

  return buffer;
}

List<String> trim(String buffer) {
  List<String> iHateRegExp = [];
  while (buffer.isNotEmpty) {
    iHateRegExp.add(buffer.substring(0, 1));
    buffer = buffer.substring(1);
  }

  iHateRegExp.removeWhere((element) => !symbolMap.containsKey(element));

  return iHateRegExp;
}

List<String> putSymbols(List<String> buffer) {
  String last = '';
  List<String> iHateRegExp = [];

  for (String char in buffer) {
    if (char != last) {
      switch (last) {
        case '+':
          {
            // iHateRegExp.add(symbolMap['/']!);
            iHateRegExp.add(')');
          }
          break;
        case '-':
          {
            // iHateRegExp.add(symbolMap['/']!);
            iHateRegExp.add(')');
          }
          break;
        case '<':
          {
            // iHateRegExp.add(symbolMap['\\']!);
            iHateRegExp.add('(');
          }
          break;
        case '>':
          {
            // iHateRegExp.add(symbolMap['\\']!);
            iHateRegExp.add('(');
          }
          break;
      }
    }
    iHateRegExp.add(char);

    if (char == '[') {
      iHateRegExp.add('^');
    }
    if (char == ']') {
      iHateRegExp.add('?');
    }
    last = char;
  }

  // HALT
  iHateRegExp.add('%');

  //   buffer.replaceAll(RegExp(r'[^$key]'), '$key$replacement');
  // });

  //buffer.replaceAll(RegExp(r'[+-><{},.]'), replace)
  //buffer.replaceAll(RegExp(r']'), ']_');

  return iHateRegExp;
}

String logi(bool compressed, List<String> lines) {
  int index = 0;
  const String header = 'v2.0 raw';
  String buffer = header;

  // commands -> hex
  lines = getCodes(lines);

  if (compressed) {
    lines = compress(lines);
  }
  while (index < lines.length) {
    if (index % 8 == 0) {
      buffer += '\n';
    }
    buffer += '${lines[index]} ';
    index++;
  }
  buffer += '\n';
  return buffer;
}

List<String> compress(List<String> lines) {
  int count = -1;
  String last = '';
  String current = '';
  List<String> small = [];

  for (String char in lines) {
    last = current;
    current = char;
    count++;
    if (char != last) {
      if (small.isNotEmpty) {
        if (count > 3) {
          small.last = '$count*${small.last}';
        } else {
          while (count > 1) {
            small.add(last);
            count--;
          }
        }
        count = 0;
      }
      small.add(char);
    }
  }

  return small;
}

// Symbols
Map<String, String> symbolMap = {
  '>': '1',
  '<': '2',
  '+': '3',
  '-': '4',
  '[': '5',
  ']': '6',
  '.': '7',
  ',': '8',
  ';': 'b',
  // internal machine instructions
  '/': '0',
  '\\': '9',
  '_': 'a'
};
