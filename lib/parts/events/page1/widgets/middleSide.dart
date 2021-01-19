import '../../utility/services_event.dart';


class MiddleSide extends StatelessWidget {
  const MiddleSide({Key key, @required this.controller}) : super(key: key);
  final ControllerDropdownMenu controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        child: Row(children: [
          Obx(() => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: EdgeInsets.all(10),
                  height: 80,
                  width: MediaQuery.of(context).size.width - 18,
                  color: Colors.grey.shade800,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Castle Level :',
                          style: TextStyle(color: Colors.white,fontSize: 12),
                        ),
                        DropdownButton(
                            hint: Text('${controller.castleLevelTitle}',
                                style: TextStyle(color: Colors.white,fontSize: 14)),
                            items: _getDropdownMenuItemsCastleLv(),
                            onChanged: (value) {
                              controller.updateCastleLevel(value);

                              //save castle level to stroge
                              getIt<GetStorage>().write('castleLevel', value);
                            }),
                        DropdownButton(
                            hint: Text('${controller.sundayEventTitle}',
                                style: TextStyle(color: Colors.white,fontSize: 14)),
                            items: _getDropdownMenuItemsSundayEvent(),
                            onChanged: (value) {
                              controller.updateEvent(value);
                              Get.find<ControllerServerTime>()
                                  .updateSundayViaDropdown(value);
                              
                              //save Sunday Event to stroge
                              getIt<GetStorage>().write('sundayEvent', value);
                            })
                      ]))))
        ]));
  }

  List<DropdownMenuItem> _getDropdownMenuItemsCastleLv() {
    List<DropdownMenuItem> liste = List();
    getIt<ConstantOfEvents>().castleLv.forEach((key, value) {
      liste.add(DropdownMenuItem(child: Text(key), value: value));
    });
    return liste;
  }

  List<DropdownMenuItem> _getDropdownMenuItemsSundayEvent() {
    List<DropdownMenuItem> liste = List();
    getIt<ConstantOfEvents>().eventTitles.forEach((key, value) {
      liste.add(DropdownMenuItem(child: Text(key), value: value));
    });
    return liste;
  }
}
