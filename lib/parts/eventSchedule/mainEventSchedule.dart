//https://www.youtube.com/watch?v=KlgVI4dQC4E

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:son_roe/locator.dart';
import 'package:son_roe/parts/eventSchedule/selectionPage.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

class MainEventSchedule extends StatefulWidget {
  @override
  _MainEventScheduleState createState() => _MainEventScheduleState();
}

class _MainEventScheduleState extends State<MainEventSchedule>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  GetStorage box;
  int _dropdownIndex = 0;

  @override
  void initState() {
    super.initState();
    box = getIt<GetStorage>();
    tabController = TabController(length: titles.length, vsync: this);
    if (box.read('indexOfNotificationEventSunday') != null) {
      _dropdownIndex = box.read('indexOfNotificationEventSunday');
    }
  }

  fab({DateTime time}) {
    var game = tz.TZDateTime.now(tz.getLocation('America/Noronha'));
    print('GAME : ' + game.toString());

    game = tz.TZDateTime.utc(
        game.year, game.month, game.day, game.hour, game.minute, game.second);
    print('1 : ' + game.toString());

    var converted = game.toLocal();

    var local = DateTime.now();
    print('2 : ' + converted.toString()); 
  }

  @override
  Widget build(BuildContext context) {
    // var time = DateTime(DateTime.now().year,DateTime.now().month);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: fab(),
          child: Icon(Icons.dangerous),
        ),
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(.7),
          title: Text('Schedule'),
        ),
        body: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index != 6)
                  Get.to(SelectionPage(indexOfDay: index));
                else
                  Get.to(SelectionPage(indexOfDay: _dropdownIndex));
              },
              child: Card(
                color: Colors.black45,
                child: ListTile(
                  title: _itemBody(index),
                ),
              ),
            );
          },
        ));
  }

  Widget _itemBody(int index) {
    if (index != 6)
      return Text(titles[index], style: TextStyle(color: Colors.white70));
    else
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titles[index],
            style: TextStyle(color: Colors.white70),
          ),
          DropdownButton(
            hint: Text(_dropDownTitle(), style: TextStyle(color: Colors.white70)),
            items: _dropdownMenuItem(),
            onChanged: (value) {
              setState(() {
                _dropdownIndex = value;
                box.write('indexOfNotificationEventSunday', _dropdownIndex);
              });
            },
          )
        ],
      );
  }

  String _dropDownTitle() {
    return freeDevMap.keys.firstWhere(
      (element) => freeDevMap[element] == _dropdownIndex,
      orElse: () => null,
    );
  }

  _dropdownMenuItem() {
    List<DropdownMenuItem> itemList = List();
    freeDevMap.forEach((key, value) {
      itemList.add(DropdownMenuItem(
        child: Text(key),
        value: value,
      ));
    });
    return itemList;
  }

  Map<String, int> freeDevMap = {
    'Gathering': 0,
    'Building': 1,
    'Research': 2,
    'Hero': 3,
    'Training': 4,
    'Killing': 5,
  };
  List<String> titles = [
    'Gathering',
    'Building',
    'Research',
    'Hero',
    'Training',
    'Killing',
    'Free dev'
  ];
}
