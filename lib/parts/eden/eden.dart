import 'package:flutter/material.dart';
import 'package:son_roe/parts/eden/controller_eden.dart';
import 'package:son_roe/parts/eden/databasehelper.dart';
import 'package:son_roe/parts/eden/model_eden.dart';
import 'package:son_roe/parts/zoneconflict/utility/services_zoneconflict.dart';

class MainEDEN extends StatefulWidget {
  @override
  _MainEDENState createState() => _MainEDENState();
}

class _MainEDENState extends State<MainEDEN>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<String> _tabTitles = ['I', 'II', 'III', 'IV', 'V'];

  //Yazıların rengi
  List<Color> color = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.green
  ];

  ControllerEDEN controllerEDEN;
  DatabaseHelper _helper;
  GetStorage box;

  @override
  void initState() {
    super.initState();
    box = getIt<GetStorage>();
    _helper = DatabaseHelper();
    controllerEDEN = Get.find<ControllerEDEN>();
    tabController = new TabController(length: _tabTitles.length, vsync: this);
    tabController.index = box.read('EdenTabIndex') ?? 0;

    controllerEDEN.updateList();
  }

  @override
  void dispose() {
    box.write('EdenTabIndex', tabController.index);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            forceElevated: innerBoxIsScrolled,
            floating: false,
            pinned: true,
            primary: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(
                  MediaQuery.of(context).size.height * 0.26), // Add this code
              child: ColoredTabBar(
                color: Colors.black.withOpacity(0.5),
                tabBar: TabBar(
                    controller: tabController,
                    tabs: _tabTitles.map((e) {
                      return Tab(
                        child: Text(e),
                      );
                    }).toList()),
              ),
            ),
            // expandedHeight: MediaQuery.of(context).size.height * 0.35,
            flexibleSpace: Stack(fit: StackFit.expand, children: [
              Container(
                child: Image.asset(
                  'assets/images/eden.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: MediaQuery.of(context).size.width * 0.01,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.98,
                      color: Colors.black.withOpacity(0.2),
                      child: Obx(() {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                                4,
                                (index) => Text(
                                    'Base - ${index + 1}\n${controllerEDEN.coalitionBaseCampLv[index]}',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center)));
                      }),
                    ),
                  ))
            ]),
            title: Text("Roc Building Queue"),
          )
        ];
      }, body: Obx(() {
        List<ModelRoc> listAll = [];
        (controllerEDEN.list[0] as List).forEach((element) {
          listAll.add(element);
        });
        List<List<ModelRoc>> speratedList = _seperateToList(listAll);

        return TabBarView(
            controller: tabController,
            children: List<Padding>.generate(
                    5,
                    (index) =>
                        buildListView(speratedList[index], color: color[index]))
                .toList(),
            physics: NeverScrollableScrollPhysics());
      })),
    );
  }

  buildListView(List<ModelRoc> speratedList, {Color color}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: speratedList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ObjectKey(speratedList[index]),
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Card(
                    elevation: 3,
                    color: Color(0xFF333333).withOpacity(0.3),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sıra No',
                                    style: TextStyle(shadows: [
                                      Shadow(
                                          blurRadius: 10,
                                          color: Colors.white30,
                                          offset: Offset(5, 5)),
                                    ], fontSize: 15, color: color),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${speratedList[index].id}',
                                      style: TextStyle(shadows: [
                                        Shadow(
                                            blurRadius: 10,
                                            color: Colors.white24,
                                            offset: Offset(5, 5)),
                                      ], fontSize: 18, color: color),
                                    ),
                                  )
                                ],
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                            ),
                            VerticalDivider(
                                color: Colors.white, endIndent: 10, indent: 10),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${speratedList[index].name}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: color,
                                        shadows: [
                                          Shadow(
                                              blurRadius: 10,
                                              color: Colors.white24,
                                              offset: Offset(5, 5)),
                                        ]),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Material Cost: ',
                                          style: TextStyle(
                                              shadows: [
                                                Shadow(
                                                    blurRadius: 10,
                                                    color: Colors.white24,
                                                    offset: Offset(5, 5))
                                              ],
                                              fontSize: 13,
                                              color: color.withOpacity(0.6))),
                                      Text('${speratedList[index].bcmaterials}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              shadows: [
                                                Shadow(
                                                    blurRadius: 10,
                                                    color: Colors.white24,
                                                    offset: Offset(5, 5)),
                                              ],
                                              color: color.withOpacity(0.6))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.096,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/cbc.png'))),
                                  ),
                                  Text(
                                    'Level\n${speratedList[index].levels}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.7)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ))),
              ),
              onDismissed: (direction) {
                ModelRoc newModel = ModelRoc(
                    id: speratedList[index].id,
                    sector: speratedList[index].sector,
                    name: speratedList[index].name,
                    bcmaterials: speratedList[index].bcmaterials,
                    levels: speratedList[index].levels,
                    isDone: (speratedList[index].isDone == 0) ? 1 : 0);

                _helper.updateModel(newModel);

                controllerEDEN.updateList();
              },
            );
          },
        ),
      ),
    );
  }

  List<List<ModelRoc>> _seperateToList(List<ModelRoc> list) {
    List<ModelRoc> list1 = List();
    List<ModelRoc> list2 = List();
    List<ModelRoc> list3 = List();
    List<ModelRoc> list4 = List();
    List<ModelRoc> list5 = List();
    list.forEach((model) {
      if (model.sector == 1 && model.isDone == 0) {
        list1.add(model);
      } else if (model.sector == 2 && model.isDone == 0) {
        list2.add(model);
      } else if (model.sector == 3 && model.isDone == 0) {
        list3.add(model);
      } else if (model.sector == 4 && model.isDone == 0) {
        list4.add(model);
      } else if (model.isDone == 1) {
        list5.add(model);
      }
    });

    return [list1, list2, list3, list4, list5];
  }
}

class ColoredTabBar extends Container implements PreferredSizeWidget {
  ColoredTabBar({this.color = Colors.transparent, @required this.tabBar});

  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        child: tabBar,
      );
}
