import 'package:son_roe/parts/events/utility/services_event.dart';

import 'widgets/bottomSide.dart';
import 'widgets/middleSide.dart';
import 'widgets/topSide.dart';

class EventMainPage extends StatelessWidget {
  const EventMainPage(
      {Key key,
      @required Timer timer,
      @required ModelEvents eventModel,
      @required List contentList})
      : _timer = timer,
        _eventModel = eventModel,
        super(key: key);
  final _timer;
  final _eventModel;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('timer closed');
        _timer.cancel();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                var _controller = Get.find<ControllerServerTime>();
                Get.defaultDialog(
                    title: 'Info',
                    content: Obx(() {
                      return Text(
                        'Day : ${_controller.model.value.day}\nNext Hour : ${_controller.model.value.nextEventHr}',
                        style: TextStyle(fontSize: 14),
                      );
                    }));
              },
            )
          ],
          backgroundColor: Colors.grey.shade900,
          title: Text('Events'),
        ),
        body: Column(
          children: [
            TopSide(
              model: _eventModel,
            ),
            MiddleSide(controller: Get.find<ControllerDropdownMenu>()),
            BottomSide(),
          ],
        ),
      ),
    );
  }
}
