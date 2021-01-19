import '../utility/services_event.dart';
import 'widgets/bottomSide.dart';
import 'widgets/middleSide.dart';
import 'widgets/topSide.dart';

class EventMainPage extends StatelessWidget {
  const EventMainPage({
    Key key,
    @required Timer timer,
  })  : _timer = timer,
        super(key: key);
  final _timer;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('timer closed');
        try {
          _timer.cancel();
        } catch (e) {
          print(e);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                var controller = Get.find<ControllerServerTime>();
                _getInfoDialog(controller);
              },
            )
          ],
          backgroundColor: Colors.grey.shade900,
          title: Text('Events'),
        ),
        body: Column(
          children: [
            TopSide(),
            MiddleSide(controller: Get.find<ControllerDropdownMenu>()),
            BottomSide(),
          ],
        ),
      ),
    );
  }

  _getInfoDialog(ControllerServerTime controller) => Get.defaultDialog(
      title: 'INFO',
      content: Obx(() {
        var day = controller.modelTimes.value.day;
        var hour = controller.modelTimes.value.hr;
        return Text(
          'Day : $day\nNext Hour : $hour',
          style: TextStyle(fontSize: 14),
        );
      }));
}
