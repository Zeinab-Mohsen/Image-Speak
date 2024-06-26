import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ImageSpeak/presentation/camera_screen/review_image.dart';
import '../../main.dart';
import '../../theme/theme_helper.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  int direction = 0;
  bool flash = false;
  var _selectedImage;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted){
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if(e is CameraException){
        switch (e.code){
          case 'CameraAccessDenied':
            print("access was denied");
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }
  var _image;
  final imagePicker = ImagePicker();
  Icon flashStatus = Icon(
    Icons.flash_off,
    color: Colors.white,
  );

  Future getImage() async{
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image!.path;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Pick an Image",
              style: theme.textTheme.titleLarge,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 680,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CameraPreview(_controller)
                    ),
                  ),
                  Positioned(
                    top: 625,
                    child: IconButton(
                      alignment: Alignment.bottomLeft,
                      onPressed: () => _pickImageFromGallery(),
                      iconSize: 35.0,
                      icon: Icon(
                        Icons.folder_copy_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 130,
                    top: 550,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1.0
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: ()  async {
                          if (!_controller.value.isInitialized) {
                            return null;
                          }
                          if (_controller.value.isTakingPicture) {
                            return null;
                          }
                          try {
                            // await _controller.setFlashMode(FlashMode.off);
                            var picture = await _controller
                                .takePicture();
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    ReviewImage(picture)));
                          } on CameraException catch (e) {
                            debugPrint(
                                "Error occured while taking picture : $e");
                            return null;
                          }
                        },
                        iconSize: 60.0,
                        icon: Icon(
                          Icons.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 220,
                    top: 565,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          direction = direction == 0 ? 1 : 0;
                          flipCamera(direction);
                        });
                      },
                      iconSize: 30.0,
                      icon: Icon(
                        Icons.flip_camera_android,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 288,),
                      Column(
                        children: [
                          SizedBox(height: 5,),
                          IconButton(
                            alignment: Alignment.bottomRight,
                            onPressed: () {
                              setState(() {
                                if (flash) {
                                  _controller.setFlashMode(FlashMode.off);
                                  flash = false;
                                  flashStatus = Icon(
                                    Icons.flash_off,
                                    color: Colors.white,
                                  );
                                } else {
                                  _controller.setFlashMode(FlashMode.torch);
                                  flash = true;
                                  flashStatus = Icon(
                                    Icons.flash_on,
                                    color: Colors.white,
                                  );
                                }
                              });
                            },
                            iconSize: 35.0,
                            icon: flashStatus,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(returnedImage == null) return;
    setState(() {
      _selectedImage = returnedImage;
    });
    Navigator.push(context, MaterialPageRoute(builder: (
        context) => ReviewImage(_selectedImage!)));
  }
  void flipCamera(int direction) async {
    cameras = await availableCameras();

    _controller = CameraController(
      cameras[direction],
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _controller.initialize().then((value) {
      if(!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }
}
