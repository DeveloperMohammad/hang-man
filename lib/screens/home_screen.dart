import 'package:flutter/material.dart';
import 'package:hang_man/screens/high_scores_screen.dart';
import 'package:hang_man/screens/play_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[700],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'HANGMAN',
              style: TextStyle(
                  fontSize: 50, color: Colors.white, fontFamily: 'PatrickHand'),
            ),
            Image.asset('assets/images/gallow.png'),
            Column(
              children: [
                menuButton(text: 'Start', onPressed: () {
                  Navigator.of(context).pushNamed(PlayScreen.routeName);
                }),
                const SizedBox(height: 10),
                menuButton(text: 'High Scores', onPressed: () {
                  Navigator.of(context).pushNamed(HighScoreScreen.routeName);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget menuButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: SizedBox(
      width: 120,
      height: 45,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'FiraMono',
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
