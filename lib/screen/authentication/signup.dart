import 'package:archub/model/user.dart';
import 'package:archub/provider/auth.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class SignUpScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _regFormKey = GlobalKey();
  GlobalKey<FormState> _tokeFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true, _hidePassword1 = true;
  bool _isLoading = false;
  String token = "";
  bool _termsAndCondition = false;
  User user = User();

  Future<void> signup(BuildContext context) async {
    if (!_regFormKey.currentState.validate()) {
      return;
    }
    if (!_tokeFormKey.currentState.validate()) {
      return;
    }
    if (_termsAndCondition == false) {
      _showShackBar("Please agree to our Terms and Conditions to continue");
      // setState(() {
      //   _errMsg = "Agree to Terms and Conditions";
      // });
      return;
    }
    _regFormKey.currentState.save();
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
      try {
        await Provider.of<Auth>(context, listen: false).signUp(user, token);
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacementNamed(kLoginScreen);
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

  Future<void> getToken(BuildContext context) async {
    if (!_regFormKey.currentState.validate()) {
      return;
    }
    if (_termsAndCondition == false) {
      _showShackBar("Please agree to our Terms and Conditions to continue");
      // setState(() {
      //   _errMsg = "Agree to Terms and Conditions";
      // });
      return;
    }
    _regFormKey.currentState.save();

    setState(() {
      _isLoading = true;
    });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
        _isLoading = true;
        // errMsg = "";
        // KVerification
      });
      try {
        await Provider.of<Auth>(context, listen: false).getOtp(user);
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushNamed(KVerification, arguments: user);
      } catch (error) {
        _showShackBar(error.toString());
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
                    'assets/images/log2.png',
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
                              TextStyle(color: Color(0xffC4C4C4), fontSize: 24),
                        ),
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
                              TextStyle(color: Color(0xff8C191C), fontSize: 24),
                        ),
                      )),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  height: height,
                  width: width,
                  child: Theme(
                    data: ThemeData(primaryColor: Colors.black),
                    child: Column(children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _regFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusColor: Colors.black,
                                  hintText: "Full Name",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffC3BBBB),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  user.fullName = value;
                                },
                              ),
                              Container(height: 1, color: Colors.black),
                              SizedBox(height: 10),
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Your Email",
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
                                  user.email = value;
                                },
                              ),
                              Container(height: 1, color: Colors.black),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordController,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
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
                                  user.password = value;
                                },
                                obscureText: _hidePassword,
                              ),
                              Container(height: 1, color: Colors.black),
                              SizedBox(height: 10),
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffC3BBBB),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: _hidePassword1
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
                                        _hidePassword1 = !_hidePassword1;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: _hidePassword1,
                                validator: (value) {
                                  if (value != _passwordController.text) {
                                    return "Password does not match";
                                  }
                                  return null;
                                },
                              ),
                              Container(height: 1, color: Colors.black),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                child: CheckboxListTile(
                                  value: _termsAndCondition,
                                  onChanged: (value) {
                                    setState(() {
                                      _termsAndCondition = value;
                                    });
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                  contentPadding: EdgeInsets.all(0),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'I Agree to the ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black)),
                                        TextSpan(
                                          text: 'Terms of Service',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff8C191C)),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.85,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Center(
                                                                  child: Text(
                                                                      'Archub Terms and Conditions',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                      ))),
                                                              Divider(
                                                                height: 10,
                                                                thickness: 2,
                                                              ),
                                                              Expanded(
                                                                child: ListView(
                                                                  children: [
                                                                    // SizedBox(height: 5.0),
                                                                    Container(
                                                                      // padding:
                                                                      //     EdgeInsets.all(20),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Html(
                                                                            data:
                                                                                "This Privacy Policy explains how we collect, use, share, and protect your Personal Information. If you do not want us to handle your Personal Information in this manner, please do not use the Arch Hub Platform. Personal Information is information that relates to you as an individually identifiable person, such as your name, e-mail address, and mobile number.",
                                                                            //Optional parameters:
                                                                            onLinkTap:
                                                                                (url) {
                                                                              // open url in a webview
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Html(
                                                                            data:
                                                                                "This Privacy Policy applies only to (a) information that we collect on the websites Arch Hub and other sites (collectively, the \"Site\") and (b) through the Handy mobile applications, including the mobile application for service requesters and the mobile application for service professionals (the \"App\") (collectively the \"Handy Platform\").I. INFORMATION WE COLLECT",
                                                                            //Optional parameters:
                                                                            onLinkTap:
                                                                                (url) {
                                                                              // open url in a webview
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Html(
                                                                            data:
                                                                                "a) PERSONAL INFORMATION YOU GIVE US",
                                                                            //Optional parameters:
                                                                            onLinkTap:
                                                                                (url) {
                                                                              // open url in a webview
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Html(
                                                                            data:
                                                                                "We collect information that you voluntarily share with us through the Arch Hub Platform and website interface. If you are using our Platform to request professional services, or contact arch-hub or its third-party service providers, you may give us: \nContact information, such as your name, physical address, telephone number, and email address Information about your home or offices, such as the number of bedrooms, the types of appliances, zip code or postal code where your home is located and your instructions for servicing your home or offices Billing information, such as credit or debit card number, expiration date & security code and/or information regarding your PayPal, Google Wallet, Crypto-Currency or other digital payment accounts and the arch hub Platform itself Ratings and reviews of the service professionals you engage through the arc hub Platform If you participate on the arc hub Platform as a service professional, or contact arc hub or its third-party service providers, you may give us: Contact information, such as your name, email address, mailing address, and phone number Log-in information, including your arch hub Platform username and password Application information; if you’re requesting permission to participate as a service professional through our Platform, data such as your experience, skills, eligibility to work, and availability will be required Photographs of yourself.", //Optional parameters:
                                                                            onLinkTap:
                                                                                (url) {
                                                                              // open url in a webview
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Html(
                                                                            data:
                                                                                "b) INFORMATION WE COLLECT THROUGH TECHNOLOGY",
                                                                            //Optional parameters:
                                                                            onLinkTap:
                                                                                (url) {
                                                                              // open url in a webview
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Html(
                                                                            data:
                                                                                "We collect information through technology to enhance our ability to serve you. When you access and use the Arch Hub Platform, or contact us or our third-party service providers, Arch Hub and, in some cases, our third-party service providers collect information about you or how you interact with our Platform. We describe below a few of the methods we use to collect information through technology.",
                                                                            //Optional parameters:
                                                                            onLinkTap:
                                                                                (url) {
                                                                              // open url in a webview
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Html(
                                                                            data:
                                                                                "c) INFORMATION COLLECTED BY MOBILE APPLICATIONS",
                                                                            //Optional parameters:
                                                                            onLinkTap:
                                                                                (url) {
                                                                              // open url in a webview
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Html(
                                                                            data:
                                                                                "We may also collect information about how you use the App, such as the amount of time you spend using the App, how many times you use a specific feature of the App over a given time period, how often you use the App, and actions you take in the App. In addition, we may gather information about the website from which you downloaded the App to help us determine what App download site is most effective (collectively \"App Usage Information\").",
                                                                            //Optional parameters:
                                                                            onLinkTap:
                                                                                (url) {
                                                                              // open url in a webview
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Html(
                                                                            data:
                                                                                "d) INFORMATION YOU PROVIDE ABOUT A THIRD PARTY",
                                                                            //Optional parameters:
                                                                            onLinkTap:
                                                                                (url) {
                                                                              // open url in a webview
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Html(
                                                                            data:
                                                                                "If you choose to use our referral service to tell a friend about the Arch Hub Platform, we may collect your friend's name and email address. We will automatically send your friend a one-time email inviting him or her to visit the Arch Hub Platform. We store this information only to send this one-time email and to track the success of our referral program. We do not use this information for any other marketing purpose unless we obtain consent from that person or we explicitly say otherwise. Please be aware that when you refer a friend, your e-mail address may be included in the message sent to your friend.",
                                                                            //Optional parameters:
                                                                            onLinkTap:
                                                                                (url) {
                                                                              // open url in a webview
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10.0),
                                                                  ],
                                                                ),
                                                              ),
                                                              Divider(
                                                                height: 10,
                                                                thickness: 2,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Card(
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3.2,
                                                                      child:
                                                                          RoundedRaisedButton(
                                                                        buttonColor:
                                                                            Colors.white,
                                                                        titleColor:
                                                                            Colors.black,
                                                                        title:
                                                                            "Decline",
                                                                        onPress:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            _termsAndCondition =
                                                                                false;
                                                                          });
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        3.2,
                                                                    child:
                                                                        RoundedRaisedButton(
                                                                      title:
                                                                          "Accept",
                                                                      onPress:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          _termsAndCondition =
                                                                              true;
                                                                        });
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 55,
              width: double.infinity,
              child: RoundedRaisedButton(
                title: "Sign up",
                isLoading: _isLoading,
                titleColor: Colors.white,
                buttonColor: Color(0xff8C191C),
                onPress: () {
                  getToken(context);
                  // signup(context);
                },
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
