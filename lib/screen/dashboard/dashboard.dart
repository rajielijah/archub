import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Dashboard extends StatefulWidget {
  int indx;

  Dashboard(this.indx);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  TabController tabController;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(initialIndex: widget.indx, length: 4, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        tabController.index = widget.indx;

        _page = widget.indx;
        _isInit = false;
      });
    }
  }

  Future<bool> _onBackPressed() {
    if (tabController.index != 0) {
      setState(() {
        tabController.index = 0;
      });
      Future.delayed(Duration(microseconds: 0)).then((value) {
        return true;
      });
    } else {
      return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Exit",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                "Are you sure you want to exit the App?",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                FlatButton(
                  child: Text("NO"),
                  onPressed: () {
                    return Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text("YES"),
                  onPressed: () {
                    return Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          ) ??
          false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          items: <Widget>[
            BottomItem(
                page: _page,
                index: 0,
                iconUrl: "assets/icons/home.png",
                text: 'Home'),
            BottomItem(
                page: _page,
                index: 1,
                iconUrl: "assets/icons/explore.png",
                text: 'Explore'),
            BottomItem(
                page: _page,
                index: 2,
                iconUrl: "assets/icons/post1.png",
                text: 'Post'),
            BottomItem(
                page: _page,
                index: 3,
                iconUrl: "assets/icons/uplo.png",
                text: 'Upload'),
          ],
          onTap: (index) {
            setState(() {
              tabController.index = index;
              _page = index;
            });
          },
          height: 65,
          buttonBackgroundColor: Color(0xff8C191C),
          backgroundColor: Colors.grey.withOpacity(0.2),
        ),
        body: TabBarView(
          controller: tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            // HomeScreen(),
            // ExploreScreen(),
            // PostScreen(),
            // CloudScreen()
          ],
        ),
      ),
    );
  }
}

class BottomItem extends StatelessWidget {
  BottomItem({Key key, int page, this.index, this.iconUrl, this.text})
      : _page = page,
        super(key: key);

  int index, _page;
  String iconUrl, text;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Image.asset(
          "$iconUrl",
          width: 25,
          height: 25,
          color: _page == index ? Colors.white : Color(0xffC7C7DD),
        ),
        _page == index ? Container() : Text(text)
      ],
    );
  }
}
