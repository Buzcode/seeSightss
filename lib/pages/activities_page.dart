import 'package:flutter/material.dart';
import 'package:seesights/pages/activity_booking.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  // Sample activity data
  final List<Activity> activities = [
    Activity(
      name: 'Hiking',
      imageUrl: 'assets/images/hiking.png',
      description: 'Explore breathtaking trails and enjoy the beauty of nature.',
      price: 25.00,
    ),
    Activity(
      name: 'Kayaking',
      imageUrl: 'assets/images/kayaking.png',
      description:
      'Experience thrilling water activities like snorkeling, diving, and jet skiing.',
      price: 45.00,
    ),
    Activity(
      name: 'Museum',
      imageUrl: 'assets/images/museums.png',
      description:
      'Discover the rich culture and history of the local area with guided tours.',
      price: 30.00,
    ),
    Activity(
      name: 'Hot Air Balloon',
      imageUrl: 'assets/images/balloon.png',
      description:
      'Enjoy panoramic views, a gentle breeze, and the serenity of a sunrise or sunset flight.',
      price: 30.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0), // Add padding to the body
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.5, // Adjust aspect ratio for better fit
          ),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return ActivityCard(activity: activities[index]);
          },
        ),
      ),
    );
  }
}

class Activity {
  final String name;
  final String imageUrl;
  final String description;
  final double price;

  Activity({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
  });
}

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image with constrained height
          Image.asset(
            activity.imageUrl,
            height: 120, // Constrain image height
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  activity.description,
                  style: const TextStyle(fontSize: 14.0),
                  maxLines: 2, // Limit description lines
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8.0),
                Text(
                  '\$${activity.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingPage(activity: activity)),
                );
                // Implement booking logic here
                // You can navigate to a booking page or display a dialog.
                print('Booking ${activity.name}');
              },
              child: const Text('Book Now'),
            ),
          ),
        ],
      ),
    );
  }
}