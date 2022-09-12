import 'package:flutter/material.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: "Quiz",
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
                fontSize: 20
              )
            ),
            TextSpan(
                text: "Maker",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  fontSize: 20
                )
            ),
          ]
        )
    );
  }
}
