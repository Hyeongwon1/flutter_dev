import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool choolCheckDone = false;
  GoogleMapController? mapController;

  static final LatLng companyLatLng = LatLng(37.5233273, 126.921252);

  static final CameraPosition innitPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  static final double okDistance = 100;
  static final Circle withinDistanceCircle = Circle(
      circleId: CircleId('withinDistanceCircle'),
      center: companyLatLng,
      fillColor: Colors.blue.withOpacity(0.5),
      radius: okDistance,
      strokeColor: Colors.blue,
      strokeWidth: 1);

  static final Circle notWithinDistanceCircle = Circle(
      circleId: CircleId('notWithinDistanceCircle'),
      center: companyLatLng,
      fillColor: Colors.red.withOpacity(0.5),
      radius: okDistance,
      strokeColor: Colors.red,
      strokeWidth: 1);

  static final Circle checkDoneClircle = Circle(
      circleId: CircleId('checkDoneClircle'),
      center: companyLatLng,
      fillColor: Colors.green.withOpacity(0.5),
      radius: okDistance,
      strokeColor: Colors.green,
      strokeWidth: 1);

  static final Marker marker =
      Marker(markerId: MarkerId('marker'), position: companyLatLng);

  @override
  void initState() {
    super.initState();

    Geolocator.getCurrentPosition().then((value) => print(value));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == '위치 권한이 허가되었습니다') {
            return StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  bool isWithinRange = false;

                  if (snapshot.hasData) {
                    final start = snapshot.data!;
                    final end = companyLatLng;

                    final distance = Geolocator.distanceBetween(start.latitude,
                        start.longitude, end.latitude, end.longitude);

                    if (distance < okDistance) {
                      isWithinRange = true;
                    }
                  }
                  return Column(
                    children: [
                      _CustomGoogleMap(
                        innitPosition: innitPosition,
                        circle: choolCheckDone
                            ? checkDoneClircle
                            : isWithinRange
                                ? withinDistanceCircle
                                : notWithinDistanceCircle,
                        marker: marker,
                        onMapCreated: onMapCreated,
                      ),
                      _ChoolCheckButton(
                        isWithinRange: isWithinRange,
                        choolCheckDone: choolCheckDone,
                        onPressed: onChoolCheckPressed,
                      ),
                    ],
                  );
                });
          }
          return Center(
            child: Text(snapshot.data),
          );
        },
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    print("Google Map is created");
    mapController = controller;
  }

  onChoolCheckPressed() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('출근하기'),
          content: Text('출근할거여?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('출근하기'),
            ),
          ],
        );
      },
    );

    if (result) {
      setState(() {
        choolCheckDone = true;
      });
    }
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치서비스 활성화 요망';
    }

    LocationPermission checkPermission = await Geolocator.checkPermission();

    if (checkPermission == LocationPermission.denied) {
      checkPermission = await Geolocator.requestPermission();

      if (checkPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }

    if (checkPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅에서 허가해주세요.';
    }

    return '위치 권한이 허가되었습니다';
  }

  AppBar renderAppBar() {
    return AppBar(
      title: Text('툴툴근',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w700,
          )),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: ()  async {
            if (mapController == null) {
              return;
            }

            final location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low,);

            mapController!.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(location.latitude,
                    location.longitude),
              ),
            );
          },
          color: Colors.cyan,
          icon: Icon(Icons.my_location),

        ),
      ],
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition innitPosition;
  final Circle circle;
  final Marker marker;
  final MapCreatedCallback onMapCreated;

  const _CustomGoogleMap(
      {required this.innitPosition,
      required this.circle,
      required this.marker,
      required this.onMapCreated,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        initialCameraPosition: innitPosition,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        circles: Set.from([circle]),
        markers: Set.from([marker]),
        onMapCreated: onMapCreated,
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  final bool isWithinRange;
  final bool choolCheckDone;
  final VoidCallback onPressed;

  const _ChoolCheckButton(
      {required this.isWithinRange,
      required this.onPressed,
      required this.choolCheckDone,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timelapse_outlined,
            size: 50,
            color: isWithinRange ? Colors.blue : Colors.red,
          ),
          const SizedBox(
            height: 20.0,
          ),
          if (!choolCheckDone && isWithinRange)
            TextButton(onPressed: onPressed, child: Text('출근하기')),
        ],
      ),
    );
  }
}