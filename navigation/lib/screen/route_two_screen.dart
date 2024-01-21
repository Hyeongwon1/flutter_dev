import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    return MainLayout(
      title: "route2",
      children: [
        Text(
          'arguments :${arguments}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('pop'),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/three',arguments: 999);
            },
            child: Text(
              'push Named',
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/three'
              ,(route) => route.settings.name =='/');
            },
            child: Text(
              'push Named',
            )),
      ],
    );
  }
}
