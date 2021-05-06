import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:native_platform_features/view/map_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var radius = 80;
  PickedFile _imageFile;
  final ImagePicker picker = ImagePicker();

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('Please selected image');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          imageProfile(),
          SizedBox(
            height: 90,
          ),
          Text('You find your current location '),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
              child: Text('Click me!'))
        ],
      ),

//genarilly image get in gallery
//
//
//
      //Center(
      //     child: CircleAvatar(
      //       radius: 100,

      //       child: CircleAvatar(
      //         radius: 95,
      //         backgroundImage: _image == null
      //             ? AssetImage('')
      //             : Image.file(
      //                 _image,
      //                 fit: BoxFit.cover,
      //               ).image,
      //       ),
      //     ),
      //  ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 100,
            backgroundImage: _imageFile == null
                ? AssetImage('')
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomsheet()));
              },
              child: Icon(
                Icons.camera_alt,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(
              'Choose Profile photo',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    onPressed: () {
                      takePhoto(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera),
                    label: Text('Camera')),
                SizedBox(
                  width: 50,
                ),
                TextButton.icon(
                    onPressed: () {
                      takePhoto(ImageSource.gallery);
                    },
                    icon: Icon(Icons.image),
                    label: Text('Gallery'))
              ],
            )
          ],
        ));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
