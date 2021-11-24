import 'package:archub/utils/share/distributor_textformfield.dart';
import 'package:archub/utils/share/rounded_raisedbutton.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { Prepaid, Postpaid, Option }
class JobApplicationWidget extends StatefulWidget {
  const JobApplicationWidget({Key key}) : super(key: key);

  @override
  _JobApplicationWidgetState createState() => _JobApplicationWidgetState();
}

class _JobApplicationWidgetState extends State<JobApplicationWidget> {
  SingingCharacter _character = SingingCharacter.Prepaid;

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
                labelText: 'Applications for this job would be sent to ',
              ),
              DistributorTextFormField(
                labelText: 'Additional instructions',
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
                          // setState(() {
                          //   _character = value;
                          //   purchaseOption = "PREPAID";
                          //   print(_character);
                          // });
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
                        // setState(() {
                        //   _character = value;
                        //   purchaseOption = "POSTPAID";
                        //   print(_character);
                        // });
                      },
                    ),
                    const Text('No'),
                  ]),
                  Row(children: [
                    Radio(
                      value: SingingCharacter.Postpaid,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        // setState(() {
                        //   _character = value;
                        //   purchaseOption = "POSTPAID";
                        //   print(_character);
                        // });
                      },
                    ),
                    const Text('Optional'),
                  ]),
                ],
              ),
              SizedBox(
                height: 70
              )
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Container(
            width: double.infinity,
            child: RoundedRaisedButton(
              title: 'Next',
              buttonColor: Color(0xff8C191C),
            ),
          ),
        )
      ]),
    );
  }
}
