import 'package:flutter/material.dart';
import '../../constant.dart';

class RoundedRaisedButton extends StatelessWidget {
  bool isLoading;
  String title;
  Color titleColor, buttonColor;
  Function onPress;
  RoundedRaisedButton({
    this.title,
    this.onPress,
    this.titleColor = kWhiteColor,
    this.buttonColor = kPrimaryColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  width: 20,
                  height: 20,
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white),
                ),
              )
            : Text(
                this.title,
                style: TextStyle(color: titleColor, fontSize: 16),
              ),
        color: buttonColor,
        disabledColor: buttonColor,
        onPressed: isLoading ? null : this.onPress,
      ),
    );
  }
}
