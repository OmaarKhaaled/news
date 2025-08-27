import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  String errorMessage;
  ErrorIndicator({this.errorMessage = 'some thing went wrong'});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage));
  }
}
