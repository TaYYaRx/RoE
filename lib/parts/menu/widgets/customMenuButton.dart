import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';

class CustomMenuButton extends StatelessWidget {
  const CustomMenuButton({
    Key key,
    @required this.onPressed,
    @required this.buttonTitle,
  }) : super(key: key);

  final Function onPressed;
  final String buttonTitle;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: ImageButton(
        children: <Widget>[
          Text(
            buttonTitle,
            style: TextStyle(color: Colors.white70, fontSize: 18),
          )
        ],
        width: size.width * 0.60,
        height: size.height * 0.15,
        paddingTop: 0,
        pressedImage: Image.asset(
          "assets/images/buttonStock2.png",
        ),
        unpressedImage: Image.asset("assets/images/buttonStock3.png"),
        onTap: onPressed,
      ),
    );
  }
}
/**
 *  width: size.width * 0.70,
        height: size.height * 0.20,
 */