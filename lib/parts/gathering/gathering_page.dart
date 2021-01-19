import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:numeral/numeral.dart';

import '../../locator.dart';
import 'constants_gathering.dart';
import 'gather_settings_page.dart';

class MainGatheringPage extends StatefulWidget {
  @override
  _MainGatheringPageState createState() => _MainGatheringPageState();
}

class _MainGatheringPageState extends State<MainGatheringPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  //Sabit değerlerin içinde barındıran liste
  List<Map<String, double>> listOfConstants = [
    ConstantOfGathering.boostMap, //0
    ConstantOfGathering.typeFactorMap, //1
  ];

  //COP boost görüntüsü
  String _boostTitle = 'Boost';

  //COP boost basıldıysa eklenecek olan çarpan değeri
  double _boostValue = 0;

  //Herbir Legion satırındaki input girdilerini tek tek kontrol eden controller lar
  List<TextEditingController> controllersList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  //Herbir Legion satırındaki DROPDOWN menu String ifadeleri
  List<String> _rssTitleList = [
    'Resource',
    'Resource',
    'Resource',
    'Resource',
    'Resource',
  ];
  String _rssTitle2 = 'Resource';
  double _rssValue2 = 0;
  var _controller2 = TextEditingController();
  String _totalRss2 = '0';

  //Herbir Legion'un seçtiği Kaynak tipi değerleri
  List<double> _rssValueList = [0, 0, 0, 0, 0];

  //Herbir Legion'un aktif mi olacakğını belirleyen değerler
  List<bool> checkBoxList = [
    true,
    true,
    true,
    true,
    false,
  ];

  //Herbir Legion satırındaki INPUT değerleri
  List<String> textValueList = ['0', '0', '0', '0', '0'];

  //Herbir Legion'un Kendine ait olan COP puanı
  List<double> resultList = [0, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    //Herbir legion satırında bulunan input değerleri default olarak 0 atanır
    controllersList.forEach((element) {
      element.text = '0';
    });
    _controller2.text = '0';
  }

  double widthTotal;
  double heightTotal;

  @override
  Widget build(BuildContext context) {
    widthTotal = MediaQuery.of(context).size.width;
    heightTotal = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Get.to(SettingsPageOfGathering());
              })
        ],
        title: Text('Gathering Calculator'),
        backgroundColor: Colors.grey.shade900,
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(child: Text('Gather - I')),
          Tab(child: Text('Gather - II'))
        ]),
      ),

//BODY Başlangıç yeri
      body: TabBarView(controller: _tabController, children: [
        Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: heightTotal * 0.01),

//->> ILK SAYFA
              Container(
                  width: double.infinity,
                  child: Stack(
                    children: [
//BOOST SEKMESI
                      Center(
                        child: DropdownButton(
                          hint: Text(_boostTitle),
                          items: buildDropdownMenuItem(0),
                          onChanged: (value) {
                            _boostValue = value;
                            print(_boostValue);
                            setState(() {
                              _boostTitle =
                                  listOfConstants[0].keys.firstWhere((element) {
                                return listOfConstants[0][element] == value;
                              }, orElse: () => null);
                            });
                          },
                        ),
                      ),

//INFO Butonu
                      Positioned(
                          right: 1,
                          child: IconButton(
                            color: Colors.grey.shade600,
                            icon: Icon(Icons.info),
                            onPressed: () {
                              List settingsValue = getIt<GetStorage>()
                                  .read('gatheringStepperValues');
                              List<String> stepperTitles = [
                                'Expedition Force',
                                'Arm Expert - I',
                                'Incentive Gathering',
                                'Arm Expert - II',
                                'Equipment - I',
                                'Equipment - II'
                              ];
                              Get.defaultDialog(
                                  title: 'info',
                                  content: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [Text('Base '), Text('1')],
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                stepperTitles.length,
                                                (index) => Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(stepperTitles[
                                                            index]),
                                                        Text(
                                                            settingsValue[index]
                                                                .toString())
                                                      ],
                                                    ))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Boost '),
                                            Text(_boostValue.toString())
                                          ],
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                          ))
                    ],
                  )),

//LEGION CONTAINER
              Container(
                height: heightTotal * 0.40,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return buildLegions(context, index);
                  },
                ),
              ),

//HESAPLAMA İŞLEMİ
              Center(
                  child: RaisedButton(
                      child: Text('Hesapla'),
                      onPressed: () {
                        List settingsValue =
                            getIt<GetStorage>().read('gatheringStepperValues');

                        List<double> girilen = textValueList.map((e) {
                          return double.parse(e);
                        }).toList();

                        //RSS MIKTARI * RSS TIPI * (BASE + BOOST + ARASTIRMA)
                        for (var i = 0; i < 5; i++) {
                          resultList[i] = (girilen[i] *
                                  (1 +
                                      settingsValue[0] +
                                      settingsValue[4] +
                                      settingsValue[5])) *
                              _rssValueList[i] *
                              (_boostValue +
                                  1 +
                                  settingsValue[1] +
                                  settingsValue[2] +
                                  settingsValue[3]);
                        }
                        setState(() {
                          _calculateTotal();
                        });
                      })),
              SizedBox(height: 10),

