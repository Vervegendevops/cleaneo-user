import 'package:cleaneo_user/Dashboard/Address/address_page.dart';
import 'package:cleaneo_user/Dashboard/home_page.dart';
import 'package:cleaneo_user/Global/global.dart';
import 'package:cleaneo_user/end.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Test1 extends StatefulWidget {
  const Test1({Key? key}) : super(key: key);

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  LatLng? sourceLocation;
  LatLng? destLocation;
  String? address = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        sourceLocation = LatLng(position.latitude, position.longitude);
      });

      // Retrieve the address for the current location
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      setState(() {
        ALatitude = position.latitude.toString();
        ALongitude = position.longitude.toString();
        address =
            '${placemarks[0].thoroughfare}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode}';
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        if (sourceLocation != null)
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  onTap: _handleMapTap,
                  initialCameraPosition: CameraPosition(
                    target: sourceLocation!,
                    zoom: 15,
                  ),
                  markers: _buildMarkers(),
                  buildingsEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.08,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.my_location_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            address!.length > 30
                                ? '${address!.substring(0, 30)}...'
                                : address!,
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.06,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xff29b2fe),
                        elevation: 0, // Text color
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                      onPressed: () async {
                        Caddress = address!;
                        print(ALatitude);
                        print(ALongitude);
                        Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const HomePage()),
                        // );
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Proceed',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    ));
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};

    if (destLocation != null) {
      markers.add(
        Marker(
          markerId: MarkerId('Destination'),
          position: destLocation!,
        ),
      );
      markers.remove(
        Marker(
          markerId: MarkerId('Source'),
          position: sourceLocation!,
          infoWindow: InfoWindow(title: 'Source Location'),
        ),
      );
    } else {
      markers.add(
        Marker(
          markerId: MarkerId('Source'),
          position: sourceLocation!,
          infoWindow: InfoWindow(title: 'Source Location'),
        ),
      );
    }

    return markers;
  }

  void _handleMapTap(LatLng tappedPoint) async {
    setState(() {
      destLocation = tappedPoint;
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          tappedPoint.latitude, tappedPoint.longitude);
      setState(() {
        address =
            '${placemarks[0].thoroughfare}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode}';
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
