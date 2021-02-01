import 'package:son_roe/parts/eventSchedule/mainEventSchedule.dart';

import 'locator.dart';
import 'parts/eden/controller_eden.dart';
import 'parts/events/page1/controller/controllerdropdownmenus.dart';
import 'parts/events/page1/controller/controllertime.dart';
import 'parts/t9calculator/utility/services_t9.dart';
import 'parts/zoneconflict/controller/controller_zoneconflict.dart';
import 'parts/zoneconflict/utility/model_zoneconflict.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); // Initialize SingletonTypeOfInstance
  await GetStorage.init(); // Initialize GetStorage
  initFunctions();

  runApp(MyApp());
}

void initFunctions() {
  _initControllers();
  _initValues();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     // home: MenuPage(),
       home: MainEventSchedule()
    );
  }
}

/// stat the contollers
void _initControllers() {
  Get.put(ControllerT9Cavalry());
  Get.put(ControllerT9Archer());
  Get.put(ControllerT9Footman());
  Get.put(ControllerZoneConflict());
  Get.put(ControllerServerTime());
  Get.put(ControllerEDEN());
}

void _initValues() async {
  var box = getIt<GetStorage>();

  // Dispatching values of Cavalry
  if (box.read('Cavalry') != null) {
    T9Model model = Get.find<ControllerT9Cavalry>().model.value;

    model.levels = List<int>.from(box.read('Cavalry')[0]);
    model.medals = List<int>.from(box.read('Cavalry')[1]);
    model.t9Left = box.read('Cavalry')[2];
    model.totalLeft = box.read('Cavalry')[3];
    model.percentage = box.read('Cavalry')[4];
  }
  // Dispatching values of Archer
  if (box.read('Archer') != null) {
    T9Model model = Get.find<ControllerT9Archer>().model.value;

    model.levels = List<int>.from(box.read('Archer')[0]);
    model.medals = List<int>.from(box.read('Archer')[1]);
    model.t9Left = box.read('Archer')[2];
    model.totalLeft = box.read('Archer')[3];
    model.percentage = box.read('Archer')[4];
  }
  // Dispatching values of Footman
  if (box.read('Footman') != null) {
    T9Model model = Get.find<ControllerT9Footman>().model.value;

    model.levels = List<int>.from(box.read('Footman')[0]);
    model.medals = List<int>.from(box.read('Footman')[1]);
    model.t9Left = box.read('Footman')[2];
    model.totalLeft = box.read('Footman')[3];
    model.percentage = box.read('Footman')[4];
  }
  // Dispatching values of Zone Conflict
  if (box.read('Zone Conflict') != null) {
    ZoneConflictModel model = Get.find<ControllerZoneConflict>().model.value;
    model.levels = List<int>.from(box.read('Zone Conflict')[0]);
    model.medals = List<int>.from(box.read('Zone Conflict')[1]);
    model.totalLeft = box.read('Zone Conflict')[2];
    model.percentage = box.read('Zone Conflict')[3];
  }

  var controllerDD = Get.find<ControllerDropdownMenu>();
  if (box.read('castleLevel') != null) {
    controllerDD.castleLevelIndex.value = box.read('castleLevel');
    controllerDD.castleLevelTitle.value =
        controllerDD.getCastleLevelTitle(box.read('castleLevel'));

    // print('${controller.castleLevelIndex.value}\n${controller.castleLevelTitle.value}');
  }

  if (box.read('sundayEvent') != null) {
    controllerDD.sundayEventIndex.value = box.read('sundayEvent');
    controllerDD.sundayEventTitle.value =
        controllerDD.getSundayEventTitle(box.read('sundayEvent'));
  }
}
