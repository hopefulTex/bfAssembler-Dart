class Token {
  int size = 0;
  List<String> tokens = [];
}

List<String> getTokens(List<String> chars) {
  List<String> tokens = [];

  tokens.addAll(
      chars.where((char) => extra.containsKey(char) || base.containsKey(char)));
  return tokens;
}

// Token getCode(String token) {
//   Token command = Token();
//   String tmp = '';
//   if (base.containsKey(token)) {
//     command.tokens.add(base[token]!);
//     command.size++;
//     switch (token) {
//       case '>':
//         break;
//       case '<':
//         break;
//       case '[':
//         tmp = '^';
//         break;
//       case ']':
//         tmp = '?';
//         break;
//       default:
//     }
//   }
//   return command;
// }

List<String> getCodes(List<String> chars) {
  List<String> codes = [];
  print(chars);
  for (String char in chars) {
    if (base.containsKey(char)) {
      codes.add(base[char]!);
    }
    if (extra.containsKey(char)) {
      codes.add(extra[char]!);
    }
  }
  print(codes);
  return codes;
}

// base tokens are the core bf instructions
// extra tokens are add-ons for developer convinience

Map<String, String> base = {
  '+': '10000', //Value++
  '-': '10001', //Value--
  '>': '50000', //Mem_Ptr++
  '<': '50001', //Mem_Ptr--
  '[': '80000', //Stack_Ptr++
  ']': 'b0000', //End Loop
  '.': 'c0000', //Output Char
  ',': 'd0000', //Input Char
};

// WILL ABSOLUTELY CHANGE IN THE FUTURE
Map<String, String> extra = {
  '~': '00000', //noop
  '(': '20000', //Load Memory
  '!': '30000', //Load Immediate
  ')': '40000', //Store Memory
  '_': '60000', //Jump
  '=': '70000', //Jump Immediate
  '?': '90000', //Jump Stack
  '^': 'a0000', //PC -> Stack
  '%': 'e0000', //halt
};
