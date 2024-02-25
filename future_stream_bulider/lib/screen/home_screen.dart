import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 16.9);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<int>(
          stream: streamNumbers(),
          builder: (context, snapshot) {

            //로딩중일때 렌더링

            // if(!snapshot.hasData){
            //     return Center(child: CircularProgressIndicator(),);
            //   }
            // if(snapshot.connectionState ==ConnectionState.waiting){
            //   return Center(child: CircularProgressIndicator(),);
            // }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'StreamBuilder',
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
                Text(
                  'conState${snapshot.connectionState}',
                  style: textStyle,
                ),
                Text(
                  'conState${snapshot.data}',
                  style: textStyle,
                ),
                Text(
                  'conState${snapshot.error}',
                  style: textStyle,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text('setState')),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));

    final random = Random();

    //throw Exception('에러발생');

    return random.nextInt(100);
  }

  Stream<int> streamNumbers() async* {
    for (int i = 0; i < 10; i++) {

      if(i ==5){
        throw Exception('i==5');
      }

      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }
}
