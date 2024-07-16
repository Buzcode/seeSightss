import 'package:flutter/material.dart';
import 'package:seesights/pages/book_flight.dart';
import 'package:seesights/pages/home_screen.dart';
import 'package:seesights/pages/payment_page.dart';

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

  final List<String> destinations = ['Dabaca (DBC)', 'Almedy (ADY)', 'Other'];
  final List<String> seats = ['1A', '2B', '3C', '4D'];
  final List<String> classes = ['Economy', 'Business', 'First'];

  final Map<String, Map<String, double>> prices = {
    'Dabaca (DBC)': {'Economy': 1170.0, 'Business': 2250.0, 'First': 3350.0},
    'Almedy (ADY)': {'Economy': 1200.0, 'Business': 3300.0, 'First': 4100.0},
    'Other': {'Economy': 1150.0, 'Business': 2220.0, 'First': 3100.0},
  };

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  double? getPrice() {
    if (selectedDestinationTo != null && selectedClass != null) {
      return prices[selectedDestinationTo]?[selectedClass!];
    }
    return null;
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
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add flight',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const TabBar(
                      indicatorColor: Colors.grey,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(text: 'Route'),
                        Tab(text: 'Flight'),
                        Tab(text: 'Seat'),
                        Tab(text: 'Checkout'),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          // Row for From and To
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Column for "From"
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownButton<String>(
                                    value: selectedDestinationFrom,
                                    hint: Text('From'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedDestinationFrom = newValue;
                                      });
                                    },
                                    items: destinations.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  Text(
                                    selectedDestinationFrom ?? '',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Icon(Icons.flight_takeoff, color: Colors.black),
                              // Column for "To"
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  DropdownButton<String>(
                                    value: selectedDestinationTo,
                                    hint: Text('To'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedDestinationTo = newValue;
                                      });
                                    },
                                    items: destinations.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  Text(
                                    selectedDestinationTo ?? '',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          // Row for Date, Gate, Flight No
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Column for "Select Date"
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton.icon(
                                    onPressed: () => _selectDate(context),
                                    icon: Icon(Icons.calendar_today, color: Colors.black),
                                    label: Text(
                                      selectedDate == null
                                          ? 'Select Date'
                                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              // Column for "GATE"
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'GATE',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4), // Add some spacing
                                  const Text(
                                    'B2',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              // Column for "FLIGHT NO"
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'FLIGHT NO',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'KB70',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          // Row for Boarding Time, Seat, Class
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Column for "Boarding Time"
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'BOARDING TIME',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    '8:35 AM',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              // Column for "Select Seat"
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownButton<String>(
                                    value: selectedSeat,
                                    hint: Text('Select Seat'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedSeat = newValue;
                                      });
                                    },
                                    items: seats.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              // Column for "Select Class"
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownButton<String>(
                                    value: selectedClass,
                                    hint: Text('Select Class'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedClass = newValue;
                                      });
                                    },
                                    items: classes.map<DropdownMenuItem<String>>((String value) {
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
                          const SizedBox(height: 15),
                          // Price Display
                          Text(
                            selectedDestinationTo != null && selectedClass != null
                                ? '\$${getPrice()?.toStringAsFixed(2)}'
                                : '\$0.00',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Payment Options
                          const Text(
                            'Payment via',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Payment Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BookFlightUI()),
                                    );
                                  },
                                  child: const Text('Visa'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BookFlightUI()),
                                    );
                                  },
                                  child: const Text('MasterCard'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BookFlightUI()),
                                    );
                                  },
                                  child: const Text('PayPal'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}