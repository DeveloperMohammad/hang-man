import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hang_man/constants/constants.dart';
import 'package:hang_man/database/scores_database.dart';
import 'package:hang_man/screens/home_screen.dart';
import 'package:intl/intl.dart';

import '../model/score.dart';

final _dateFormatter = DateFormat('yy-MMM-dd');

Future<List<Score>>? _scoreList;

class HighScoreScreen extends StatefulWidget {
  static const routeName = '/high_scores';

  const HighScoreScreen({Key? key}) : super(key: key);

  @override
  State<HighScoreScreen> createState() => _HighScoreScreenState();
}

class _HighScoreScreenState extends State<HighScoreScreen> {
  @override
  void initState() {
    super.initState();
    updateScoreList();
  }

  updateScoreList() {
    setState(() {
      _scoreList = ScoreDatabase.instance.getScoreList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[700],
      body: FutureBuilder(
          future: _scoreList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              log(snapshot.data.toString());
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: ListView.builder(
                  itemCount: snapshot.data.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(HomeScreen.routeName);
                                },
                                icon: const Icon(
                                  Icons.home,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              const Text(
                                'High Scores',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: 'PatrickHand',
                                  color: Colors.white,
                                ),
                              ),
                              PopupMenuButton(
                                child: const Icon(Icons.more_vert, size: 40, color: Colors.white),
                                color: Colors.white,
                                onSelected: (value) async {},
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: 'reset',
                                      child: const Text('Reset Scores'),
                                      onTap: () {
                                          ScoreDatabase.instance.deleteAllScores();
                                          updateScoreList();
                                      },
                                    )
                                  ];
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      );
                    } else if (index == 1) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text('Rank', style: scoresTextStyle),
                              Text('Date', style: scoresTextStyle),
                              Text('Score', style: scoresTextStyle),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${index - 1}',
                          style: scoresTextStyle,
                        ),
                        Text(
                          _dateFormatter.format(snapshot.data[index - 2].date),
                          style: scoresTextStyle,
                        ),
                        Text(
                          '${snapshot.data[index - 2].score}',
                          style: scoresTextStyle,
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
