import 'dart:convert';
import 'dart:io';

import 'package:archub/model/job_model.dart';
import 'package:archub/provider/job_provider.dart';
import 'package:archub/utils/share/distributor_textformfield.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';

enum SingingCharacter { Prepaid, Postpaid, Option }

class EmployerWidget extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  EmployerWidget({this.scaffoldkey, Key key}) : super(key: key);

  @override
  _EmployerWidgetState createState() => _EmployerWidgetState();
}

class _EmployerWidgetState extends State<EmployerWidget>
    with TickerProviderStateMixin {
  SingingCharacter _character = SingingCharacter.Prepaid;
  bool isloading = false;

  TabController _controller2;
  List<Widget> pages;
  GlobalKey<FormState> _page1FormKey = GlobalKey();
  GlobalKey<FormState> _page2FormKey = GlobalKey();
  GlobalKey<FormState> _page3FormKey = GlobalKey();
  String jobsent, jobinstructions, submitResume;

  PageController _uploadPageController = PageController(initialPage: 0);
  JobModel jobModel = JobModel();
  int pageIndex = 0;
  @override
  void initState() {
    _controller2 = new TabController(length: 3, vsync: this);
    submitResume = "Yes";
    super.initState();
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

    widget.scaffoldkey.currentState.showSnackBar(snackBar);
  }

  File file;
  String status = '';
  String base64Image;
  File _image1;
  String imagevalue;

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      maxHeight: 400,
      maxWidth: 300,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      _image1 = image;
      print(_image1);
      List<int> imageBytes = _image1.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      imagevalue = base64Image;
      print(base64Image);
    });
  }

  void validatePage(int index) {
    if (index == 0) {
      if (!_page1FormKey.currentState.validate()) {
        _showShackBar("Fill the required fields");
        throw "error";
      }
      if (_image1 == null) {
        _showShackBar("Please upload job image");
        throw "error";
      }

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
      _page3FormKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page1 = SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 25),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Form(
                key: _page1FormKey,
                child: Column(children: [
                  DistributorTextFormField(
                    labelText: 'Company Name',
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Company Name Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      jobModel.companyName = value;
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage(ImgSource.Both);
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: [6, 6],
                      color: Color(0xff28384F),
                      radius: Radius.circular(30),
                      strokeWidth: 1,
                      child: Container(
                        height: _image1 != null ? 100 : 60,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _image1 != null
                                  ? Image.file(
                                      _image1,
                                      height: 60,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Upload image here or ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xffC3BBBB),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                        ),
                                        Text(
                                          'Browse',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ],
                                    ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Max size file: 1mb',
                                style: TextStyle(
                                    color: Color(0xffC3BBBB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // DistributorTextFormField(
                  //   labelText: 'Staff capacity',
                  //   validator: (value) {
                  //     if (value.isEmpty) {
                  //       return "Staff capacity Required";
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (value) {
                  //     jobModel.staffCapacity = value;
                  //   },
                  // ),
                  DistributorTextFormField(
                    labelText: 'Contact email',
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Contact email Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      jobModel.contactEmail = value;
                    },
                  ),
                  DistributorTextFormField(
                    labelText: 'Enquiry phone number',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Phone number Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      jobModel.inEquiryPhoneNumber = value;
                    },
                  ),
                  DistributorTextFormField(
                    labelText: 'City',
                    validator: (value) {
                      if (value.isEmpty) {
                        return "City Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      jobModel.city = value;
                    },
                  ),
                  DistributorTextFormField(
                    labelText: 'Country',
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Country Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      jobModel.country = value;
                    },
                  ),
                  SizedBox(height: 25),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );

    Widget page2 = SingleChildScrollView(
      child: SingleChildScrollView(
        child: Form(
          key: _page2FormKey,
          child: Column(children: [
            SizedBox(height: 25),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(children: [
                  DistributorTextFormField(
                    labelText: 'Job title',
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Country Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      jobModel.jobTitle = value;
                    },
                  ),
                  DistributorTextFormField(
                    labelText: 'Salary',
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Country Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      jobModel.salary = value;
                    },
                  ),
                  DistributorTextFormField(
                    labelText: 'Job description',
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Country Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      jobModel.jobDescription = value;
                    },
                  ),
                  SizedBox(height: 100),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );

    Widget page3 = SingleChildScrollView(
      child: SingleChildScrollView(
        child: Form(
          key: _page3FormKey,
          child: Column(children: [
            SizedBox(height: 25),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(children: [
                  DistributorTextFormField(
                    labelText: 'Applications for this job would be sent to ',
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Country Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      jobsent = value;
                    },
                  ),
                  DistributorTextFormField(
                    labelText: 'Additional instructions',
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Country Required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      jobinstructions = value;
                    },
                  ),
                  SizedBox(height: 25),
                  Text('Would you like applicants to submit resume?',
                      textAlign: TextAlign.left),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Radio(
                            value: SingingCharacter.Prepaid,
                            groupValue: _character,
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                _character = value;
                                submitResume = "Yes";
                                print(_character);
                              });
                            },
                          ),
                          const Text('Yes'),
                        ],
                      ),
                      Row(children: [
                        Radio(
                          value: SingingCharacter.Postpaid,
                          groupValue: _character,
                          onChanged: (SingingCharacter value) {
                            setState(() {
                              _character = value;
                              submitResume = "No";
                              print(_character);
                            });
                          },
                        ),
                        const Text('No'),
                      ]),
                      Row(children: [
                        Radio(
                          value: SingingCharacter.Option,
                          groupValue: _character,
                          onChanged: (SingingCharacter value) {
                            setState(() {
                              _character = value;
                              submitResume = "Option";
                              print(_character);
                            });
                          },
                        ),
                        const Text('Optional'),
                      ]),
                    ],
                  ),
                  SizedBox(height: 70)
                ]),
              ),
            ),
          ]),
        ),
      ),
    );

    pages = [
      page1,
      page2,
      page3,
    ];

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Text('Company Details'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        width: 120,
                        height: 3,
                        color: pageIndex == 0 ? Colors.grey : Colors.white)
                  ]),
                  Column(children: [
                    Text('Description'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        width: 120,
                        height: 3,
                        color: pageIndex == 1 ? Colors.grey : Colors.white)
                  ]),
                  Column(children: [
                    Text('Job Application'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        width: 120,
                        height: 3,
                        color: pageIndex == 2 ? Colors.grey : Colors.white)
                  ]),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _uploadPageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                children: [...pages],
              ),
            ),
            if (pageIndex > 0)
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                      width: double.infinity,
                      child: RoundedRaisedButton(
                        // isLoading: isloading,
                        title: 'Previous',
                        buttonColor: Color(0xff8C191C),
                        onPress: () {
                          try {
                            // validatePage(pageIndex);
                            _uploadPageController.animateToPage(
                              --pageIndex,
                              duration: Duration(microseconds: 200),
                              curve: Curves.easeIn,
                            );
                          } catch (error) {}
                        },
                      ))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Container(
                width: double.infinity,
                child: RoundedRaisedButton(
                  isLoading: isloading,
                  title: pageIndex == pages.length - 1 ? "Upload" : 'Next',
                  buttonColor: Color(0xff8C191C),
                  onPress: pageIndex == pages.length - 1
                      ? () async {
                          validatePage(pageIndex);
                          try {
                            setState(() {
                              isloading = true;
                            });
                            await Provider.of<JobProvider>(context,
                                    listen: false)
                                .creatJob(jobModel, jobsent, jobinstructions,
                                    submitResume, imagevalue);
                            setState(() {
                              isloading = false;
                            });
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: Text("Uploaded"),
                                    content: Text(
                                        "Your product has been successfully uploaded"),
                                    actions: [
                                      FlatButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  KDashboard, (route) => false);
                                        },
                                      )
                                    ],
                                  );
                                });
                          } catch (error) {
                            print(error);
                            setState(() {
                              isloading = false;
                            });
                          } finally {
                            setState(() {
                              isloading = false;
                            });
                          }
                        }
                      : () {
                          if (pageIndex < pages.length - 1) {
                            try {
                              validatePage(pageIndex);
                              _uploadPageController.animateToPage(
                                ++pageIndex,
                                duration: Duration(microseconds: 200),
                                curve: Curves.easeIn,
                              );
                            } catch (error) {}
                          }
                        },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
