import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ImageSpeak/core/app_export.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


class ResultTabContainerScreen extends StatefulWidget {
  ResultTabContainerScreen(this.file, this.caption, {super.key});
  XFile file;
  String caption;

  @override
  ResultTabContainerScreenState createState() =>
      ResultTabContainerScreenState();
}

class ResultTabContainerScreenState extends State<ResultTabContainerScreen> with SingleTickerProviderStateMixin  {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _tabController.index = 0;
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      print("//////////////////////////////////////////////");
      print("Selected Tab: ${_tabController.index}");
      print("//////////////////////////////////////////////");
    }
  }

  String _translatedText = '';
  String language = '', sound = '';

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);
    String caption = widget.caption;

    void _translate(String caption, String language) async {
      try {
        final translated = await translateText(caption, language);
        setState(() {
          _translatedText = translated;
        });
      } catch (e) {
        setState(() {
          _translatedText = 'Error translating text.';
        });
      }
    }

    String translate() {
      switch (_tabController.index) {
        case 0:
          print("Arabic");
          _translate(caption, 'ar');
          setState(() {
            language = 'ar-XA';
            sound = 'ar-XA-Wavenet-D';
          });
          return _translatedText;
        case 1:
          print("Spanish");
          _translate(caption, 'es');
          setState(() {
            language = 'es-ES';
            sound = 'es-ES-Wavenet-C';
          });
          return _translatedText;
        case 2:
          print("Dutch");
          _translate(caption, 'de');
          setState(() {
            language = "de-DE";
            sound = 'de-DE-Studio-C';
          });
          return _translatedText;
        case 3:
          print("French");
          _translate(caption, 'fr');
          setState(() {
            language = "fr-FR";
            sound = 'fr-FR-Wavenet-E';
          });
          return _translatedText;
        case 4:
          print("Italian");
          _translate(caption, 'it');
          setState(() {
            language = "it-IT";
            sound = 'it-IT-Wavenet-A';
          });
          return _translatedText;
        case _:
          return _translatedText;
      }
    }

    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(height: 10.v),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 21.h),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.v),
                          child: GestureDetector(
                            onTap: () {
                              onTapBack(context);
                            },
                            child: Text(
                              "Back",
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 94.h),
                          child: Text(
                            "Result",
                            style: theme.textTheme.titleLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15.v),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 320.v,
                    width: 375.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.file(
                        picture,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.v),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10.h, 10.v, 10.h, 10.v),
                        padding: EdgeInsets.all(10),
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Caption",
                              style: CustomTextStyles.titleMediumBlack900.copyWith(
                                fontSize:25.0,
                                height: 1.38,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              caption,
                              textAlign: TextAlign.left,
                              style: CustomTextStyles.titleMediumBlack900.copyWith(
                                fontSize:15.0,
                                height: 1.38,
                              ),
                            ),
                          ],
                        )
                      ),
                      Positioned(
                          left: 305,
                          top: 115,
                          child:
                          IconButton(
                              onPressed: () => _speak(caption, 'en-US', "en-US-Journey-F"),
                              icon:
                              Icon(
                                  Icons.volume_up
                              ),
                          ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(10.h, 10.v, 10.h, 10.v),
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        child: Column(
                          children: [
                            SizedBox(height: 1.v),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: TabBar(
                                isScrollable: true,
                                controller: _tabController,
                                indicatorColor: Colors.transparent,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.black,
                                tabAlignment: TabAlignment.start,
                                indicatorSize : TabBarIndicatorSize.label,
                                labelPadding: EdgeInsets.symmetric(horizontal: 8.8),
                                tabs: [
                                  Tab(
                                    child: Text(
                                          'العربية',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Español',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Deutsch',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Française',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Italiano',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ],
                                indicator: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                onTap: (index){translate();},
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _translatedText,
                                  textAlign: TextAlign.left,
                                  style: CustomTextStyles.titleMediumBlack900.copyWith(
                                    fontSize:15.0,
                                    height: 1.38,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 305,
                        top: 125,
                        child:
                        IconButton(
                          onPressed: () => _speak(_translatedText, language, sound),
                          icon:
                          Icon(
                              Icons.volume_up
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<String> translateText(String caption, String language) async {
    String _apiKey = "AIzaSyDoSbyMqMwUaqSjtt8VhVKPwjnIUmYiMg0";

    final url = Uri.parse(
      'https://translation.googleapis.com/language/translate/v2?key=$_apiKey',
    );

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'q': caption,
        'source': 'en',
        'target': language,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final translatedText = responseBody['data']['translations'][0]['translatedText'];
      print(translatedText);
      return translatedText;
    } else {
      throw Exception('Failed to translate text');
    }
  }

  Future<void> _speak(String text, String language, String sound) async {
    String _apiKey = "AIzaSyDoSbyMqMwUaqSjtt8VhVKPwjnIUmYiMg0";

    final url = 'https://texttospeech.googleapis.com/v1/text:synthesize?key=$_apiKey';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "audioConfig": {
          "audioEncoding": "LINEAR16",
          "effectsProfileId": [
            "small-bluetooth-speaker-class-device"
          ],
          "pitch": 0,
          "speakingRate": 1
        },
        'input': {'text': text},
        'voice': {'languageCode': language, "name": sound},
        'audioConfig': {'audioEncoding': 'MP3'},
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final audioContent = responseJson['audioContent'];

      final player = AudioPlayer();
      await player.play(BytesSource(base64Decode(audioContent)));

      print('Audio content (base64): ${audioContent.length}');
    } else {
      print('Failed to get audio: ${response.statusCode}');
    }
  }

   onTapBack(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.cameraScreen);
  }

}
