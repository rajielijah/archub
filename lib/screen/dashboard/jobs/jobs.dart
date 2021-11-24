import 'package:archub/screen/dashboard/jobs/widget/appy_widget.dart';
import 'package:archub/screen/dashboard/jobs/widget/employer_widget.dart';
import 'package:archub/utils/share/app_drawer.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class CloudScreen extends StatefulWidget {
  @override
  _CloudScreenState createState() => _CloudScreenState();
}

class _CloudScreenState extends State<CloudScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TabController _controller;

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  // PageController _uploadPageController = PageController(initialPage: 0);

  GlobalKey<FormState> _page1FormKey = GlobalKey();
  GlobalKey<FormState> _page2FormKey = GlobalKey();
  GlobalKey<FormState> _page3FormKey = GlobalKey();
  GlobalKey<FormState> _page4FormKey = GlobalKey();
  // PropertyModel property = PropertyModel();
  String _selectedFeatureType = "";
  String _selectedPropertyType = "";
  String _selectedPropertyCondition = "";
  List<Widget> pages;
  int pageIndex = 0;
  bool _isLoading = false;
  // File _image, _image2, _image3, _image4, _image5;
  String _imageExtension,
      _image2Extension,
      _image3Extension,
      _image4Extension,
      _image5Extension;
  var base64Image, base64Image2, base64Image3, base64Image4, base64Image5;

  TextEditingController unitController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  // }

  List<int> previousSelect = [];

  List<String> choise = [];

  var _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      // await Provider.of<CountryValue>(context, listen: false).getCountryList();
      setState(() {
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  _showShackBar(errorMessage) {
    final snackBar = new SnackBar(
      content: new Text(
        errorMessage,
        textAlign: TextAlign.center,
      ),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.blueGrey,
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  void validatePage(int index) {
    if (index == 0) {
      if (!_page1FormKey.currentState.validate()) {
        _showShackBar("Fill the required fields");
        throw "error";
      }
      if (_selectedFeatureType.isEmpty) {
        _showShackBar("Select Feature Type");
        throw "error";
      }
      if (_selectedPropertyType.isEmpty) {
        _showShackBar("Select Property Type");
        throw "error";
      }
      // if (property.type != "LAND") {
      //   if (_selectedPropertyCondition.isEmpty) {
      //     _showShackBar("Select Condition");
      //     throw "error";
      //   }
      // }

      _page1FormKey.currentState.save();
    }
    if (pageIndex == 1) {
      if (!_page2FormKey.currentState.validate()) {
        _showShackBar("Fill the required fields");
        throw "error";
      }
      _page2FormKey.currentState.save();
    }
    if (pageIndex == 2) {
      if (!_page3FormKey.currentState.validate()) {
        _showShackBar("Fill the required fields");
        throw "error";
      }
      // if (_mystate == null) {
      //   _showShackBar("Select State");
      //   throw "error";
      // }
      // if (_mylga == null) {
      //   _showShackBar("Select LGA");
      //   throw "error";
      // }
      _page3FormKey.currentState.save();
    }

    @override
    void initState() {
      _controller = new TabController(length: 2, vsync: this);

      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffE5E5E5),
        leading: GestureDetector(
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: Center(
            child: Image.asset(
          'assets/icons/lg.png',
          height: 40,
        )),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(KNotificationsScreen);
              },
              child: Icon(
                Icons.notifications,
                color: Colors.black,
                size: 30,
              ),
            ),
          ))
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(),
          child: AppDrawer(),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            DefaultTabController(
                length: 2,
                child: TabBar(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _controller,
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: "DosisBold",
                      fontWeight: FontWeight.w800,
                    ),
                    indicatorColor: Color(0xff28384F),
                    unselectedLabelColor: Color(0xffC4C4C4),
                    labelPadding: EdgeInsets.symmetric(horizontal: 20),
                    isScrollable: false,
                    tabs: [
                      Tab(
                        child: Row(
                          children: [
                            Text(
                              'Employer',
                              style: TextStyle(
                                  color: Color(0xff28384F), fontSize: 13),
                            ),
                            Expanded(child: Text(''))
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: [
                            Expanded(child: Text('')),
                            Text(
                              'Jobs',
                              style: TextStyle(
                                  color: Color(0xff28384F), fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ])),
            Expanded(
                child: Container(
              color: Color(0xffE5E5E5),
              child: TabBarView(
                controller: _controller,
                children: [
                  EmployerWidget(scaffoldkey: _scaffoldKey),
                  ApplyWidget()
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
