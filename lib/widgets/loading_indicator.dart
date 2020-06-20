import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
          child: Image.asset(
        'assets/images/loading.gif',
        fit: BoxFit.cover,
      ));
}
