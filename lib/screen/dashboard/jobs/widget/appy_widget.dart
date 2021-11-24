import 'package:archub/provider/job_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';

class ApplyWidget extends StatefulWidget {
  const ApplyWidget({Key key}) : super(key: key);

  @override
  _ApplyWidgetState createState() => _ApplyWidgetState();
}

class _ApplyWidgetState extends State<ApplyWidget> {
  bool _isLoading = true;

  @override
  void didChangeDependencies() async {
    if (_isLoading) {
      await Provider.of<JobProvider>(context, listen: false).getUsersJob();

      setState(() {
        _isLoading = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final jobsData = Provider.of<JobProvider>(context, listen: false).jobmodel;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          itemCount: jobsData.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(KJobWidget,
                                      arguments: jobsData[i]);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 80,
                                            width: 100,
                                            child: Image.network(
                                              jobsData[i].logo,
                                              fit: BoxFit.fill,
                                            )),
                                        SizedBox(width: 20),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(jobsData[i].companyName,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Color(0xff28384F))),
                                              Text(jobsData[i].jobTitle,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          Color(0xff28384F))),
                                              Text('N ' + jobsData[i].salary,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xff28384F)
                                                          .withOpacity(0.5))),
                                            ])
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(jobsData[i].city,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff28384F))),
                                        Text('',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff28384F))),
                                        Text('',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff28384F)
                                                    .withOpacity(0.5))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      SizedBox(height: 25),
                    ]),
                  ),
                ),
              ),
            ]),
          );
  }
}
