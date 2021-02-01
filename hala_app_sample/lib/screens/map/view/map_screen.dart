import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hala_app_sample/common/app_constants_or_strings/strings_or_constants.dart';
import 'package:hala_app_sample/common/widgets/widgets.dart';
import 'package:hala_app_sample/localization/app_localizations.dart';
import 'package:hala_app_sample/screens/map/view/search_list.dart';
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flushbar/flushbar.dart';

class MapSample extends StatefulWidget {
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  _MapSampleState({Key key, this.title});
  static final CameraPosition _initialcameraposition = CameraPosition(
    target: LatLng(10.022110, 76.303574),
    zoom: 20,
  );
  CameraPosition myLocation;
  GoogleMapController mapController;
  Position _currentPosition;
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _currentAddress;
  final String title;
  bool showFlushBar = false;
  Flushbar _flushbar = Flushbar();


  @override
  void initState() {
    super.initState();
        _getCurrentLocation();
  }
  // Completer<GoogleMapController> _controller = Completer();
  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(10.022110, 76.303574),
  //   zoom: 20,
  // );
  //
  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(10.022110, 76.303574),
  //     tilt: 76.5500,
  //     zoom: 10.151926040649414);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CommonWidgets(title: (AppLocalizations.of(context).translate('Map')),imgPath: CommonImagePaths().iconBack,),
          if (_currentPosition != null)
            Text("LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition
                .longitude}, \n Address: ${_currentAddress}" ),
          Row(
            children: <Widget>[
              Expanded(child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: RaisedButton(
                    color: Colors.blue,
                    child: Text('Get Location'),
                    onPressed: () {
                      _getCurrentLocation();
                    }),
              )
              ),
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text('Bottom Sheet'),
                        onPressed: () {
                          displayBottomSheet(context);
                      }),
                )
              ), Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: RaisedButton(
                        color: Colors.blue,
                        child: Text('Flush Bar'),
                        onPressed: () {
                          setState(() {
                            showFlushBar = !showFlushBar ;
                          });
                        }),
                  )
              )
            ],
          ),


          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: (MediaQuery.of(context).size.height) - 500,
               // color: Colors.blue,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initialcameraposition,
                  myLocationEnabled: true,
                  onMapCreated: _onMapCreated,
                ),
              ),
              SearchList(),

            ],
          ),
          showFlushBar == true ?
          (_flushbar = Flushbar(
            title: 'Hello there',
            message: 'How are you?',
            duration: Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.BOTTOM,
            flushbarStyle: FlushbarStyle.GROUNDED,
          )..show(context))  : removeFlushbar(_flushbar)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.my_location),
        //Text('My Location',
        //style: TextStyle(fontSize: 10,),
       // textAlign: TextAlign.center,),
        onPressed: () {
          mapController.animateCamera(CameraUpdate.newCameraPosition(myLocation));
        },
      )
     );
  }


//get current location as latitude and longitude
  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLong();
    }).catchError((e) {
      print(e);
    });
  }

  //get address by using latitude and longitude
  _getAddressFromLatLong() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
      _currentPosition.latitude, _currentPosition.longitude );
      Placemark place = p[0];
      setState(() {
        myLocation = CameraPosition(target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 10,
        bearing: 10);
        _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Container removeFlushbar(Flushbar flushbar) {
    flushbar.dismiss();
    setState(() {
      showFlushBar = false;
    });
    return Container(
    );
  }

  // void _onMapCreated(GoogleMapController _cntlr)
  // {
  //   _controller = _cntlr;
  //   _location.onLocationChanged.listen((l) {
  //     _controller.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 20),
  //       ),
  //     );
  //   });
  // }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height  * 0.15,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
                          child: Column(
                            children: <Widget>[
                              Text('Abi Dhar',
                                textAlign: TextAlign.left,),
                              Text('Al Hanafi, Riyadh',
                                style: TextStyle(
                                    fontSize: 10
                                ),)
                            ],
                          ),
                        )),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: RaisedButton(
                              child: Text('Change Location'),
                              onPressed: null),
                        ))


                  ],
                ),
                RaisedButton(
                    child: Text('Proceed',
                    style: TextStyle(
                      color: Colors.white
                    ),),
                    color: Colors.black,
                    onPressed: null)
              ],
            )
          );
        });
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}

