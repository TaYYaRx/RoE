import 'package:flutter/material.dart';

class TestDosyasi extends StatefulWidget {
  @override
  _TestDosyasiState createState() => _TestDosyasiState();
}

class _TestDosyasiState extends State<TestDosyasi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Stepper(
                  steps: [
                    Step(
                        title: Text('Title-1'),
                        content: Text('Yapılacak işlemler')),
                    Step(
                        title: Text('Title-2'),
                        content: Text('Yapılacak işlemler2')),
                  ],
                ),
              ),
              RaisedButton(onPressed: () {
                print(List.generate(6, (index) => index));
              })
            ],
          ),
        ),
      ),
    );
  }
}
