import 'package:son_roe/parts/t9calculator/utility/services_t9.dart';


// ignore: must_be_immutable
class T9ManuPage extends StatelessWidget {
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              var imageHeight = MediaQuery.of(context).size.height * 0.256;
              return [
// AppBar PART
                SliverAppBar(
                  expandedHeight: imageHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/dragon.jpg'))),
                    ),
                  ),
                )
              ];
            },
// Body PART
            body: Container(
              color: Colors.black87.withOpacity(0.9),
              child: ListView(
                children: [
// Footman Item Container
                  InkWell(
                    child: T9MenuPageItemWidget(
                      image: 'assets/images/f1.png',
                      controller: Get.find<ControllerT9Footman>(),
                      title: 'FOOTMAN',
                    ),
                    onTap: () async {
                      Get.to(T9ResearchPage(
                        type: 'FOOTMAN T9',
                        controller: Get.find<ControllerT9Footman>(),
                        appbarImage: 'assets/images/footman.jpg',
                      ));
                    },
                  ),
// Archer Item Container
                  InkWell(
                      child: T9MenuPageItemWidget(
                        image: 'assets/images/a11.png',
                        controller: Get.find<ControllerT9Archer>(),
                        title: 'ARCHER',
                      ),
                      onTap: () async {
                        Get.to(T9ResearchPage(
                          type: 'ARCHER T9',
                          controller: Get.find<ControllerT9Archer>(),
                          appbarImage: 'assets/images/archer.jpg',
                        ));
// Cavalry Item Container
                      }),
                  InkWell(
                    child: T9MenuPageItemWidget(
                      image: 'assets/images/c1.png',
                      controller: Get.find<ControllerT9Cavalry>(),
                      title: 'CAVALRY',
                    ),
                    onTap: () async {
                      Get.to(T9ResearchPage(
                        type: 'CAVALRY T9',
                        controller: Get.find<ControllerT9Cavalry>(),
                        appbarImage: 'assets/images/cavalry.jpg',
                      ));
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
