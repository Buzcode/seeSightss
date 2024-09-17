import 'package:flutter/material.dart';
import 'package:seesights/pages/activities_page.dart';
//import '../Models/activity_model.dart';

class BookingPage extends StatefulWidget {
  final Activity activity;

  const BookingPage({Key? key, required this.activity}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int _selectedPassengers = 1;
  DateTime? _selectedDate;

  void _confirmBooking() {
    // Navigate to PaymentPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          activity: widget.activity,
          selectedPassengers: _selectedPassengers,
          selectedDate: _selectedDate!, // Ensure selectedDate is not null
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.activity.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.activity.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Rounder Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                widget.activity.imageUrl,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Select Date',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Bluish Date Button
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
                backgroundColor: Colors.blueAccent[100], // Light bluish background
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12), // Shorter height
              ),
              child: Text(_selectedDate != null
                  ? '${_selectedDate!.toLocal().toString().substring(0, 10)}'
                  : 'Choose a date',
                style: const TextStyle(
                  color: Colors.white, // Dark grey text
                  fontSize: 16, // Bigger font size
                  fontWeight: FontWeight.bold, // Bold font
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'People',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedPassengers =
                      _selectedPassengers > 1 ? _selectedPassengers - 1 : 1;
                    });
                  },
                  icon: const Icon(Icons.remove_circle),
                ),
                Text('$_selectedPassengers'),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedPassengers++;
                    });
                  },
                  icon: const Icon(Icons.add_circle),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Total Price with different styles
            Text(
              'Total', // Not bold
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${(widget.activity.price * _selectedPassengers).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, // Price is bold
              ),
            ),
            const SizedBox(height: 32),
            // Confirm Booking Button
            ElevatedButton(
              onPressed: _confirmBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent[100], // Bluish color like the Date button
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40), // Wider padding
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Bold font
                  color: Colors.black, // Darker font color
                ),
              ),
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final Activity activity;
  final int selectedPassengers;
  final DateTime selectedDate;

  const PaymentPage({
    Key? key,
    required this.activity,
    required this.selectedPassengers,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String? _cardNumber;
  String? _expiryDate;
  String? _cvv;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Process payment - in this example, we'll just print the collected data
                    print('Card Number: $_cardNumber');
                    print('Expiry Date: $_expiryDate');
                    print('CVV: $_cvv');
                    // ... You would implement your real payment processing logic here ...
                    // ... Use a payment gateway SDK or a mock system ...

                    // Navigate back to the BookingPage
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent[100],
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