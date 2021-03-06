
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hala_app_sample/common/app_constants_or_strings/strings_or_constants.dart';
import 'package:hala_app_sample/common/widgets/widgets.dart';
import 'package:hala_app_sample/localization/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ImageCompressionSample extends StatefulWidget {
  @override
  _ImageCompressionSampleState createState() => _ImageCompressionSampleState();
}

class _ImageCompressionSampleState extends State<ImageCompressionSample> {

  Future<File> profileImg;
  File _image;
  final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(image:
            new AssetImage(CommonImagePaths().backgroundImage), fit: BoxFit.cover)
        ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body : Column(
        children: <Widget>[
          CommonWidgets(title: (AppLocalizations.of(context).translate
            ('ImageCompression')),imgPath: CommonImagePaths().iconBack,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 300,
            color: Colors.blue,
            child: Center(
              child: _image == null ? Text ('No image Selected'): Image.file(_image),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  //shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.red
              ),
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 100,
            width: 100,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _image == null ? Image.asset(CommonImagePaths().dummyImage, fit: BoxFit.fill,) : Image.file(_image),
                ),
                Positioned(
                    top: -10,
                    right: -10,
                    child: IconButton(
                      icon: Icon(Icons.close_rounded),
                      onPressed: () {
                        print('close2');
                      },
                    )
                ),
              ],
            )
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: RaisedButton(
                child: Text('Select Image From Gallery'),
                  onPressed:() {
                    getImage(ImageSource.gallery);
                  },
              ),
          ),
          RaisedButton(
            child: Text('Select Image From Camera'),
            onPressed:() {
              getImage(ImageSource.camera);
            },
          ),
        ],
    )
    )
    );
  }

  /// Compress Image
  void compressImage(File file) async {
    // Get file path
    // eg:- "Volume/VM/abcd.jpeg"
    final filePath = file.absolute.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    print('vidya');

    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    print(lastIndex);
    final splitted = filePath.substring(0, (lastIndex));

    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 35); // by reducing qualiy, image size will reduce
    final File compressedFile = File(compressedImage.path);
    setState(() {
      _image = compressedFile;
    });
  }

  //get image from gallery and compress image
  Future getImage(ImageSource source) async {
    PickedFile image = await _picker.getImage(source: source,
        imageQuality: 50); // imageQuality for compress/ optimize image
    final File file = File(image.path);
    compressImage(file);
  }
}