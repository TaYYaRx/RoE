import 'package:son_roe/parts/events/utility/services_event.dart';


class TopSide extends StatelessWidget {
  const TopSide({
    Key key,
    @required ModelEvents model,
  })  : _model = model,
        super(key: key);
  final ModelEvents _model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.21,      
      child: Column(
        children: [
          Row(
            children: [TopLeftWidget(), TopRightWidget(model: _model)],
          ),
          Row(
            children: [BottomLeftWidget(), BottomRightWidget(model: _model)],
          ),
        ],
      ),
    );
  }
}

class TopRightWidget extends StatelessWidget {
  const TopRightWidget({
    Key key,
    @required ModelEvents model,
  })  : _model = model,
        super(key: key);

  final ModelEvents _model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 10, 8, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.58,
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.grey.shade800,
        child: Obx(() {
          var hr = Get.find<ControllerServerTime>().model.value.hr;
          var day = Get.find<ControllerServerTime>().model.value.day;

          return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${_model.weekday[day].daycontents[hr].eventtitle}',
                    style: TextStyle(fontSize: 12,color: Colors.white)),
              ));
        }),
      ),
    );
  }
}

class BottomRightWidget extends StatelessWidget {
  const BottomRightWidget({
    Key key,
    @required ModelEvents model,
  })  : _model = model,
        super(key: key);

  final ModelEvents _model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 10, 8, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.58,
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.grey.shade800,
        child: Obx(() {
          var nextEventHr =
              Get.find<ControllerServerTime>().model.value.nextEventHr;
          var day = Get.find<ControllerServerTime>().model.value.day;
          String _nextEventTitle = _model.weekday[_dateLine(nextEventHr - 1, day)].daycontents[_hourLine(nextEventHr)].eventtitle;
          return Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_nextEventTitle, style: TextStyle(fontSize: 12,color: Colors.white)),
          ));
        }),
      ),
    );
  }

  int _hourLine(int hour) => hour == 24 ? 0 : hour;

  //FIXME PAZAR ve CUMARTESİ günlerini check eder
  int _dateLine(int hour, int day) {
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
  }
}

class TopLeftWidget extends StatelessWidget {
  const TopLeftWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.31,
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.grey.shade800,
        child: Obx(() {
          // String _daY = _day(Get.find<ControllerServerTime>().model.value.day);
          String _daY = _day(Get.find<ControllerServerTime>().realDay);
          String _serverTime = Get.find<ControllerServerTime>()
              .model
              .value
              .serverTime
              .toString();
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(_daY, style: TextStyle(fontSize: 12,color: Colors.white)),
              Text(_serverTime, style: TextStyle(fontSize: 12,color: Colors.white))
            ],
          ));
        }),
      ),
    );
  }

  String _day(int day) {
    return day == 0
        ? 'Monday'
        : (day == 1
            ? 'Tuesday'
            : (day == 2
                ? 'Wednesday'
                : (day == 3
                    ? 'Thursday'
                    : (day == 4
                        ? 'Friday'
                        : (day == 5
                            ? 'Saturday'
                            : (day == 6 ? 'Sunday' : 'null'))))));
  }
}

class BottomLeftWidget extends StatelessWidget {
  const BottomLeftWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.31,
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.grey.shade800,
        child: Obx(() {
          // var reverseTime = reverse;
          return Center(
            child: Text(_time(), style: TextStyle(fontSize: 12,color: Colors.white)),
          );
        }),
      ),
    );
  }

  String _time() {   
    try {
      var reverseT = Get.find<ControllerServerTime>().model.value.reverse;
      String mm = reverseT.minuteOfHour.toString();
      String ss = reverseT.secondOfMinute.toString();
      ss = reverseT.secondOfMinute < 10 ? ss = '0$ss' : ss;
      return '$mm:$ss';
    } catch (e) {
      return '';
    }
  }
}
