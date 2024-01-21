import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int? number;

  const RouteOneScreen({this.number, super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Route 1',
      children: [
        Text(
          'arguments : ${number.toString()}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            print(Navigator.of(context).canPop());
          },
          child: Text('Can Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          child: Text('maybePop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(number);
          },
          child: Text('pop'),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RouteTwoScreen(),
                  settings: RouteSettings(
                    arguments: 789
                  )
                ),
              );
            },
            child: Text(
              'push',
            )),
      ],
    );
  }
}
