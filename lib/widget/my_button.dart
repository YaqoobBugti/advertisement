import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  MyButton({@required this.text, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blueGrey[300],
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
      ),
    );
  }
}
