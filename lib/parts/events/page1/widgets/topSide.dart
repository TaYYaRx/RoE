import 'package:son_roe/parts/events/page1/controller/controllerNextEvent.dart';

import '../../utility/services_event.dart';

class TopSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.21,
      child: Column(
        children: [
          Row(
            children: [TopLeftWidget(), TopRightWidget()],
          ),
          Row(
            children: [BottomLeftWidget(), BottomRightWidget()],
          ),
        ],
      ),
    );
  }
}

//CURRENT EVENT
class TopRightWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 10, 8, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.58,
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.grey.shade800,
        child: Obx(() {
          var currentEvent = Get.find<ControllerServerTime>().currentEventTitle;
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$currentEvent',
                style: TextStyle(fontSize: 12, color: Colors.white)),
          ));
        }),
      ),
    );
  }
}

//GAME TIME
class TopLeftWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.31,
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.grey.shade800,
        child: Obx(() {
          String _serverTime =
              Get.find<ControllerServerTime>().modelTimes.value.serverTime.toString();
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(_serverTime, style: TextStyle(fontSize: 12, color: Colors.white))
            ],
          ));
        }),
      ),
    );
  }
}

//REMAIN TIME
class BottomLeftWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.31,
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.grey.shade800,
        child: Obx(() {
          var reverseT = Get.find<ControllerServerTime>().modelTimes.value.reverse;
          return Center(
            child:
                Text(reverseT ?? '', style: TextStyle(fontSize: 12, color: Colors.white)),
          );
        }),
      ),
    );
  }
}

//NEXT EVENT
class BottomRightWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 10, 8, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.58,
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.grey.shade800,
        child: Obx(() {
          var nextEventTitle = Get.find<ControllerNextEvent>();
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(nextEventTitle.titleOfNextEvent.value,
                style: TextStyle(fontSize: 12, color: Colors.white)),
          ));
        }),
      ),
    );
  }
}
