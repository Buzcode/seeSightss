class Hotel {
  String imageUrl;
  String name;
  String address;
  int price;

  Hotel({
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.price,
  });
}

final List<Hotel> hotels = [
  Hotel(
    imageUrl: 'assets/images/hotel0.jpg',
    name:'Hotel Ornate',
    address: 'South Korea',
    price: 175,
  ),
  Hotel(
    imageUrl: 'assets/images/hotel1.jpg',
    name: 'Signiel Seoul',
    address: 'Geneva, Switzerland',
    price: 300,
  ),
  Hotel(
    imageUrl: 'assets/images/hotel2.jpg',
    name: 'President Wilson',
    address: 'Great St',
    price: 240,
  ),
];
