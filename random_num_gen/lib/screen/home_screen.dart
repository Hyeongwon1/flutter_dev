import 'dart:js_interop';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_num_gen/constant/color.dart';
import 'package:random_num_gen/screen/settings_screen.dart';

import '../component/number_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNum = 1000;
  List<int> randomNumbers = [123, 456, 789];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(onPressed: onSettingsPop),
                _Body(randomNumbers: randomNumbers),
                _Footer(onPressed: onRandomNumberGen)
              ],
            ),
          ),
        ));
  }

  void onSettingsPop() async {
    final int ? result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingsScreen(
            maxNumber: maxNum,
          );
        },
      ),
    );
    if (result != null) {
      setState(() {
        maxNum = result;
      });
    }
  }

  void onRandomNumberGen() {
    final rand = Random();

    final Set<int> newNum = {};
    while (newNum.length != 3) {
      final num = rand.nextInt(maxNum);

      newNum.add(num);
    }

    setState(() {
      randomNumbers = newNum.toList();
    });

    print(rand.nextInt(maxNum));
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜숫생',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.settings,
              color: RED_COLOR,
            ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({super.key, required this.randomNumbers});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: randomNumbers
          .asMap()
          .entries
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(bottom: e.key == 2 ? 0 : 16.0),
              child: NumberRow(number: e.value),
            ),
          )
          .toList(),
    ));
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: RED_COLOR,
          ),
          onPressed: onPressed,
          child: Text('생성하기')),
    );
  }
}
