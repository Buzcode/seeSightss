import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seesights/pages/airport_info.dart';
import 'package:seesights/pages/book_flight.dart';


class FlightSearchUI extends StatefulWidget {
  @override
  _FlightSearchUIState createState() => _FlightSearchUIState();
}

enum TripType { oneway, roundtrip, multicity }

Map<TripType, String> _tripTypes = {
  TripType.oneway: "ONE WAY",
  TripType.roundtrip: "ROUNDTRIP",
  TripType.multicity: "MULTICITY"
};

class _FlightSearchUIState extends State<FlightSearchUI> {
  TripType _selectedTrip = TripType.oneway;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: RichText(
          text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 32),
              children: [
                // flight
                TextSpan(
                  text: "Flight",
                  style: GoogleFonts.overpass(fontWeight: FontWeight.w200),
                ),
                // search
                TextSpan(
                  text: "Search",
                  style: GoogleFonts.overpass(fontWeight: FontWeight.bold),
                ),
              ]),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 6),
                          blurRadius: 6),
                    ]),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_tripTypes.length, (index) {
                    return buildTripTypeSelector(
                        _tripTypes.keys.elementAt(index));
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: 20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(24),
                ),
                onPressed: () {},
                child: buildAirportSelector(
                    AirportInfo(
                        "BOM",
                        "Chatrapati Shivaji Maharaj International Airport",
                        "Mumbai"),
                    Icons.flight_takeoff),
              ),
              Container(
                height: 1,
                color: Colors.black26,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(20),
                ),
                onPressed: () {},
                child: buildAirportSelector(
                    AirportInfo(
                        "DEL",
                        "Indira Gandhi International Airport                          ",
                        "Delhi"),
                    Icons.flight_land),
              ),
              Container(
                height: 1,
                color: Colors.black26,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        onPressed: () {},
                        child: buildDateSelector("DEPARTURE", DateTime.now()),
                      )),
                  Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        onPressed: () {},
                        child: buildDateSelector(
                            "RETURN", DateTime.now().add(Duration(days: 10))),
                      )),
                ],
              ),
              Container(
                height: 1,
                color: Colors.black26,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        ),
                        onPressed: () {},
                        child: buildTravelersView(),
                      )),
                  Expanded(
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 18.0),
                                    child: Text(
                                      "CABIN",
                                      style: GoogleFonts.overpass(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "ECONOMY CLASS",
                                    style: GoogleFonts.overpass(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))),
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 12),
                            blurRadius: 12,
                          ),
                        ],
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                MediaQuery.of(context).size.width * 2, 100)),
                      )),
                  Center(
                    child: Material(
                      color: Colors.blue,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      elevation: 16,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BookFlightUI()),
                          );
                        },
                        splashColor: Colors.blueGrey,
                        child: Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: Text(
                            "Book Now",
                            style: GoogleFonts.overpass(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTripTypeSelector(TripType tripType) {
    var isSelected = _selectedTrip == tripType;
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.only(left: 4, right: 16),
        backgroundColor: isSelected ? Colors.blue : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      onPressed: () {
        setState(() {
          _selectedTrip = tripType;
        });
      },
      child: Row(
        children: <Widget>[
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          Text(
            _tripTypes[tripType] ?? '',
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget buildAirportSelector(AirportInfo airportinfo, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // airportCode
        Container(
          width: 60,
          child: Text(
            airportinfo.airportCode,
            style: GoogleFonts.overpass(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.black54,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              airportinfo.airportShortName,
              style: GoogleFonts.overpass(
                fontSize: 24,
                color: Colors.black87,
              ),
            ),
            Text(
              airportinfo.airportLongName,
              style: GoogleFonts.overpass(
                fontSize: 12,
                color: Colors.black87,
              ),
            )
          ],
        ),
        Icon(icon)
      ],
    );
  }

  Widget buildDateSelector(String title, DateTime dateTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
        ),
        Row(
          children: <Widget>[
            Text(
              dateTime.day.toString().padLeft(2, '0'),
              style: GoogleFonts.overpass(fontSize: 48),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Jan 2025',
                  style: GoogleFonts.overpass(fontSize: 16),
                ),
                Text(
                  'Friday',
                  style: GoogleFonts.overpass(fontSize: 16, color: Colors.grey),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget buildTravelersView() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                "TRAVELLERS",
                style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
              ),
            ),
            Text(
              "01",
              style: GoogleFonts.overpass(fontSize: 24),
            )
          ],
        )
      ],
    );
  }
}
