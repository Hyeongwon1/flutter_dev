import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MainLayout(
        title: "homeScreen",
        children: [
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
              Navigator.of(context).pop();
            },
            child: Text('pop'),
          ),
          ElevatedButton(
              onPressed: () async {
                final result = await
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => RouteOneScreen(number: 123,),
                  ),
                );
      
                print(result);
              },
              child: Text('push')),
      
        ],
      ),
    );
  }
}
