
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hala_app_sample/common/app_constants_or_strings/strings_or_constants.dart';
import 'package:hala_app_sample/common/widgets/widgets.dart';
import 'package:hala_app_sample/localization/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class DropdownSample extends StatefulWidget {
  DropdownSample({Key key}) : super(key: key);

  @override
  _DropdownSampleState createState() => _DropdownSampleState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownSampleState extends State<DropdownSample> {
  String dropdownValue = 'One';
  String _currentSelectedValue = 'Food';
  var _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];
  //File _image;
  //Dio dio = new Dio();
  //FormData formdata = new FormData();
  get textStyle => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
            children: <Widget>[
              Center(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
                  children: getCommonWidget(),
                ),
              ),
              CommonWidgets(title: 'Common Widgets',imgPath: CommonImagePaths().iconBack,),
              // RaisedButton(
              //     child: Text('Select Image'),
              //     onPressed: () {
              //
              //     })
            ],
          )

    );
  }
// Add Dropdown
  List<Widget>getCommonWidget() {
    List<Widget> commonWidget = new List();
    commonWidget.add(
       getDropdownWidgetForNumbers()
    );
    commonWidget.add(
        getDropdownWidgetForCurrency()
    );
    // commonWidget.add(
    //   Container(
    //     width: MediaQuery.of(context).size.width,
    //     child: FlatButton(
    //       child: Icon(
    //         Icons.camera_alt,
    //         color: Colors.redAccent,
    //       ),
    //       // onPressed: () async {
    //       //   await this._getImage();
    //       // },
    //       color: Colors.white,
    //     ),
    //     margin: EdgeInsets.only(top: 20.0),
    //   )
    // );

    return commonWidget;
  }

  getDropdownWidgetForNumbers() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 0,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  getDropdownWidgetForCurrency() {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              labelStyle: textStyle,
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: 'Please select expense',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: _currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _currentSelectedValue,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  _currentSelectedValue = newValue;
                  state.didChange(newValue);
                });
              },
              items: _currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  /* this is the function that handles getting the image from the device*/
  // Future _getImage() async {
  //   var image = await ImagePicker.pickImage(
  //       source: ImageSource.gallery);
  //   setState(() {
  //     _image = image as File;
  //   });
  // }

  /*sample API code for image upload , Uncomment when get API
  uploadImage() {
    formdata.add("photos", new UploadFileInfo(_image, basename(_image.relativePath)));
    dio.post(uploadURL, data: formdata, options: Options(
      method: 'POST',
      responseType: ResponseType.PLAIN
    ))
    .then((response) => print(response))
    .catchError((error) => print(error));
  }

   */
}



