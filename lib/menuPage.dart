
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:son_roe/parts/eden/eden.dart';
import 'package:son_roe/parts/events/page1/controller/controllertime.dart';
import 'package:son_roe/parts/events/page1/eventMain.dart';
import 'package:son_roe/parts/events/utility/models/model_events.dart';
import 'package:son_roe/parts/events/utility/services_event.dart';
import 'package:son_roe/parts/gathering/gather_settings_page.dart';
import 'package:son_roe/parts/gathering/gathering_page.dart';
import 'package:time_machine/time_machine.dart';

// ignore: must_be_immutable
class MenuPage extends StatelessWidget {
  Timer _timer;
  bool isTimerOn = true;
  ZonedDateTime _zonedDateTime;
  LocalTime _currentTime;
  LocalTime _reverseTime;
  int day;

  ControllerServerTime _controller = Get.find<ControllerServerTime>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
                color: Color(0xFF222222),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/iceandfire.jpg'))),
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 36),
                    child: Center(
                        child: Text(
                      'RISE OF EMPIRES ICE AND FIRE',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  CustomMenuButton(
                      onPressed: () async {
                        try {
                          var repo = getIt<RepositoryClass>();

                          _zonedDateTime = await repo.fetchServerTime();
                          ModelEvents model = await repo.fetchJsonData();

                          _initEventPage();

                          Get.to(EventMainPage(
                            timer: _timer,
                            eventModel: model,
                            contentList: model
                                .weekday[
                                    _sunday(_zonedDateTime.dayOfWeek.value - 1)]
                                .daycontents[_controller.model.value.hr]
                                .eventContent,
                          ));
                        } catch (e) {
                          print(e);
                        }
                      },
                      buttonTitle: 'Events'),
                  CustomMenuButton(
                      onPressed: () {
                        Get.to(MainEDEN());
                      },
                      buttonTitle: 'EDEN - ROC'),
                  CustomMenuButton(
                      onPressed: () {
                        Get.to(T9ManuPage());
                      },
                      buttonTitle: 'T9 Calculator'),
                  CustomMenuButton(
                      onPressed: () {
                        Get.to(ZoneConflictMainPage());
                      },
                      buttonTitle: 'Zone Conflict'),
                  CustomMenuButton(
                      onPressed: () {
                        getIt<GetStorage>().read('isSettingsDone') == null
                            ? Get.to(SettingsPageOfGathering())
                            : Get.to(MainGatheringPage());
                      },
                      buttonTitle: 'Gather'),
                ],
              ),
            ),
          )),
    );
  }

  int _sunday(int day) =>
      (day == 6) ? _controller.sundayEventPicked.value : day;

  _initEventPage() async {
    _currentTime = _zonedDateTime.clockTime; // Assigning hh:mm:ss

    _reverseTime = LocalTime(0, (59 - _currentTime.minuteOfHour),
        (60 - _currentTime.secondOfMinute)); // Kalan süre

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime = _currentTime.addSeconds(1);
      _reverseTime = _reverseTime.subtractSeconds(1);
      day = _zonedDateTime.dayOfWeek.value - 1;

      _controller.updateTime(
          // Modelin güncellendiği yer
          localTime: _currentTime,
          reverseTime: _reverseTime,
          day: day);
    });
  }
}
