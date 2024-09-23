import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarBookingPage extends StatefulWidget {
  const CarBookingPage({Key? key}) : super(key: key);

  @override
  CarBookingPageState createState() => CarBookingPageState();
}

class CarBookingPageState extends State<CarBookingPage> {
  DateTime _selectedPickupDate = DateTime.now();
  String _selectedPickupLocation = 'Select Pickup Location';
  String _selectedPickupCity = 'Select Pickup City';
  String _selectedReturnCity = 'Select Drop-Off City';
  String _selectedPaymentMethod = 'Select Payment Method';
  double _estimatedPrice = 0;

  // Define a Map for locations with their respective cities
  final Map<String, List<String>> locationsWithCities = {
    'New York': ['Manhattan', 'Brooklyn', 'Queens', 'The Bronx', 'Staten Island'],
    'Paris': ['Paris Center', 'Eiffel Tower', 'Louvre Museum', 'Montmartre', 'Latin Quarter'],
    'London': ['Buckingham Palace', 'Tower Bridge', 'Big Ben', 'Hyde Park', 'Covent Garden'],
  };

  // Define price ranges for different locations
  final Map<String, Map<String, double>> priceRanges = {
    'New York': {
      'Manhattan': 20.0,
      'Brooklyn': 30.0,
      'Queens': 40.0,
      'The Bronx': 50.0,
      'Staten Island': 60.0,
    },
    'Paris': {
      'Paris Center': 25.0,
      'Eiffel Tower': 35.0,
      'Louvre Museum': 45.0,
      'Montmartre': 55.0,
      'Latin Quarter': 65.0,
    },
    'London': {
      'Buckingham Palace': 20.0,
      'Tower Bridge': 30.0,
      'Big Ben': 40.0,
      'Hyde Park': 50.0,
      'Covent Garden': 60.0,
    },
  };

  void _presentDatePicker(BuildContext context, DateTime initialDate, Function(DateTime?) onDateChanged) {
    showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      onDateChanged(pickedDate);
    });
  }

  void _showLocationPicker(BuildContext context, Function(String) onLocationSelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              for (var location in locationsWithCities.keys)
                ListTile(
                  title: Text(location),
                  onTap: () => onLocationSelected(location),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showCityPicker(BuildContext context, String selectedLocation, Function(String) onCitySelected) {
    if (locationsWithCities.containsKey(selectedLocation)) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            child: Column(
              children: [
                for (var city in locationsWithCities[selectedLocation]!)
                  ListTile(
                    title: Text(city),
                    onTap: () => onCitySelected(city),
                  ),
              ],
            ),
          );
        },
      );
    }
  }

  void _showPaymentMethodPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding:  EdgeInsets.all(16.0),
                child: Text(
                  'Select Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.attach_money, size: 30),
                title: const Text('Cash'),
                onTap: () => setState(() {
                  _selectedPaymentMethod = 'Cash';
                  Navigator.pop(context);
                }),
              ),
              ListTile(
                leading: Image.asset('assets/images/Apple-Pay.png', height: 30),
                title: const Text('Apple Pay'),
                onTap: () => setState(() {
                  _selectedPaymentMethod = 'Apple Pay';
                  Navigator.pop(context);
                }),
              ),
              ListTile(
                leading: Image.asset('assets/images/google-pay.png', height: 30),
                title: const Text('Google Pay'),
                onTap: () => setState(() {
                  _selectedPaymentMethod = 'Google Pay';
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  void _calculateEstimatedPrice() {
    if (_selectedPickupLocation != 'Select Pickup Location' &&
        _selectedPickupCity != 'Select Pickup City' &&
        _selectedReturnCity != 'Select Drop-Off City') {
      _estimatedPrice = priceRanges[_selectedPickupLocation]![_selectedPickupCity]!;
    } else {
      _estimatedPrice = 0;
    }
  }

  void _navigateToPaymentPage() {
    if (_selectedPaymentMethod == 'Select Payment Method') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a payment method'),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentConfirmationPage(
          pickupDate: _selectedPickupDate,
          pickupLocation: _selectedPickupLocation,
          pickupCity: _selectedPickupCity,
          returnCity: _selectedReturnCity,
          paymentMethod: _selectedPaymentMethod,
          estimatedPrice: _estimatedPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Car'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pickup Date
              const Text(
                'Pickup Date:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _presentDatePicker(context, _selectedPickupDate, (pickedDate) {
                  setState(() {
                    _selectedPickupDate = pickedDate!;
                  });
                }),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(DateFormat('MMMM dd, yyyy').format(_selectedPickupDate)),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Pickup Location:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _showLocationPicker(context, (location) {
                  setState(() {
                    _selectedPickupLocation = location;
                  });
                }),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(_selectedPickupLocation),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pickup City:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _showCityPicker(context, _selectedPickupLocation, (city) {
                  setState(() {
                    _selectedPickupCity = city;
                    _calculateEstimatedPrice();
                  });
                }),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(_selectedPickupCity),
                ),
              ),
              const SizedBox(height: 16),

              // Return City
              const Text(
                'Drop-Off:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _showCityPicker(context, _selectedPickupLocation, (city) {
                  setState(() {
                    _selectedReturnCity = city;
                    _calculateEstimatedPrice();
                  });
                }),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(_selectedReturnCity),
                ),
              ),
              const SizedBox(height: 16),

              // Estimated Price
              if (_estimatedPrice > 0)
                Text(
                  'Estimated Price: \$${_estimatedPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 16),

              // Payment Method
              const Text(
                'Payment Method:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _showPaymentMethodPicker(context),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(_selectedPaymentMethod),
                ),
              ),
              const SizedBox(height: 16),

              // Book Button
              ElevatedButton(
                onPressed: _navigateToPaymentPage,
                child: const Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentConfirmationPage extends StatelessWidget {
  final DateTime pickupDate;
  final String pickupLocation;
  final String pickupCity;
  final String returnCity;
  final String paymentMethod;
  final double estimatedPrice;

  const PaymentConfirmationPage({
    required this.pickupDate,
    required this.pickupLocation,
    required this.pickupCity,
    required this.returnCity,
    required this.paymentMethod,
    required this.estimatedPrice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pickup Date: ${DateFormat('MMMM dd, yyyy').format(pickupDate)}'),
            Text('Pickup Location: $pickupLocation'),
            Text('Pickup City: $pickupCity'),
            Text('Drop-Off: $returnCity'),
            Text('Payment Method: $paymentMethod'),
            Text('Estimated Price: \$${estimatedPrice.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment Successful')),
                );
                Navigator.pop(context);
              },
              child: const Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
