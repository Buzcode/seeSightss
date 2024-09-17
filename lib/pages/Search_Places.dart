import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  int _selectedPersons = 1;
  DateTime? _selectedDate;

  // Sample data - Replace with your actual data
  final List<Place> places = [
    Place(
      name: 'Hawaii, USA',
      imageUrl: 'assets/images/Hawaii.png',
      pricePerPerson: 50.00,
    ),
    Place(
      name: 'Santorini, Greece',
      imageUrl: 'assets/images/Greece.png',
      pricePerPerson: 30.00,
    ),
    Place(
      name: 'Paris, France',
      imageUrl: 'assets/images/paris.jpg',
      pricePerPerson: 75.00,
    ),
    Place(
      name: 'Venice, Italy',
      imageUrl: 'assets/images/venice.jpg',
      pricePerPerson: 75.00,
    ),
    Place(
      name: 'North Carolina, USA',
      imageUrl: 'assets/images/North Carolina.jpg',
      pricePerPerson: 75.00,
    ),
    Place(
      name: 'Blue Mountain, Australia',
      imageUrl: 'assets/images/BlueMountain.png',
      pricePerPerson: 75.00,
    ),
    Place(
      name: 'Lake Thun, Switzerland',
      imageUrl: 'assets/images/switzerland.png',
      pricePerPerson: 75.00,
    ),
  ];

  List<Place> getFilteredPlaces() {
    if (_searchTerm.isEmpty) {
      return places; // Show all places if no search term
    } else {
      return places.where((place) => place.name.toLowerCase().contains(_searchTerm.toLowerCase())).toList(); // Filter places
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent[100], // Bluish background
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for a place',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            // Search Results
            Expanded(
              child: ListView.builder(
                itemCount: getFilteredPlaces().length,
                itemBuilder: (context, index) {
                  final place = getFilteredPlaces()[index];
                  return PlaceCard(
                    place: place,
                    onBookNow: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingConfirmationPage(
                            place: place,
                            selectedDate: _selectedDate, // Pass _selectedDate from SearchPage
                            selectedPersons: _selectedPersons, // Pass _selectedPersons from SearchPage
                          ),
                        ),
                      );
                    },
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

class PlaceCard extends StatefulWidget {
  final Place place;
  final VoidCallback onBookNow;

  const PlaceCard({Key? key, required this.place, required this.onBookNow}) : super(key: key);

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  DateTime? _selectedDate;
  int _selectedPersons = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rounded Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              widget.place.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.place.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                // Price Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price per Person: \$${widget.place.pricePerPerson.toStringAsFixed(2)}'),
                    // Date Picker
                    ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        ).then((date) {
                          setState(() {
                            _selectedDate = date;
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100], // Bluish color
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Text(_selectedDate != null
                          ? '${_selectedDate!.toLocal().toString().substring(0, 10)}'
                          : 'Choose Date',
                        style: const TextStyle(
                          color: Colors.black, // Darker font color
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                // Person Selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Persons:'),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedPersons = _selectedPersons > 1 ? _selectedPersons - 1 : 1;
                            });
                          },
                          icon: const Icon(Icons.remove_circle),
                        ),
                        Text('$_selectedPersons'),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedPersons++;
                            });
                          },
                          icon: const Icon(Icons.add_circle),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Total Price
                Text(
                  'Total Price: \$${(widget.place.pricePerPerson * _selectedPersons).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                // Book Now Button
                ElevatedButton(
                  onPressed: () {
                    // Pass selected date and persons to the next page
                    widget.onBookNow();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent[100], // Bluish color
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.black, // Darker font color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookingConfirmationPage extends StatefulWidget {
  final Place place;
  final DateTime? selectedDate;
  final int selectedPersons;

  const BookingConfirmationPage({
    Key? key,
    required this.place,
    required this.selectedDate,
    required this.selectedPersons,
  }) : super(key: key);

  @override
  _BookingConfirmationPageState createState() => _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _cardNumber;
  String? _expiryDate;
  String? _cvv;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* Booking Summary
              Text(
                'Booking Summary',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Place: ${widget.place.name}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Date: ${widget.selectedDate != null ? widget.selectedDate!.toLocal().toString().substring(0, 10) : 'Not Selected'}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Persons: ${widget.selectedPersons}',
                style: const TextStyle(fontSize: 18),
              ),*/
              const SizedBox(height: 16),
              // Payment Details
              Text(
                'Payment Details',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Card Number Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  if (value.length != 16) {
                    return 'Card number must be 16 digits';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cardNumber = value;
                },
              ),
              const SizedBox(height: 16),
              // Expiry Date Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Expiry Date (MM/YY)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expiry date';
                  }
                  if (!RegExp(r'^(0[1-9]|1[0-2])\/[0-9]{2}$').hasMatch(value)) {
                    return 'Invalid expiry date format. Use MM/YY';
                  }
                  return null;
                },
                onSaved: (value) {
                  _expiryDate = value;
                },
              ),
              const SizedBox(height: 16),
              // CVV Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'CVV',
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the CVV';
                  }
                  if (value.length != 3) {
                    return 'CVV must be 3 digits';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cvv = value;
                },
              ),
              const SizedBox(height: 32),
              // Pay Now Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Process payment - Replace with your actual payment processing
                    // You'll need to use a payment gateway SDK or a mock payment system
                    print('Card Number: $_cardNumber');
                    print('Expiry Date: $_expiryDate');
                    print('CVV: $_cvv');

                    // Show Payment Success Dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Payment Successful'),
                        content: const Text('Your booking is confirmed!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              Navigator.of(context).pop(); // Go back to the previous page
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent[100], // Bluish color
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Pay Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Place {
  final String name;
  final String imageUrl;
  final double pricePerPerson;

  Place({
    required this.name,
    required this.imageUrl,
    required this.pricePerPerson,
  });
}