import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../screens/home_screen.dart';

Future<void> showGameOverDialog({
  required BuildContext context,
  required String randomWord,
  required int score,
}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Game Over',
              style: gameOverDialogTitleTextStyle,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Word: $randomWord',
                  style: gameOverDialogContentTextStyle,
                ),
                Text(
                  'Score: $score',
                  style: gameOverDialogContentTextStyle,
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
              icon: const Icon(
                Icons.refresh,
                size: 50,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
