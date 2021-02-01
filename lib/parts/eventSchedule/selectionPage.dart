import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:son_roe/locator.dart';
import 'package:son_roe/parts/events/page1/controller/controllertime.dart';

class SelectionPage extends StatefulWidget {
  final int indexOfDay;

  const SelectionPage({Key key, @required this.indexOfDay}) : super(key: key);
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  ControllerServerTime _controllerServerTime;

  List<String> wholeList = [];
  var switchList = [];
  GetStorage box;

  @override
  void initState() {
    super.initState();
    box = getIt<GetStorage>();
    _controllerServerTime = Get.find<ControllerServerTime>();

    List<String> eventList = [];

    for (var i = 0; i < 8; i++) {
      if (widget.indexOfDay != 6) {
        eventList.add(_controllerServerTime
            .modelEvents.weekday[widget.indexOfDay].daycontents[i].eventtitle);
      }
    }
    wholeList.addAll(eventList);
    wholeList.addAll(eventList);
    wholeList.addAll(eventList);

    //FIX Eğer switch listesi boş ise yeni oluştur
    if (box.read('${widget.indexOfDay}statusOfNotificationEventSwitches') == null) {
      switchList = List.generate(24, (index) => false);
    } else {
      switchList = box.read('${widget.indexOfDay}statusOfNotificationEventSwitches');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.7),
        title: Text('Selection Page'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: wholeList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            subtitle: Text(
              'Game Time : ${_time(index)}:05',
              style: TextStyle(fontSize: 10, color: Colors.white54),
            ),
            title: Text(
              wholeList[index],
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            leading: Icon(
              Icons.alarm,
              color: switchList[index]?Colors.green:Colors.grey,
            ),
            trailing: Switch(
              activeColor: Colors.white,
              inactiveThumbColor: Colors.grey.shade700,
              value: switchList[index],
              onChanged: (value) {
                setState(() {
                  _onTimeSet(day: widget.indexOfDay, hour: index);
                  switchList[index] = !switchList[index];
                });
              },
            ),
          );
        },
      ),
    );
  }

  _onTimeSet({int day, int hour}) {
    assert(day != null, hour != null);

    //YAP >>SET NOTIFICATION<< YAPILAN SEÇİME GÖRE NOTIFICATION AYARLA
    print('Time is set\nHour:$hour Day:$day');
  }

  String _time(int index) => index < 10 ? '0$index' : '$index';

  @override
  void dispose() {
    //BILGI Kullanıcının ayarladıgı tüm bildirim istekleri buranın içinde
    
    box.write('${widget.indexOfDay}statusOfNotificationEventSwitches', switchList);
    super.dispose();
  }
}
