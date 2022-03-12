import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Future<void> showResultDialog({
  required BuildContext context,
  required String text,
  required IconData icon,
  required Color color,
  required VoidCallback onPressed,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 50,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 24,
                color: color,
              ),
            ),
            IconButton(
              onPressed: () => onPressed(),
              icon: const Icon(
                MdiIcons.arrowRightThick,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}