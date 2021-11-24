import 'package:archub/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;
    return Container(
      color: Color(0xffF2F2F6),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff8C191C)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      color: Color(0xffE5E5E5),
                      height: 50,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(KProfileScreen);
                    },
                    leading: user.pictureUrl == null
                        ? ClipOval(
                            child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[100],
                                child: Icon(
                                  Icons.person_outline,
                                  size: 30,
                                )),
                          )
                        : user.pictureUrl == null
                            ? CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                radius: 40,
                                child: SvgPicture.network(
                                    user.pictureUrl
                                        .toString()
                                        .split("'")
                                        .join(""),
                                    fit: BoxFit.contain,
                                    height: 30,
                                    placeholderBuilder:
                                        (BuildContext context) => Container(
                                            padding: const EdgeInsets.all(2),
                                            child:
                                                const CircularProgressIndicator())),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                radius: 40,
                                backgroundImage: NetworkImage(
                                    "${user.pictureUrl != null ? user.pictureUrl : ''}"),
                              ),
                    title: Text(
                      user.fullName,
                      style: TextStyle(color: Color(0xff28384F)),
                    ),
                    subtitle: Text(
                      "You should never look down on anyone only God sits that high",
                      style: TextStyle(color: Color(0xff28384F), fontSize: 10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      color: Color(0xffE5E5E5),
                      height: 50,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(KNotificationScreeen);
                    },
                    leading: Image.asset(
                      'assets/icons/not.png',
                      height: 70,
                    ),
                    title: Text(
                      "Notification settings",
                      style: TextStyle(color: Color(0xff28384F)),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(KAccountSetting);
                    },
                    leading: Image.asset(
                      'assets/icons/setting.png',
                      height: 70,
                    ),
                    title: Text(
                      "Account settings",
                      style: TextStyle(color: Color(0xff28384F)),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(kAboutScreen);
                    },
                    leading: Image.asset(
                      'assets/icons/about.png',
                      height: 70,
                    ),
                    title: Text(
                      "About",
                      style: TextStyle(color: Color(0xff28384F)),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
