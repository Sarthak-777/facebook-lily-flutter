import 'package:facebook_lily/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalOrLine extends StatelessWidget {
  const HorizontalOrLine({
    required this.label,
    required this.height,
  });

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: Divider(
              color: Colors.pink,
              height: height,
            )),
      ),
      Text(
        label,
        style: TextStyle(fontSize: 12.0, color: Colors.pink[200]),
      ),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: Colors.pink,
              height: height,
            )),
      ),
    ]);
  }
}
