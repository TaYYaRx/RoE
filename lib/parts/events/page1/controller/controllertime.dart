import 'package:son_roe/parts/events/page1/controller/controllerNextEvent.dart';
import 'package:timezone/timezone.dart';

import '../../utility/services_event.dart';

class ControllerServerTime extends GetxController {
  ModelEvents modelEvents;
  ControllerNextEvent _controllerNextEvent;

  final modelTimes = ModelServerTime().obs;
  final modelListOfChest = ModelChests([]).obs;
  final currentEventContents = ModelEventContentList([]).obs;
  var currentEventTitle = 'CurrentEvent'.obs;
  var gunBelirleyici = 0.obs;

  //Sunday event: Default KE
  var sundayEventPicked = 5.obs;
  var dayIndex = 0;

  updateTime({@required TZDateTime time}) {
    modelTimes.update((modelTime) {
      modelTime.sec = time.second;
      modelTime.min = time.minute;
      modelTime.hr = _hourAdjustment(time.hour);
      modelTime.day = time.weekday - 1;
      modelTime.reverse = reverseTime(time);
      modelTime.serverTime = timerBeatify(time);

      if (modelTime.day == 6) {
        dayIndex = sundayEventPicked.value;
      } else {
        dayIndex = modelTime.day;
      }

      currentEventTitle.value =
          modelEvents.weekday[dayIndex].daycontents[modelTime.hr].eventtitle;

      currentEventContents.update((eventModel) {
        eventModel.eventList =
            modelEvents.weekday[dayIndex].daycontents[modelTime.hr].eventContent;
      });

      modelListOfChest.update((chests) {
        chests.castleLv =
            modelEvents.weekday[dayIndex].daycontents[modelTime.hr].castlelv;
      });

      nextEventCalculator(time.hour, time.weekday - 1);
    });
  }

  nextEventCalculator(int hour, int dayT) {
    String nextEventTitle = '';
    int day = dayT;
    int hr = (hour + 1) == 24 ? 0 : (hour + 1);

    day = (day == 6 && hour == 23)
        ? 0
        : hour == 23
            ? (day == 5 ? sundayEventPicked.value : day + 1)
            : day;

    nextEventTitle = modelEvents.weekday[day].daycontents[_hourAdjustment(hr)].eventtitle;
    _controllerNextEvent.updateNextEventTitle(nextEventTitle);
  }

  String timerBeatify(TZDateTime time) {
    return ((time.hour) < 10 ? '0${time.hour}' : '${time.hour}') +
        ' : ' +
        ((time.minute < 10) ? '0${time.minute}' : '${time.minute}') +
        ' : ' +
        (time.second < 10 ? '0${time.second}' : '${time.second}');
  }

  String reverseTime(TZDateTime time) {
    var rv = time.subtract(Duration(seconds: 1));

    var rs = 60 - rv.second;
    return (59 - rv.minute) < 10
        ? '0${59 - rv.minute}'
        : '${59 - rv.minute}' +
            ' : ' +
            ((rs == 60)
                ? 0.toString()
                : rs < 10
                    ? '0${(rs == 60) ? 0 : rs}'
                    : '${(rs == 60) ? 0 : rs}');
  }

  int _hourAdjustment(int hr) => hr == 8 || hr == 16
      ? 0
      : (hr == 9 || hr == 17)
          ? 1
          : (hr == 10 || hr == 18)
              ? 2
              : (hr == 11 || hr == 19)
                  ? 3
                  : (hr == 12 || hr == 20)
                      ? 4
                      : (hr == 13 || hr == 21)
                          ? 5
                          : (hr == 14 || hr == 22)
                              ? 6
                              : (hr == 15 || hr == 23)
                                  ? 7
                                  : hr;

  updateSundayViaDropdown(int sundayIndex) {
    sundayEventPicked.value = sundayIndex;
    print('updateSundayViaDropdown');
  }

  @override
  void onInit() async {
    super.onInit();
    _controllerNextEvent = Get.put(ControllerNextEvent());
    var ddcontroller = Get.put(ControllerDropdownMenu());
    sundayEventPicked = ddcontroller.sundayEventIndex;

    RepositoryClass repo = getIt<RepositoryClass>();
    repo.fetchJsonData().then((value) {
      modelEvents = value;
    });
  }
}

/*  int _dateLine(int hour, int day) {
    if (Get.find<ControllerServerTime>().realDay == 6 && hour == 23) {
      //PAZARDAN PAZARTESİYE GEÇİŞ
      return 0;
    } else {
      return hour == 23
          ? (day == 5
              ? Get.find<ControllerDropdownMenu>().sundayEventIndex.value
              : day + 1)
          : day;
    }
  }*/
