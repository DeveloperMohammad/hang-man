import 'package:flutter/material.dart';
import 'package:hang_man/model/alphabet_button.dart';

const scoresTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontFamily: 'PatrickHand',
);

const playScreenScoreTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const playScreenLettersTextStyle = TextStyle(
  fontSize: 35,
  color: Colors.white,
  fontFamily: 'FireMono',
);

const playScreenAlphabetsTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 20,
  fontFamily: 'PatrickHand',
);

const gameOverDialogContentTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.green,
  fontFamily: 'FiraMono',
);

const gameOverDialogTitleTextStyle = TextStyle(
  fontSize: 35,
  color: Colors.red,
  fontFamily: 'PatrickHand',
);

List<AlphabetButton> alphabets = [
  AlphabetButton(alphabet: 'A', isUsed: false),
  AlphabetButton(alphabet: 'B', isUsed: false),
  AlphabetButton(alphabet: 'C', isUsed: false),
  AlphabetButton(alphabet: 'D', isUsed: false),
  AlphabetButton(alphabet: 'E', isUsed: false),
  AlphabetButton(alphabet: 'F', isUsed: false),
  AlphabetButton(alphabet: 'G', isUsed: false),
  AlphabetButton(alphabet: 'H', isUsed: false),
  AlphabetButton(alphabet: 'I', isUsed: false),
  AlphabetButton(alphabet: 'J', isUsed: false),
  AlphabetButton(alphabet: 'K', isUsed: false),
  AlphabetButton(alphabet: 'L', isUsed: false),
  AlphabetButton(alphabet: 'M', isUsed: false),
  AlphabetButton(alphabet: 'N', isUsed: false),
  AlphabetButton(alphabet: 'O', isUsed: false),
  AlphabetButton(alphabet: 'P', isUsed: false),
  AlphabetButton(alphabet: 'Q', isUsed: false),
  AlphabetButton(alphabet: 'R', isUsed: false),
  AlphabetButton(alphabet: 'S', isUsed: false),
  AlphabetButton(alphabet: 'T', isUsed: false),
  AlphabetButton(alphabet: 'U', isUsed: false),
  AlphabetButton(alphabet: 'V', isUsed: false),
  AlphabetButton(alphabet: 'W', isUsed: false),
  AlphabetButton(alphabet: 'X', isUsed: false),
  AlphabetButton(alphabet: 'Y', isUsed: false),
  AlphabetButton(alphabet: 'Z', isUsed: false),
];


