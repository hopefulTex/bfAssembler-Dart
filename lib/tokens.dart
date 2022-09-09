class Token {
  int size = 0;
  List<String> tokens = [];
}

List<String> getTokens(List<String> chars) {
  List<String> tokens = [];

  tokens.addAll(chars.where((char) => base.containsKey(char)));

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

// base tokens are the core bf instructions
// extra tokens are add-ons for developer convinience

Map<String, String> base = {
  '>': '10000', //Stack_Ptr++
  '<': '10001', //Stack_Ptr--
  '+': '50000', //Value++
  '-': '50001', //Value--
  '[': '80000', //Start Loop
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
  '?': '90000', //Stack -> PC
  '^': 'a0000', //PC -> Stack
  '%': 'e0000', //halt
};
