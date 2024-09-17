import 'package:flutter/material.dart';
import 'package:seesights/pages/hotel_booking.dart';

class Hotel {
  final String name;
  final String location;
  final String image;
  final List<Room> rooms;

  Hotel({
    required this.name,
    required this.location,
    required this.image,
    required this.rooms,
  });
}

class Room {
  final String type;
  final int price;

  Room({
    required this.type,
    required this.price,
  });
}

// This list will hold all your hotel data
List<Hotel> allHotels = [
  Hotel(
    name: 'Grand Hyatt',
    location: 'New York City, USA',
    image: 'assets/images/grand hyatt.png',
    rooms: [
      Room(type: 'Standard', price: 200),
      Room(type: 'Deluxe', price: 300),
      Room(type: 'Suite', price: 500),
    ],
  ),
  Hotel(
    name: 'The Ritz-Carlton',
    location: 'London, UK',
    image: 'assets/images/ritz carlton.png',
    rooms: [
      Room(type: 'Classic', price: 150),
      Room(type: 'Executive', price: 300),
      Room(type: 'Presidential Suite', price: 500),
    ],
  ),
  Hotel(
    name: 'Burj Al Arab',
    location: 'Dubai, UAE',
    image: 'assets/images/burj-al-arab.png',
    rooms: [
      Room(type: 'Deluxe Ocean View', price: 500),
      Room(type: 'Royal Suite', price: 1000),
    ],
  ),
  Hotel(
    name: 'Four Seasons',
    location: 'Paris, France',
    image: 'assets/images/four season.png',
    rooms: [
      Room(type: 'Superior', price: 150),
      Room(type: 'Premium', price: 300),
      Room(type: 'Penthouse', price: 500),
    ],
  ),
  // Add more hotels here...
];

class HotelScreen extends StatefulWidget {
  @override
  _HotelScreenState createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  String searchQuery = '';
  List<Hotel> displayedHotels = [];
  bool showResults = false;

  DateTime _selectedCheckInDate = DateTime.now();
  DateTime _selectedCheckOutDate = DateTime.now().add(Duration(days: 1));

  void _searchHotels(String query) {
    setState(() {
      searchQuery = query;
      displayedHotels = allHotels.where((hotel) =>
          hotel.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
      showResults = true;
    });
  }

  Future<void> _selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedCheckInDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _selectedCheckInDate) {
      setState(() {
        _selectedCheckInDate = picked;
      });
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedCheckOutDate,
      firstDate: _selectedCheckInDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _selectedCheckOutDate) {
      setState(() {
        _selectedCheckOutDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hotel Suggestions',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              onChanged: _searchHotels,
              decoration: InputDecoration(
                hintText: 'Search by location',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.blue.shade100, // Add a light blue fill
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            // Hotel results
            if (showResults)
              Expanded(
                child: ListView.builder(
                  itemCount: displayedHotels.length,
                  itemBuilder: (context, index) {
                    return HotelCard(
                      hotel: displayedHotels[index],
                      checkInDate: _selectedCheckInDate,
                      checkOutDate: _selectedCheckOutDate,
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

class HotelCard extends StatefulWidget {
  final Hotel hotel;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  HotelCard({
    required this.hotel,
    required this.checkInDate,
    required this.checkOutDate,
  });

  @override
  _HotelCardState createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  int selectedRoomIndex = 0;

  void _selectRoom(int? index) {
    setState(() {
      selectedRoomIndex = index ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15), // Add rounded corners to the image
              child: Image.asset(
                widget.hotel.image,
                height: 250, // Adjust height as needed
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(widget.hotel.name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.hotel.location),
            // Room selection dropdown
            DropdownButton<int>(
              value: selectedRoomIndex,
              onChanged: _selectRoom,
              items: widget.hotel.rooms.asMap().entries.map((entry) {
                int index = entry.key;
                Room room = entry.value;
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text(room.type),
                );
              }).toList(),
            ),
            Text(
              'Price: \$${widget.hotel.rooms[selectedRoomIndex].price}',
              style: TextStyle(fontWeight: FontWeight.bold), // Make price bold
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300], // Set button background color
              ),
              child: Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}