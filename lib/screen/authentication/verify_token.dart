import 'package:archub/model/user.dart';
import 'package:archub/provider/auth.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class VerificationScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  GlobalKey<FormState> _tokeFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool _isLoading = false;
  String token = "";

  Future<void> signup(BuildContext context) async {
    if (!_tokeFormKey.currentState.validate()) {
      return;
    }
    if (!_tokeFormKey.currentState.validate()) {
      return;
    }
    _tokeFormKey.currentState.save();

    // setState(() {
    //   _isLoading = true;
    // });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
        _isLoading = true;
        // errMsg = "";
      });
      final user = ModalRoute.of(context).settings.arguments as User;
      try {
        print(token);
        await Provider.of<Auth>(context, listen: false).signUp(user, token);
        setState(() {
          _isLoading = false;
        });
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) {
              return AlertDialog(
                title: Text(
                  "Success",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text(
                    "Your account has been successfully created. Kindly check your email to verify Account"),
                actions: [
                  FlatButton(
                    child: Text("Proceed to Login",
                        style: TextStyle(color: Colors.white)),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed(kLoginScreen);
                    },
                  ),
                ],
              );
            });
      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text(
                  "Error",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text("${error.toString()}"),
                actions: [
                  FlatButton(
                    child: Text("OK", style: TextStyle(color: Colors.white)),
                    color: Color(0xff24414D),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('Not connected');
      _showShackBar('Please check your Internet connection!!!');
      setState(() {
        // errMsg = "Invalid credential";
        _isLoading = false;
      });
    }
  }

  _showShackBar(errorMessage) {
    final snackBar = new SnackBar(
      content: Text(
        errorMessage.toString(),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red[400],
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/log1.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ))
              ],
            ),
            SizedBox(height: 60),
            Center(
              child: Text(
                'Enter OTP Code sent to your \n Email Address',
                style: TextStyle(color: Color(0xff8C191C), fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  // height: height,
                  // width: width,
                  child: Column(
                    children: [
                      Form(
                        key: _tokeFormKey,
                        child: Column(children: <Widget>[
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.08),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  decoration: InputDecoration(
                                    focusColor: Colors.black,
                                    hintText: "OTP Code",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffC3BBBB),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    token = value;
                                  },
                                ),
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 55,
                            width: double.infinity,
                            child: RoundedRaisedButton(
                              title: "Complete Registration",
                              isLoading: _isLoading,
                              titleColor: Colors.white,
                              buttonColor: Color(0xff8C191C),
                              onPress: () {
                                signup(context);
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