//RESULT EKRANI
              Container(
                padding: EdgeInsets.all(8),
                height: heightTotal * 0.15,
                width: MediaQuery.of(context).size.width * 0.6,
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children:
                          List.generate(5, (index) => buildResultScreen(index)),
                    ),
                    Text(
                      'TOPLAM : ${_calculateTotal()}',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),

//IKINCI SAYFA
        Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Hesaplanmak istenen COP puanı TEK çeşit Kaynağa göre hesaplanacaktır.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),

//2.BOOST DropDownMenu
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: DropdownButton(
                    hint: Text(_boostTitle),
                    items: buildDropdownMenuItem(0),
                    onChanged: (value) {
                      _boostValue = value;
                      print(_boostValue);
                      setState(() {
                        _boostTitle =
                            listOfConstants[0].keys.firstWhere((element) {
                          return listOfConstants[0][element] == value;
                        }, orElse: () => null);
                      });
                    },
                  ),
                ),
              ),

//2.RSS DropDownMenu
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: DropdownButton(
                    hint: Text(
                      _rssTitle2,
                      style: TextStyle(
                          color: _rssTitle2 == 'Resource'
                              ? Colors.red
                              : Colors.black54),
                    ),
                    items: buildDropdownMenuItem(1),
                    onChanged: (value) {
                      setState(() {
                        _rssValue2 = value;
                        _rssTitle2 =
                            listOfConstants[1].keys.firstWhere((element) {
                          return listOfConstants[1][element] == value;
                        }, orElse: () => null);
                      });
                    },
                  ),
                ),
              ),

//2.TextFormField
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: TextFormField(
                      style: TextStyle(fontSize: 14),
                      controller: _controller2,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.cancel,
                                size: 16,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller2.clear();
                                  _controller2.text = '0';
                                });
                              }),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Toplanması Gereken Kaynak Miktarı'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$_totalRss2  $_rssTitle2'),
              ),

              RaisedButton(
                color: Colors.blue,
                child: Text('Hesapla'),
                onPressed: () {
                  setState(() {
                    _totalRss2 = _calculateForRSS();
                  });
                },
              )
            ],
          ),
        )
      ]),
    );
  }

  String _calculateForRSS() {
// RSS/(1,2*3*6)
    List settingsValue = getIt<GetStorage>().read('gatheringStepperValues');
    double rss = 0;

    double girilenDeger =
        _controller2.text == '' ? 0 : double.parse(_controller2.text);

    rss = girilenDeger /
        (1 +
            settingsValue[1] +
            settingsValue[2] +
            settingsValue[3] +
            _boostValue);

    rss = rss / _rssValue2;

    rss = rss / (1 + settingsValue[0] + settingsValue[4] + settingsValue[5]);
    rss = (rss == double.infinity) ? 0 : rss;
    //return rss.toString();
    return Numeral(rss.truncate()).value();
  }

  String _calculateTotal() {
    double toplam = 0;
    resultList.forEach((element) {
      toplam += element;
    });

    return Numeral(toplam.truncate()).value();
  }

  Row buildResultScreen(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Legion ${index + 1} ',
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
        Text(
          '${Numeral((resultList[index] ?? 0).truncate()).value()}',
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }

  Container buildLegions(BuildContext context, int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            value: checkBoxList[index],
            onChanged: (value) {
              setState(() {
                checkBoxList[index] = value;
                if (checkBoxList[index] == false) {
                  controllersList[index].text = 0.toString();
                }
              });
            },
          ),
          Text('Legion ${index + 1}'),
          DropdownButton(
            hint: Text(
              _rssTitleList[index],
              style: TextStyle(
                  color: _rssTitleList[index] == 'Resource'
                      ? Colors.red
                      : Colors.black54),
            ),
            items: buildDropdownMenuItem(1),
            onChanged: (value) {
              setState(() {
                _rssValueList[index] = value;
                _rssTitleList[index] =
                    listOfConstants[1].keys.firstWhere((element) {
                  return listOfConstants[1][element] == value;
                }, orElse: () => null);
              });
            },
          ),
          Container(
            height: heightTotal * 0.075,
            width: widthTotal * 0.36,
            padding: EdgeInsets.all(8),
            child: TextFormField(
              style: TextStyle(fontSize: 14),
              enabled: checkBoxList[index],
              controller: controllersList[index],
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                print(controllersList[index].text);
              },
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          controllersList[index].clear();
                          textValueList[index] = '0';
                        });
                      }),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  textValueList[index] = value;
                });
              },
            ),
          )
        ],
      ),
    );
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
