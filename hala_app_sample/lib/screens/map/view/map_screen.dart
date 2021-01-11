import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hala_app_sample/common/app_constants_or_strings/strings_or_constants.dart';
import 'package:hala_app_sample/common/widgets/widgets.dart';
import 'package:hala_app_sample/localization/app_localizations.dart';
import 'package:hala_app_sample/screens/map/view/search_list.dart';

class MapSample extends StatefulWidget {
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(9.3500, 76.5500),
    zoom: 10.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(10.022110, 76.303570),
      tilt: 76.5500,
      zoom: 10.151926040649414);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Column(
        children: <Widget>[
          CommonWidgets(title: (AppLocalizations.of(context).translate('Map')),imgPath: CommonImagePaths().iconBack,),
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(0),
                height: (MediaQuery.of(context).size.height) - 200,
                color: Colors.blue,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              SearchList(),
              // Container(
              //   padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              //   height: 50,
              //   child: SearchList(),
              //   color: Colors.white,
              // ),
            ],
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: _goToTheLake,
      //     label: Text('Home'),
      // icon: Icon(Icons.directions_boat),),
     );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

