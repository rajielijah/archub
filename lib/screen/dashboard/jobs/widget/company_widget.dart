import 'package:archub/utils/share/distributor_textformfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CompanyWidget extends StatelessWidget {
  const CompanyWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: 25),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(children: [
              DistributorTextFormField(
                labelText: 'Company Name',
              ),
              DottedBorder(
                borderType: BorderType.RRect,
                dashPattern: [6, 6],
                color: Color(0xff28384F),
                radius: Radius.circular(30),
                strokeWidth: 1,
                child: Container(
                  height: 60,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                height: 10
              ),
              DistributorTextFormField(
                labelText: 'Staff capacity',
              ),
              DistributorTextFormField(
                labelText: 'Contact email',
              ),
              DistributorTextFormField(
                labelText: 'Enquiry phone number',
              ),
              DistributorTextFormField(
                labelText: 'Country',
              ),
              DistributorTextFormField(
                labelText: 'City',
              ),
              SizedBox(height: 25),
            ]),
          ),
        ),
        
      ]),
    );
  }
}
