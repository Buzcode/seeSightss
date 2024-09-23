import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seesights/pages/payment_info.dart';

class BookFlightUI extends StatefulWidget {
  final DateTime date;
  final String destinationFrom;
  final String destinationTo;
  final String flightClass;
  final double price;
  final String seat;

  const BookFlightUI({
    required this.date,
    required this.destinationFrom,
    required this.destinationTo,
    required this.flightClass,
    required this.price,
    required this.seat,
  });

  @override
  _BookFlightUIState createState() => _BookFlightUIState();
}

class _BookFlightUIState extends State<BookFlightUI> {
  final _formKey = GlobalKey<FormState>();

  String _fullName = '';
  String _passportNumber = '';
  String _email = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 32),
            children: [
              TextSpan(
                text: "Flight",
                style: GoogleFonts.overpass(fontWeight: FontWeight.w200),
              ),
              TextSpan(
                text: "Booking",
                style: GoogleFonts.overpass(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Text(
                    "Personal Information",
                    style: GoogleFonts.overpass(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5), // Reduce the space here

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F5FB), // Light bluish background color
                      ),
                      keyboardType: TextInputType.text,
                      onSaved: (value) => _fullName = value ?? '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Passport Number",
                        prefixIcon: const Icon(Icons.book),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F5FB), // Light bluish background color
                      ),
                      keyboardType: TextInputType.text,
                      onSaved: (value) => _passportNumber = value ?? '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your passport number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F5FB), // Light bluish background color
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) => _email = value ?? '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Phone",
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F5FB), // Light bluish background color
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) => _phone = value ?? '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20), // Reduce space before the button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        backgroundColor: Colors.blue, // Bluish button color
                        foregroundColor: Colors.white,
                        elevation: 5,
                      ),
                      onPressed: _submitForm,
                      child: Text(
                        "Next",
                        style: GoogleFonts.overpass(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Navigate to PaymentPage, passing all necessary data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentInfo(
            fullName: _fullName,
            passportNumber: _passportNumber,
            email: _email,
            phone: _phone,
            destinationFrom: widget.destinationFrom,
            destinationTo: widget.destinationTo,
            date: widget.date,
            seat: widget.seat,
            flightClass: widget.flightClass,
            price: widget.price,
          ),
        ),
      );
    }
  }
}

