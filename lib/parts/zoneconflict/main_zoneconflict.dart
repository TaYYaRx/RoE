import 'package:son_roe/parts/zoneconflict/utility/services_zoneconflict.dart';



// ignore: must_be_immutable
class ZoneConflictMainPage extends StatelessWidget {
  ControllerZoneConflict _controller = Get.find<ControllerZoneConflict>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            AppBarZoneConflict(controller: _controller),
            BodyZoneConflict(controller: _controller)
          ],
        ),
      ),
    );
  }
}
