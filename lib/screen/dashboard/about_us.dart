import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffE5E5E5),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
            child: Image.asset(
          'assets/icons/lg.png',
          height: 40,
        )),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 30,
            ),
          ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          ListTile(
            leading: Image.asset(
              'assets/icons/about.png',
              height: 70,
            ),
            title: Text(
              "About us",
              style: TextStyle(color: Color(0xff28384F)),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text:
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Erat amet vitae eros, sed. Ut laoreet dictum mattis massa duis erat sed. Odio tellus fringilla id diam, aenean auctor orci nascetur. "),
                                  TextSpan(
                                      text:
                                          "Auctor nullam risus magna in. Morbi nunc, aliquam enim ultrices vel ac nec vitae sociis. Proin scelerisque "),
                                  TextSpan(
                                      text:
                                          " In nulla pellentesque integer rhoncus, senectus cras curabitur sed magna. Ipsum habitant feugiat interdum arcu. Mi et gravida fermentum justo, etiam at cras commodo varius. Natoque ornare duis sed lacinia maecenas non. Amet facilisi at egestas sed faucibus mattis scelerisque. Tellus amet at vel ac et, sed sagittis."),
                                  TextSpan(
                                      text:
                                          "Pharetra, ornare venenatis eget feugiat urna scelerisque urna. Aliquet amet, fermentum mi quis at lobortis et tellus. At sed odio lacinia sagittis quis varius.sed faucibus mattis scelerisque. Tellus amet at vel ac et, sed sagittis. Pharetra, ornare venenatis eget feugiat urna scelerisque urna. "),
                                  TextSpan(
                                      text:
                                          "Pharetra, ornare venenatis eget feugiat urna scelerisque urna. Aliquet amet, fermentum mi quis at lobortis et tellus. At sed odio lacinia sagittis quis varius.sed faucibus mattis scelerisque. Tellus amet at vel ac et, sed sagittis. Pharetra, ornare venenatis eget feugiat urna scelerisque urna. ")
                                ]))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
