
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seesights/pages/payment_page.dart';


class BookFlightUI extends StatefulWidget {
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
style: TextStyle(color: Colors.black, fontSize: 32),
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
children: <Widget>[
buildTextField(
label: "Full Name",
icon: Icons.person,
onSaved: (value) => _fullName = value ?? '',
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter your full name';
}
return null;
},
),
buildTextField(
label: "Passport Number",
icon: Icons.book,
onSaved: (value) => _passportNumber = value ?? '',
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter your passport number';
}
return null;
},
),
buildTextField(
label: "Email",
icon: Icons.email,
onSaved: (value) => _email = value ?? '',
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter your email';
}
return null;
},
),
buildTextField(
label: "Phone",
icon: Icons.phone,
onSaved: (value) => _phone = value ?? '',
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter your phone number';
}
return null;
},
),
SizedBox(height: 20),
Center(
child: Material(
color: Colors.black,
shape: CircleBorder(),
clipBehavior: Clip.antiAlias,
elevation: 16,
child: InkWell(
onTap: _submitForm,
splashColor: Colors.blueGrey[50],
child: Container(
width: 100,
height: 100,
alignment: Alignment.center,
child: Text(
"Confirm",
style: GoogleFonts.overpass(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 15,
),
),
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

Widget buildTextField({
required String label,
required IconData icon,
required FormFieldSetter<String> onSaved,
required FormFieldValidator<String> validator,
}) {
return Padding(
padding: const EdgeInsets.symmetric(vertical: 8.0),
child: TextFormField(
decoration: InputDecoration(
labelText: label,
prefixIcon: Icon(icon),
border: OutlineInputBorder(),
),
onSaved: onSaved,
validator: validator,
),
);
}

void _submitForm() {
if (_formKey.currentState!.validate()) {
_formKey.currentState!.save();

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Booking Confirmed!')),
);

Navigator.push(
context,
MaterialPageRoute(
builder: (context) => PaymentPage(
fullName: _fullName,
passportNumber: _passportNumber,
email: _email,
phone: _phone,
),
),
);
}
}
}