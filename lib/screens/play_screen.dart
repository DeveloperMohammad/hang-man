import 'package:flutter/material.dart';
import 'package:hang_man/database/scores_database.dart';
import 'package:hang_man/model/score.dart';
import 'package:hang_man/utilities/dialogs/game_over_dialog.dart';
import 'package:hang_man/utilities/hangman_words.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'dart:math' as math;

import '/screens/home_screen.dart';
import '../constants/constants.dart';
import '../utilities/dialogs/result_dialog.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  static const routeName = '/play';

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  HangmanWords hangmanWords = HangmanWords();

  late List<String> letters;
  late List<String> randomList;
  late String randomWord;
  List<String> _words = [];

  void readWords() {
    _words = hangmanWords.words;
    int randomNumber = math.Random().nextInt(_words.length - 1) + 1;
    randomWord = _words[randomNumber];
    letters = randomWord.characters.toList().map((char) => '_').toList();
    randomList = randomWord.characters.toList().map((char) => char).toList();
  }

  @override
  void initState() {
    readWords();
    super.initState();
  }

  nextLevel() {
    setState(() {
      tries = 5;
      photoIndex = 0;
      isHintUsed = false;
      randomList = randomWord.characters.toList().map((char) => char).toList();
      letters = randomWord.characters.toList().map((char) => '_').toList();
      Navigator.of(context).pop();
    });
  }

  int photoIndex = 0;
  int tries = 5;
  int lives = 5;
  int score = 0;
  bool isHintUsed = false;

  @override
  Widget build(BuildContext context) {
    if (lives < 0) {
      Future.delayed(Duration.zero, () {
        showGameOverDialog(
          context: context,
          randomWord: randomWord,
          score: score,
        ).then((_) {
          ScoreDatabase.instance.insertScore(
            score: Score(date: DateTime.now(), score: score),
          );
        });
      });
    }

    return Scaffold(
      backgroundColor: Colors.deepPurple[700],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: IconButton(
                          icon: const Icon(
                            MdiIcons.heart,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Positioned(
                        child: Text(
                          '$lives',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        top: 15,
                        left: 20,
                      ),
                    ],
                  ),
                  Text('$score', style: playScreenScoreTextStyle),
                  IconButton(
                    icon: Icon(
                      isHintUsed
                          ? MdiIcons.lightbulbOutline
                          : MdiIcons.lightbulb,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isHintUsed == false) {
                          int randomLetterNumber =
                              math.Random().nextInt(letters.length);
                          do {
                            randomLetterNumber =
                                math.Random().nextInt(letters.length);
                            if (letters[randomLetterNumber] == '_') {
                              letters[randomLetterNumber] =
                                  randomList[randomLetterNumber];
                              break;
                            }
                          } while (letters[randomLetterNumber] != '_');
                          isHintUsed = true;
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/images/$photoIndex.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 50),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: letters.map((char) {
                    return Text('$char ', style: playScreenLettersTextStyle);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20, left: 4, right: 4),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 50,
                    ),
                    itemCount: alphabets.length,
                    itemBuilder: (context, index) {
                      return GridTile(
                        child: InkWell(
                          onTap: () {
                            if (lives >= 0) {
                              checkResult(index: index);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                alphabets[index],
                                style: playScreenAlphabetsTextStyle,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkResult({
    required int index,
  }) {
    String char = alphabets[index].toLowerCase();
    for (int i = 0; i < randomList.length; i++) {
      if (randomList[i] == char) {
        setState(() {
          letters[i] = char;
        });
      }
    }
    if (!letters.contains(char)) {
      setState(() {
        photoIndex++;
        tries--;
      });
      if (tries < 0) {
        showResultDialog(
          context: context,
          text: randomWord,
          icon: Icons.clear,
          color: Colors.red,
          onPressed: () {
            nextLevel();
            readWords();
          },
        );
        setState(() => lives--);
      }
    } else {
      if (!letters.contains('_')) {
        showResultDialog(
          context: context,
          text: randomWord,
          icon: Icons.check_circle_outline,
          color: Colors.green,
          onPressed: () {
            nextLevel();
            readWords();
            setState(() {
              score++;
            });
          },
        );
      }
    }
  }
}
