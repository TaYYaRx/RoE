
import 'package:son_roe/parts/t9calculator/utility/services_t9.dart';

class T9ResearchPage extends StatelessWidget {
  T9ResearchPage(
      {Key key,
      @required this.controller,
      @required this.type,
      @required this.appbarImage})
      : super(key: key);

  final controller;
  final type;
  final appbarImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
// AppBar PART
            AppBarResearchPage(
                type: type, mainImage: appbarImage, controller: controller),
// Body PART
            SliverList(
                delegate: SliverChildListDelegate([
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
// Research -1
                        ItemContainer(
                          //Cavalry Recruitment
                          researchTitle: _techTitles(controller.model.value)[0],
                          increase: () {
                            controller.arttir(0);
                          },
                          decrease: () {
                            controller.azalt(0);
                          },
                          researchID: 0,
                          controller: controller,
                        ),
// Research -2
                        ItemContainer(
                          researchTitle: _techTitles(controller.model.value)[1],
                          controller: controller,
                          increase: () {
                            controller.arttir(1);
                          },
                          decrease: () {
                            controller.azalt(1);
                          },
                          researchID: 1,
                        ),
                      ],
                    ),
                  ),
// Research -3
                  ItemContainer(
                    //WARPATH
                    researchTitle: _techTitles(controller.model.value)[2],
                    controller: controller,
                    increase: () {
                      controller.arttir(2);
                    },
                    decrease: () {
                      controller.azalt(2);
                    },
                    researchID: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
// Research -4
                        ItemContainer(
                          researchTitle: _techTitles(controller.model.value)[3],
                          increase: () {
                            controller.arttir(3);
                          },
                          decrease: () {
                            controller.azalt(3);
                          },
                          researchID: 3,
                          controller: controller,
                        ),
// Research -5
                        ItemContainer(
                          researchTitle: _techTitles(controller.model.value)[4],
                          increase: () {
                            controller.arttir(4);
                          },
                          decrease: () {
                            controller.azalt(4);
                          },
                          researchID: 4,
                          controller: controller,
                        ),
                      ],
                    ),
                  ),
// Research -6
                  ItemContainer(
                    researchTitle: _techTitles(controller.model.value)[5],
                    increase: () {
                      controller.arttir(5);
                    },
                    decrease: () {
                      controller.azalt(5);
                    },
                    researchID: 5,
                    controller: controller,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
// Save Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          _saveLevels();
                          Get.snackbar('Save', 'Save Complete ✔');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.save_alt),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Save'),
                            )
                          ],
                        )),
                  ),
// Reset Button
                  RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        _resetLevels();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.settings_backup_restore),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Reset'),
                          )
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ]))
          ],
        ),
      ),
    );
  }

  List<String> _techTitles(T9Model model) {
    switch (model.type) {
      case 'Footman':
        return ConstantsT9.footmanResearchTitles;
        break;
      case 'Archer':
        return ConstantsT9.archerResearchTitles;
        break;
      case 'Cavalry':
        return ConstantsT9.cavalryResearchTitles;
        break;
      default:
        return ['null'];
    }
  }

  _saveLevels() {
    GetStorage box = GetStorage();

    switch (controller.model.value.type) {
      case 'Footman':
        box.write('Footman', _saveValueToLocal());
        break;
      case 'Archer':
        box.write('Archer', _saveValueToLocal());
        break;
      case 'Cavalry':
        box.write('Cavalry', _saveValueToLocal());

        break;
      default:
    }
  }

  List<dynamic> _saveValueToLocal() {
    return [
      controller.model.value.levels,
      controller.model.value.medals,
      controller.model.value.t9Left,
      controller.model.value.totalLeft,
      controller.model.value.percentage
    ];
  }

  _resetLevels() {
    Get.defaultDialog(
        title: 'Reset',
        content: Text('Are you sure ?'),
        actions: [
          FlatButton(
              onPressed: () {
                Get.back();
              },
              child: Text('No')),
          RaisedButton(
            onPressed: () {
              switch (controller.model.value.type) {
                case 'Archer':
                  controller.reset();
                  break;
                case 'Footman':
                  controller.reset();
                  break;
                case 'Cavalry':
                  controller.reset();
                  break;
                default:
              }
              Get.back();
            },
            child: Text('Yes'),
          ),
        ]);
  }
}
