import 'package:flutter/material.dart';
import 'package:seesights/pages/payment_page.dart';

class PaymentInfo extends StatelessWidget {
  final String destinationFrom;
  final String destinationTo;
  final DateTime date;
  final String seat;
  final String flightClass;
  final double price;
  final String email;
  final String fullName;
  final String passportNumber;
  final String phone;

  const PaymentInfo({super.key,
    required this.destinationFrom,
    required this.destinationTo,
    required this.date,
    required this.seat,
    required this.flightClass,
    required this.price,
    required this.email,
    required this.fullName,
    required this.passportNumber,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Flight Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text('From: $destinationFrom'),
              Text('To: $destinationTo'),
              Text('Date: ${date.day}/${date.month}/${date.year}'),
              Text('Seat: $seat'),
              Text('Class: $flightClass'),
              Text('Price: \$$price'),
              const SizedBox(height: 16),
              const Text(
                'Passenger Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text('Full Name: $fullName'),
              Text('Email: $email'),
              Text('Passport Number: $passportNumber'),
              Text('Phone: $phone'),
              const SizedBox(height: 32),
              const Text(
                'Select Payment Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Mastercard Box
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PaymentPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.asset(
                        'assets/images/mastercard-logo.png',
                        height: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Visa Box
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PaymentPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.asset(
                        'assets/images/visa-logo.png',
                        height: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // PayPal Box
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PaymentPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.asset(
                        'assets/images/paypal-logo.png',
                        height: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
