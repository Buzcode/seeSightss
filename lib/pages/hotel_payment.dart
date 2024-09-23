import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentPage extends StatefulWidget {
  final DateTime arrivalDate;
  final DateTime departureDate;
  final int numberOfGuests;

  const PaymentPage({
    required this.arrivalDate,
    required this.departureDate,
    required this.numberOfGuests,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';
  bool _isProcessingPayment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cardNumber = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Expiry Date (MM/YY)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your expiry date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _expiryDate = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'CVV',
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your CVV';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cvv = value!;
                },
              ),
              const SizedBox(height: 32),

              if (_isProcessingPayment)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        _isProcessingPayment = true; // Set flag to true
                      });
                      // Simulate payment processing delay
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          _isProcessingPayment = false; // Reset flag
                        });
                        // TODO: Implement actual payment processing logic here

                        print('Payment details:');
                        print('Card Number: $_cardNumber');
                        print('Expiry Date: $_expiryDate');
                        print('CVV: $_cvv');
                        print('Arrival: ${DateFormat('MMMM dd, yyyy').format(widget.arrivalDate)}');
                        print('Departure: ${DateFormat('MMMM dd, yyyy').format(widget.departureDate)}');
                        print('Guests: ${widget.numberOfGuests}');
                      });
                    }
                  },
                  child: const Text('Confirm Booking'),
                ),
              if (_isProcessingPayment)
                const Padding(
                  padding:  EdgeInsets.only(top: 16.0),
                  child: Text('Payment in process...', style: TextStyle(fontSize: 16)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}