import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../locator.dart';
import 'constants_gathering.dart';
import 'gathering_page.dart';

class SettingsPageOfGathering extends StatefulWidget {
  @override
  _SettingsPageOfGatheringState createState() =>
      _SettingsPageOfGatheringState();
}

// Girilen Tüm değerler box.read('gatheringStepperValues') ile alınabilir.
class _SettingsPageOfGatheringState extends State<SettingsPageOfGathering> {
  int _activeStep = 0;
  List<Map<String, double>> listOfConstants = [
    ConstantOfGathering.expeditionForceMap, //Index:0
    ConstantOfGathering.armExpertIMap, //Index:1
    ConstantOfGathering.incentiveGatheringMap, //Index:2
    ConstantOfGathering.armExpertIIMap, //Index:3
    ConstantOfGathering.equipment, //Index:4
    ConstantOfGathering.equipment //Index:4
  ];
  List<String> stepperTitles = [
    /* 'Expedition Force',
    'Arm Expert - I',
    'Incentive Gathering',
    'Arm Expert - II',
    'Equipments - I',
    'Equipments - II '*/
    'Keşif Ekibi',
    'Askeri Uzman - I',
    'Ödüllendirme-Topla',
    'Askeri Uzman - II',
    'Kolye',
    'Aksesuar',
  ];
  List<String> stepperSubtitle = [
    'Keşif Ekibi Araştırması\'nı Giriniz',
    'Askeri Uzman - I Araştırması\'nı Giriniz',
    'Ödüllendirme-Topla Araştırması\'nı Giriniz',
    'Askeri Uzman - II Araştırması\'nı Giriniz',
    'Kolye',
    'Fener'
  ];
  List<double> values = [
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  List<String> infoImages = [
    'assets/images/kesifekibi.png',
    'assets/images/askeriuzman.png',
    'assets/images/topla.png',
    'assets/images/askeriuzman.png',
    'assets/images/kolye.png',
    'assets/images/fener.png',
  ];
  GetStorage box;
  bool isSettingsDone;

  @override
  void initState() {
    super.initState();
    box = getIt<GetStorage>();

    if (box.read('gatheringStepperTitles') != null) {
      stepperTitles = List<String>.from(box.read('gatheringStepperTitles'));
    }
    if (box.read('gatheringStepperValues') != null) {
      values = List<double>.from(box.read('gatheringStepperValues'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.grey.shade900,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 6,
            child: Column(
              children: [
                Stepper(
                    currentStep: _activeStep,
                    onStepTapped: (index) {
                      setState(() {
                        _activeStep = index;
                      });
                    },
                    onStepContinue: () {
                      int val = _activeStep; //_activeStep=index

                      if (_activeStep < listOfConstants.length - 1) {
                        setState(() {
                          _activeStep++;
                        });
                      }
                      if (val == 5) {
                        //SON ADIM
                        box.write('gatheringStepperValues', values);

                        getIt<GetStorage>().read('isSettingsDone') == null
                            ? Get.to(MainGatheringPage())
                            : Navigator.of(context).pop();
                        box
                            .write('isSettingsDone', true)
                            .then((value) => print('SAVED'));
                      }
                    },
                    onStepCancel: () {
                      if (_activeStep > 0) {
                        setState(() {
                          _activeStep--;
                        });
                      }
                    },
                    steps: List.generate(6, (index) => buildStep(index))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Not : Girilen ekipmanlar Tüm legionlar için aynı kabul edilerek hesap yapılacaktır.',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Step buildStep(int index) {
    return Step(
        state: StepState.indexed,
        isActive: true,
        title: Text('${stepperTitles[index]}'),
        subtitle: Text('${stepperSubtitle[index]}'),
        content: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                buildDropdownButton(index: index),
                IconButton(
                  icon: Icon(
                    Icons.info_outline,
                    size: 18,
                  ),
                  onPressed: () {
                    Get.defaultDialog(backgroundColor: Color.fromRGBO(21, 21, 21, 1),
                        title: 'info',titleStyle: TextStyle(color: Colors.white),
                        content: Container(                          
                          height: 150,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(infoImages[index]))),
                        ));
                  },
                )
              ],
            )));
  }

  DropdownButton buildDropdownButton({@required int index}) {
    return DropdownButton(
        hint: Text(stepperTitles[index]),
        items: buildDropdownMenuItem(index),
        onChanged: (value) {
          values[index] = value;
          setState(() {
            stepperTitles[index] =
                listOfConstants[index].keys.firstWhere((element) {
              return listOfConstants[index][element] == value;
            }, orElse: () => null);
            box.write('gatheringStepperTitles', stepperTitles);
            box.write('gatheringStepperValues', values);
          });
        });
  }

  List<DropdownMenuItem> buildDropdownMenuItem(int index) {
    List<DropdownMenuItem> liste = List();
    listOfConstants[index].forEach((key, value) {
      liste.add(DropdownMenuItem(
        child: Text(key),
        value: value,
      ));
    });
    return liste;
  }
}
