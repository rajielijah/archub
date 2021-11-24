import 'package:archub/provider/auth.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class ResetPasswordScreens extends StatefulWidget {
  @override
  _ResetPasswordScreensState createState() => _ResetPasswordScreensState();
}

class _ResetPasswordScreensState extends State<ResetPasswordScreens> {
  bool furnish = false;
  GlobalKey<FormState> _loginFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool rememberMe = true;
  String errMsg = "";
  String _usertoken = "";
  String _newpassword = "";
  String _userPassword = "";
  bool _isLoading = false;
  bool _hidePassword = true;

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

  Future<void> _submitLogin() async {
    if (!_loginFormKey.currentState.validate()) {
      return;
    }
    _loginFormKey.currentState.save();
    // setState(() {
    //   _isLoading = true;
    //   errMsg = "";
    // });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
        _isLoading = true;
        errMsg = "";
      });
      try {
        await Provider.of<Auth>(context, listen: false)
            .resetPassworddata(_usertoken, _newpassword);
        Get.snackbar('Success!', 'Password Reset Successful',
            barBlur: 0,
            dismissDirection: SnackDismissDirection.VERTICAL,
            backgroundColor: Colors.green,
            overlayBlur: 0,
            animationDuration: Duration(milliseconds: 500),
            duration: Duration(seconds: 2));
        Future.delayed(Duration(seconds: 1)).then((value) =>
            Navigator.of(context)
                .pushNamedAndRemoveUntil(kLoginScreen, (route) => false));
        setState(() {
          errMsg = "";
        });
        // Navigator.of(context).pushNamed(KSplash2);
      } catch (error) {
        if (error.toString().isNotEmpty) {
          _showShackBar(error.toString());
          setState(() {
            errMsg = error.toString();
          });
        } else {
          _showShackBar('Invalid credential');
          setState(() {
            errMsg = "Invalid credential";
          });
        }
      } finally {
        setState(() {
          // errMsg = "";
          _isLoading = false;
        });
      }
    } else {
      print('Not connected');
      _showShackBar('Please check your Internet connection!!!');
      setState(() {
        errMsg = "Invalid credential";
        _isLoading = false;
      });
    }
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
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/log1.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Login',
                          style:
                              TextStyle(color: Color(0xff8C191C), fontSize: 24),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(KSignUpScreen);
                        },
                        child: Text(
                          'Sign Up',
                          style:
                              TextStyle(color: Color(0xffC4C4C4), fontSize: 24),
                        ),
                      )),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  // height: height,
                  // width: width,
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Recovery Token Sent',
                              style: TextStyle(
                                  color: Color(0xff8C191C), fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Please enter password recovery token sent to your email',
                              style: TextStyle(
                                  color: Color(0xffC4C4C4), fontSize: 16),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
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
                                    hintText: "Token",
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
                                    _usertoken = value;
                                  },
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  decoration: InputDecoration(
                                    focusColor: Colors.black,
                                    hintText: "New Password",
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
                                    _newpassword = value;
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
                              title: "Submit",
                              isLoading: _isLoading,
                              titleColor: Colors.white,
                              buttonColor: Color(0xff8C191C),
                              onPress: () {
                                _submitLogin();
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 20),
                          //   child: Align(
                          //     alignment: Alignment.topRight,
                          //     child: Text(
                          //       'Forget password?',
                          //       textAlign: TextAlign.end,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 20)
                        ]),
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
