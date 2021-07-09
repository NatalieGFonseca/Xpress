import 'package:flutter/material.dart';
import 'package:xpress/key.dart'; // Stores the Google Maps API Key
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xpress/pagamento.dart';

import 'dart:math' show cos, sqrt, asin;

import 'package:xpress/tela_motorista.dart';
import 'package:xpress/tela_usuario.dart';
import 'package:xpress/usuariosLista.dart';

import 'motoristasLista.dart';

class Mapa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localização',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapView(),
    );
  }
}

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;

  Position posicao;
  String endereco;

  final iniciaEnderecoController = TextEditingController();
  final destinoEnderecoController = TextEditingController();

  final enderecoFocusNode = FocusNode();
  final destinoFocusNode = FocusNode();

  String _iniciaEndereco = '';
  String _destinoEndereco = '';
  String _distancia;
  double _totalApagar;
  String _valor;
  Set<Marker> markers = {};

  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _textField({
    TextEditingController controller,
    FocusNode focusNode,
    String label,
    String hint,
    double width,
    Icon prefixIcon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey[400],
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue[300],
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        posicao = position;
        print('CURRENT POS: $posicao');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // captura o endereco
  _getAddress() async {
    try {
      List<Placemark> p =
          await placemarkFromCoordinates(posicao.latitude, posicao.longitude);

      Placemark place = p[0];
      //Rua, numero, bairro, cidade - estado, codigo postal, país
      setState(() {
        endereco =
            "${place.street}, ${place.name}, ${place.subLocality}, ${place.subAdministrativeArea} - ${place.administrativeArea}, ${place.country}";
        iniciaEnderecoController.text = endereco;
        _iniciaEndereco = endereco;
      });
    } catch (e) {
      print(e);
    }
  }

  // calculo da distancia
  Future<bool> _calculateDistance() async {
    try {
      List<Location> startPlacemark =
          await locationFromAddress(_iniciaEndereco);
      List<Location> destinationPlacemark =
          await locationFromAddress(_destinoEndereco);

      if (startPlacemark != null && destinationPlacemark != null) {
        Position cordenadas = _iniciaEndereco == endereco
            ? Position(latitude: posicao.latitude, longitude: posicao.longitude)
            : Position(
                latitude: startPlacemark[0].latitude,
                longitude: startPlacemark[0].longitude);
        Position destinoCordenadas = Position(
            latitude: destinationPlacemark[0].latitude,
            longitude: destinationPlacemark[0].longitude);

        // Marcador do ponto de origem
        Marker startMarker = Marker(
          markerId: MarkerId('$cordenadas'),
          position: LatLng(
            cordenadas.latitude,
            cordenadas.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Origem',
            snippet: _iniciaEndereco,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        // Marcador do ponto de destino
        Marker destinationMarker = Marker(
          markerId: MarkerId('$destinoCordenadas'),
          position: LatLng(
            destinoCordenadas.latitude,
            destinoCordenadas.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Destino',
            snippet: _destinoEndereco,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        markers.add(startMarker);
        markers.add(destinationMarker);

        print('Origem: $cordenadas');
        print('Destino: $destinoCordenadas');

        Position _northeastCoordinates;
        Position _southwestCoordinates;

        double miny = (cordenadas.latitude <= destinoCordenadas.latitude)
            ? cordenadas.latitude
            : destinoCordenadas.latitude;
        double minx = (cordenadas.longitude <= destinoCordenadas.longitude)
            ? cordenadas.longitude
            : destinoCordenadas.longitude;
        double maxy = (cordenadas.latitude <= destinoCordenadas.latitude)
            ? destinoCordenadas.latitude
            : cordenadas.latitude;
        double maxx = (cordenadas.longitude <= destinoCordenadas.longitude)
            ? destinoCordenadas.longitude
            : cordenadas.longitude;

        _southwestCoordinates = Position(latitude: miny, longitude: minx);
        _northeastCoordinates = Position(latitude: maxy, longitude: maxx);

        mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              northeast: LatLng(
                _northeastCoordinates.latitude,
                _northeastCoordinates.longitude,
              ),
              southwest: LatLng(
                _southwestCoordinates.latitude,
                _southwestCoordinates.longitude,
              ),
            ),
            100.0,
          ),
        );

        await _createPolylines(cordenadas, destinoCordenadas);

        double totalDistance = 0.0;

        totalDistance = _coordinateDistance(
            cordenadas.latitude,
            cordenadas.longitude,
            destinoCordenadas.latitude,
            destinoCordenadas.longitude);

        _totalApagar = _tarifaCorrida(totalDistance);

        setState(() {
          _distancia = totalDistance.toStringAsFixed(2);
          print('Distância: $_distancia km');
          _valor = _totalApagar.toStringAsFixed(2);
          print('Valor a pagar: $_valor Reais');
        });

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Fórmula de cálculo da distância
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  /*Tarifa sobre a distância */
  double _tarifaCorrida(double distancia) {
    double tarifa = 2;
    double cobranca = distancia * tarifa;
    return cobranca;
  }

  _createPolylines(Position start, Position destination) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Chave.API_KEY, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        appBar: AppBar(title: const Text('Xpress')),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Nome do Usuario"),
                accountEmail: Text("nome@email.com"),
                currentAccountPicture: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://w7.pngwing.com/pngs/831/216/png-transparent-computer-icons-youtube-youtube-logo-profile-avatar-area.png'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              ListTile(
                  title: Text("Home"),
                  trailing: Icon(Icons.home),
                  onTap: () {
                    Navigator.push(
                      context, //AQUI VAI PARA A TELA DE USUÁRIO
                      MaterialPageRoute(builder: (context) => TelaUsuario()),
                    );
                  }),
              ListTile(
                  title: Text("Perfil"),
                  subtitle: Text("Alteração de dados"),
                  trailing: Icon(Icons.account_circle),
                  onTap: () {
                    Navigator.push(
                      context, //AQUI VAI PARA A TELA DE MOTORISTA
                      MaterialPageRoute(builder: (context) => TelaMotorista()),
                    );
                  }),
              ListTile(
                  title: Text("Pagamentos"),
                  trailing: Icon(Icons.payment),
                  onTap: () {
                    Navigator.push(
                      context, //AQUI VAI PARA A TELA DE PAGAMENTO
                      MaterialPageRoute(builder: (context) => TelaPagamento()),
                    );
                    debugPrint('Vai para tela de pagamento ');
                  }),
              ListTile(
                  title: Text("Solicitar Corrida"),
                  trailing: Icon(Icons.map),
                  onTap: () {
                    Navigator.push(
                      context, //AQUI VAI PARA A TELA DE PAGAMENTO
                      MaterialPageRoute(builder: (context) => MapView()),
                    );
                    debugPrint('Vai pra tela de historico de corrida');
                  }),
              ListTile(
                  title: Text("Registro motorista"),
                  trailing: Icon(Icons.drive_eta_rounded),
                  onTap: () {
                    Navigator.push(
                      context, //AQUI VAI A CLASSE DA PAGINA ONDE TA SEGUNDA ROTA
                      MaterialPageRoute(builder: (context) => MotoristaLista()),
                    );
                  }),
              ListTile(
                  title: Text("Registro usuario"),
                  trailing: Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                      context, //AQUI VAI A CLASSE DA PAGINA ONDE TA SEGUNDA ROTA
                      MaterialPageRoute(builder: (context) => UsuarioLista()),
                    );
                  }),
            ],
          ),
        ),
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            // Apresenta o mapa
            GoogleMap(
              markers: markers != null ? Set<Marker>.from(markers) : null,
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.blue[100],
                        child: InkWell(
                          splashColor: Colors.blue,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.add),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Colors.blue[100],
                        child: InkWell(
                          splashColor: Colors.blue,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.remove),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Localização',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(height: 10),
                          _textField(
                              label: 'Origem',
                              hint: 'Escolha o ponto de partida',
                              prefixIcon: Icon(Icons.looks_one),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.my_location),
                                onPressed: () {
                                  iniciaEnderecoController.text = endereco;
                                  _iniciaEndereco = endereco;
                                },
                              ),
                              controller: iniciaEnderecoController,
                              focusNode: enderecoFocusNode,
                              width: width,
                              locationCallback: (String value) {
                                setState(() {
                                  _iniciaEndereco = value;
                                });
                              }),
                          SizedBox(height: 10),
                          _textField(
                              label: 'Destino',
                              hint: 'Escolha o destino',
                              prefixIcon: Icon(Icons.looks_two),
                              controller: destinoEnderecoController,
                              focusNode: destinoFocusNode,
                              width: width,
                              locationCallback: (String value) {
                                setState(() {
                                  _destinoEndereco = value;
                                });
                              }),
                          SizedBox(height: 10),
                          Visibility(
                            visible: _distancia == null ? false : true,
                            child: Text(
                              'Distância: $_distancia km - A pagar: $_valor Reais',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[300]),
                            ),
                          ),
                          SizedBox(height: 5),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            onPressed: (_iniciaEndereco != '' &&
                                    _destinoEndereco != '')
                                ? () async {
                                    enderecoFocusNode.unfocus();
                                    destinoFocusNode.unfocus();
                                    setState(() {
                                      if (markers.isNotEmpty) markers.clear();
                                      if (polylines.isNotEmpty) {
                                        polylines.clear();
                                      }
                                      if (polylineCoordinates.isNotEmpty) {
                                        polylineCoordinates.clear();
                                      }
                                      _distancia = null;
                                    });

                                    _calculateDistance().then((isCalculated) {
                                      if (isCalculated) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Distância calculada'),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Erro'),
                                          ),
                                        );
                                      }
                                    });
                                  }
                                : null,
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Rota'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange[100],
                      child: InkWell(
                        splashColor: Colors.orange,
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  posicao.latitude,
                                  posicao.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
