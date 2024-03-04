void main() {
  String text = "bdfbdfbdsfДАННЫЕННННННывамцымцуфыафыафы";
  String pattern = "ДАННЫЕННННННН";
  int index = boyerMoore(text, pattern);

  if (index != -1) {
    print("Pattern found at index: $index");
  } else {
    print("Pattern not found in the text.");
  }
}

Map<String, int> buildBadCharacterTable(String pattern) {
  final badCharacterTable = <String, int>{};
  final patternLength = pattern.length;
  final count = countSameCharactersAtEnd(pattern);
  for (int i =0 ; i < patternLength - count ; i++) {
    // badCharacterTable.putIfAbsent(pattern[i], () =>  patternLength - i );
    badCharacterTable[pattern[i]] = patternLength - count - i;
  }

  if ( !badCharacterTable.containsKey(pattern[patternLength - 1])  ){
    badCharacterTable[pattern[patternLength - 1]] = patternLength;
  }

  return badCharacterTable;
}

int boyerMoore(String text, String pattern) {
  final textLength = text.length;
  final patternLength = pattern.length;

  final badCharacterTable = buildBadCharacterTable(pattern);

  int offset = 0;

  while (offset <= textLength - patternLength ) {
    int shift = 1 ;
    int i = patternLength - 1;

    for (i; i >= 0; i--) {
      final patternLetter = pattern[i];
      final textLetter = text[offset + i];
      if (patternLetter != textLetter) {
        final offsetFromTable = badCharacterTable[textLetter];
        shift = offsetFromTable ?? patternLength;
        break;
      }

    }
    if (i == -1){
      return offset;
    }

    offset += shift;

  }

  return -1;
}

int countSameCharactersAtEnd(String text) {
  if (text.isEmpty) {
    return 0;
  }

  int count = 1;
  int i = text.length - 1;
  while (i > 0 && text[i] == text[i - 1]) {
    count++;
    i--;
  }

  return count;
}