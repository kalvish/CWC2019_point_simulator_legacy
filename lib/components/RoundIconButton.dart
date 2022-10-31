import 'package:flutter/material.dart';

typedef GestureTapCallback = void Function();

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback onPress;

  RoundIconButton({this.icon, this.onPress});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      elevation: 6,
      onPressed: () {
        onPress();
      },
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: /*Color(0xff4c4f5e)*/ Color(0x9964ffda),
    );
  }
}
