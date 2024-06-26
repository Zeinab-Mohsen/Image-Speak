import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../theme/theme_helper.dart';
import 'package:http/http.dart' as http;

import '../result_page/result_tab_container_screen.dart';

class ReviewImage extends StatefulWidget {
  ReviewImage(this.file, {super.key});

  var file;

  @override
  State<ReviewImage> createState() => _ReviewImageState();
}

class _ReviewImageState extends State<ReviewImage> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Review the Image",
              style: theme.textTheme.titleLarge,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 645,
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
           Container(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      isLoading = false;
                      onTapNo(context);
                    },
                    iconSize: 35.0,
                    icon: Icon(
                        Icons.close
                    ),
                  ),
                  SizedBox(width: 80,),
                  IconButton(
                    onPressed: () {
                      isLoading = true;
                      onTapYes(context);
                    },
                    iconSize: 35.0,
                    icon: Icon(
                        Icons.check
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onTapYes(BuildContext context) async{
    showDialog(
        context: context,
        builder: (context){
          return Center(child: CircularProgressIndicator(color: Colors.white,),);
        },

    );

    File photo = File(widget.file.path);

    var url = Uri.parse('https://z-xbczebnogq-no.a.run.app/predict');
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', photo!.path));

    var response = await request.send();
    var responseBody;
    print("///////////////////////////////");
    print(response);
    print("/////////////////////////////////");
    if (response.statusCode == 200) {
      // Successful upload
      responseBody = await response.stream.bytesToString();
      print(responseBody.runtimeType);
      print('Response: $responseBody');
    } else {
      // Failed upload
      print('Error: ${response.reasonPhrase}');
    }

    final jsonResponse = json.decode(responseBody);

    Navigator.of(context).pop();

    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>
            ResultTabContainerScreen(widget.file, jsonResponse['prediction'])));
  }

  onTapNo(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.cameraScreen);
  }
}
