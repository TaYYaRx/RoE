import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:son_roe/parts/events/page1/eventMain.dart';

import 'parts/eden/eden.dart';
import 'parts/events/page1/controller/controllertime.dart';
import 'parts/events/utility/services_event.dart';
import 'parts/gathering/gather_settings_page.dart';
import 'parts/gathering/gathering_page.dart';

// ignore: must_be_immutable
class MenuPage extends StatelessWidget {
  Timer timer;
  bool isTimerOn = true;
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
                    fit: BoxFit.fill, image: AssetImage('assets/images/iceandfire.jpg'))),
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
                    buttonTitle: 'Events',
                    onPressed: () {
                      RepositoryClass repo = getIt<RepositoryClass>();
                      try {
                        _startTimer(repo);
                        Get.to(EventMainPage(timer: timer));
                      } catch (e) {
                        print('ERROR ::::=> $e');
                      }
                    },
                  ),
                  CustomMenuButton(
                    buttonTitle: 'EDEN - ROC',
                    onPressed: () {
                      Get.to(MainEDEN());
                    },
                  ),
                  CustomMenuButton(
                    buttonTitle: 'T9 Calculator',
                    onPressed: () {
                      Get.to(T9ManuPage());
                    },
                  ),
                  CustomMenuButton(
                    buttonTitle: 'Zone Conflict',
                    onPressed: () {
                      Get.to(ZoneConflictMainPage());
                    },
                  ),
                  CustomMenuButton(
                    buttonTitle: 'Gather',
                    onPressed: () {
                      getIt<GetStorage>().read('isSettingsDone') == null
                          ? Get.to(SettingsPageOfGathering())
                          : Get.to(MainGatheringPage());
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _startTimer(RepositoryClass repo) {
    var time;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      time = repo.fetchServerTime();

      _controller.updateTime(time: time);
    });
  }
}
