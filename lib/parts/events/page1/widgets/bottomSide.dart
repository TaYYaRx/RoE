import '../../utility/services_event.dart';

class BottomSide extends StatefulWidget {
  @override
  _BottomSideState createState() => _BottomSideState();
}

class _BottomSideState extends State<BottomSide> {
  List<Widget> liste;
  TextStyle _styleWhite;
  final List<String> chestPng = [
    'assets/chestImage/eventicon.png',
    'assets/chestImage/bluechest.png',
    'assets/chestImage/purplechest.png',
    'assets/chestImage/goldchest.png'
  ];
  final List<String> chestTitle = ['Events', 'Blue Chest', 'Purple Chest', 'Gold Chest'];
  int _initIndex;
  ControllerServerTime controller;
  ControllerDropdownMenu controllerDD;

  @override
  Widget build(BuildContext context) {
    _buildTabItem();
    return Expanded(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: _buildBottomConvexBar(),
      body: liste.elementAt(_initIndex),
    ));
  }

  ConvexAppBar _buildBottomConvexBar() {
    return ConvexAppBar(
        initialActiveIndex: _initIndex,
        backgroundColor: Colors.grey.shade900,
        activeColor: Colors.grey.shade900,
        color: Colors.grey,
        onTap: (int index) {
          print(index);
          setState(() {
            _initIndex = index;
          });
        },
        style: TabStyle.custom,
        items: _buildTabItem());
  }

  @override
  void initState() {
    super.initState();
    controller = Get.find<ControllerServerTime>();
    controllerDD = Get.find<ControllerDropdownMenu>();
    _styleWhite = TextStyle(color: Colors.white);
    liste = [
      Container(child: _listViewBuildEvents() /*Text('data')*/),
      Container(child: _listViewBuildChestsBlue()),
      Container(child: _listViewBuildChestsPurple()),
      Container(child: _listViewBuildChestsGold())
    ];
    _initIndex = 0;
  }

//TODO event listi ayarla

  Obx _listViewBuildEvents() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: controller.currentEventContents.value.eventList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: index % 2 == 1 ? Colors.grey.shade800 : Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.currentEventContents.value.eventList[index],
                    style: _styleWhite,
                  ),
                ),
              );
            },
          ),
        ));
  }

  Obx _listViewBuildChestsBlue() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: controller.modelListOfChest.value
                .castleLv[controllerDD.castleLevelIndex.value].bluechesttitle.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: index % 2 == 1 ? Colors.grey.shade800 : Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller
                            .modelListOfChest
                            .value
                            .castleLv[controllerDD.castleLevelIndex.value]
                            .bluechesttitle[index],
                        style: _styleWhite,
                      ),
                      Text(
                        controller
                            .modelListOfChest
                            .value
                            .castleLv[controllerDD.castleLevelIndex.value]
                            .bluechestvalue[index],
                        style: _styleWhite,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Obx _listViewBuildChestsPurple() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: controller.modelListOfChest.value
                .castleLv[controllerDD.castleLevelIndex.value].purplechesttitle.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: index % 2 == 1 ? Colors.grey.shade800 : Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller
                            .modelListOfChest
                            .value
                            .castleLv[controllerDD.castleLevelIndex.value]
                            .purplechesttitle[index],
                        style: _styleWhite,
                      ),
                      Text(
                        controller
                            .modelListOfChest
                            .value
                            .castleLv[controllerDD.castleLevelIndex.value]
                            .purplechestvalue[index],
                        style: _styleWhite,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Obx _listViewBuildChestsGold() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: controller.modelListOfChest.value
                .castleLv[controllerDD.castleLevelIndex.value].goldchesttitle.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: index % 2 == 1 ? Colors.grey.shade800 : Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller
                            .modelListOfChest
                            .value
                            .castleLv[controllerDD.castleLevelIndex.value]
                            .goldchesttitle[index],
                        style: _styleWhite,
                      ),
                      Text(
                        controller
                            .modelListOfChest
                            .value
                            .castleLv[controllerDD.castleLevelIndex.value]
                            .goldchestvalue[index],
                        style: _styleWhite,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  List<TabItem> _buildTabItem() => List<TabItem>.generate(4, (index) {
        return TabItem(
            title: chestTitle[index],
            icon: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(chestPng[index]),
              )),
            ));
      });
}
