import 'package:flutter/material.dart';
import 'package:seesights/pages/home_screen.dart';
import 'book_flight.dart';

class SearchFlightPage extends StatefulWidget {
  @override
  _SearchFlightPageState createState() => _SearchFlightPageState();
}

class _SearchFlightPageState extends State<SearchFlightPage> {
  String? selectedDestinationFrom;
  String? selectedDestinationTo;
  DateTime? selectedDate;
  String? selectedSeat;
  String? selectedClass;
  List<Map<String, dynamic>> filteredFlights = [];

  final List<Map<String, dynamic>> availableFlights = [
    {
      'from': 'Dhaka (DAC)',
      'to': 'London (LHR)',
      'airline': 'British Airways',
      'flightNo': 'BA123',
      'departureTime': '10:35 AM',
      'arrivalTime': '5:35 PM',
      'price': {
        'Economy': 1000.0,
        'Business': 1500.0,
        'First': 2000.0,
      },
      'gate': 'B2',
      'seats': ['1A', '2B', '3C', '4D'],
      'classes': ['Economy', 'Business', 'First'],
    },
    {
      'from': 'Dhaka (DAC)',
      'to': 'Dubai (DXB)',
      'airline': 'Emirates',
      'flightNo': 'EK456',
      'departureTime': '11:00 AM',
      'arrivalTime': '6:00 PM',
      'price': {
        'Economy': 850.0,
        'Business': 1200.0,
        'First': 1800.0,
      },
      'gate': 'C1',
      'seats': ['1A', '2B', '3C', '4D'],
      'classes': ['Economy', 'Business', 'First'],
    },
    {
      'from': 'Dhaka (DAC)',
      'to': 'New York (JFK)',
      'airline': 'United Airlines',
      'flightNo': 'UA789',
      'departureTime': '12:00 PM',
      'arrivalTime': '8:00 PM',
      'price': {
        'Economy': 1200.0,
        'Business': 1800.0,
        'First': 2500.0,
      },
      'gate': 'D4',
      'seats': ['1A', '2B', '3C', '4D'],
      'classes': ['Economy', 'Business', 'First'],
    },
    {
      'from': 'Sylhet (ZYL)',
      'to': 'London (LHR)',
      'airline': 'British Airways',
      'flightNo': 'BA567',
      'departureTime': '9:00 AM',
      'arrivalTime': '4:00 PM',
      'price': {
        'Economy': 1100.0,
        'Business': 1600.0,
        'First': 2200.0,
      },
      'gate': 'B1',
      'seats': ['1A', '2B', '3C', '4D'],
      'classes': ['Economy', 'Business', 'First'],
    },
    // ... Add more flight data here
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _filterFlights() {
    setState(() {
      filteredFlights = availableFlights.where((flight) {
        return flight['from'].toLowerCase().contains(selectedDestinationFrom!.toLowerCase()) &&
            flight['to'].toLowerCase().contains(selectedDestinationTo!.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find Your Flight',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            // Search Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'From',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedDestinationFrom = value;
                        _filterFlights(); // Filter flights when From changes
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'To',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedDestinationTo = value;
                        _filterFlights(); // Filter flights when To changes
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                TextButton.icon(
                  onPressed: () => _selectDate(context),
                  icon: Icon(Icons.calendar_today, color: Colors.blue),
                  label: Text(
                    selectedDate == null
                        ? 'Select Date'
                        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFlights.length, // Use filteredFlights for display
                itemBuilder: (context, index) {
                  final flight = filteredFlights[index];
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${flight['airline']} - ${flight['flightNo']}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('${flight['from']} to ${flight['to']}'),
                          SizedBox(height: 8),
                          Text('Departure: ${flight['departureTime']}'),
                          Text('Arrival: ${flight['arrivalTime']}'),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'GATE',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('${flight['gate']}'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select Seat',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButton<String>(
                                    value: selectedSeat,
                                    hint: Text('Select Seat'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedSeat = newValue;
                                      });
                                    },
                                    items: flight['seats'].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select Class',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButton<String>(
                                    value: selectedClass,
                                    hint: Text('Select Class'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedClass = newValue;
                                      });
                                    },
                                    items: flight['classes'].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          // Dynamic Pricing based on Class
                          Text(
                            '\$${flight['price'][selectedClass ?? 'Economy']}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Bluish background color
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Wider padding
                            ),
                            onPressed: () {
                              // Navigate to booking or checkout page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookFlightUI(
                                    date: selectedDate!, // Make sure selectedDate is not null before navigation
                                    destinationFrom: flight['from'],
                                    destinationTo: flight['to'],
                                    flightClass: selectedClass ?? 'Economy', // Default to Economy if no class selected
                                    price: flight['price'][selectedClass ?? 'Economy'],
                                    seat: selectedSeat!, // Make sure selectedSeat is not null
                                  ),
                                ),
                              );
                            },
                            child: Text('Book Flight'),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

