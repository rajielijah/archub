import 'package:archub/provider/auth.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool furnish = false;
  GlobalKey<FormState> _loginFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool rememberMe = true;
  String errMsg = "";
  String _userEmail = "";
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
            .signIn(_userEmail, _userPassword);
        // await Provider.of<Auth>(context, listen: false).getUserDetail();
        setState(() {
          errMsg = "";
        });
        Navigator.of(context)
            .pushNamedAndRemoveUntil(KDashboard, (route) => false);
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
            _isLoading = false;
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
                  height: MediaQuery.of(context).size.height * 0.2,
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
                      child: Text(
                        'Login',
                        style:
                            TextStyle(color: Color(0xff8C191C), fontSize: 24),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
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
                    child: Column(children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
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
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffC3BBBB),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "required";
                                } else if (!value.contains("@") ||
                                    !value.contains(".")) {
                                  return "Enter a valid email address";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                _userEmail = value;
                              },
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal),
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffC3BBBB),
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: IconButton(
                                  icon: _hidePassword
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: Color(0xff24414D),
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: Color(0xff24414D),
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      _hidePassword = !_hidePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _userPassword = value;
                              },
                              obscureText: _hidePassword,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 55,
                        width: double.infinity,
                        child: RoundedRaisedButton(
                          title: "Login",
                          isLoading: _isLoading,
                          titleColor: Colors.white,
                          buttonColor: Color(0xff8C191C),
                          onPress: () {
                            _submitLogin();
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(KForgetpassScreen);
                            },
                            child: Text(
                              'Forget password?',
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20)
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
