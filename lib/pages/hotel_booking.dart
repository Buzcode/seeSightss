import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seesights/pages/hotel_payment.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime _selectedArrivalDate = DateTime.now();
  final DateTime _selectedDepartureDate = DateTime.now().add(const Duration(days: 1));
  int _selectedNumberOfGuests = 1;

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: _selectedArrivalDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedArrivalDate = pickedDate;
      });
    });
  }

  void _navigateToPaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          arrivalDate: _selectedArrivalDate,
          departureDate: _selectedDepartureDate,
          numberOfGuests: _selectedNumberOfGuests,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Stay'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Arrival Date
              const Text(
                'Check-in:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _presentDatePicker(context),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    DateFormat('MMMM dd, yyyy').format(_selectedArrivalDate),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Departure Date
              const Text(
                'Check-out:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _presentDatePicker(context),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    DateFormat('MMMM dd, yyyy').format(_selectedDepartureDate),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Number of Guests
              const  Text(
                'Number of Guests:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_selectedNumberOfGuests > 1) {
                          _selectedNumberOfGuests--;
                        }
                      });
                    },
                  ),
                  Text('$_selectedNumberOfGuests'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _selectedNumberOfGuests++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Book Now Button
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
