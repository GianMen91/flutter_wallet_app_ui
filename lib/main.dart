import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Wallet App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: WalletHome(),
    );
  }
}

class WalletHome extends StatelessWidget {
  WalletHome({super.key});

  final List<Map<String, String>> cards = [
    {
      "balance": "\$5250.25",
      "number": "12345678",
      "expiry": "10/24",
      "color": "0xFF8A2BE2" // Purple
    },
    {
      "balance": "\$1200.00",
      "number": "87654321",
      "expiry": "12/25",
      "color": "0xFF20B2AA" // LightSeaGreen
    },
    {
      "balance": "\$340.50",
      "number": "11223344",
      "expiry": "11/23",
      "color": "0xFFFF6347" // Tomato
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: 'My ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'Cards'),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: cards.length,
              itemBuilder: (context, index, realIndex) {
                final card = cards[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: MediaQuery.of(context).size.width *
                      0.8, // Ensure width is greater than height
                  decoration: BoxDecoration(
                    color: Color(int.parse(card['color']!)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Balance',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          card['balance']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                card['number']!,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                card['expiry']!,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ])
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                viewportFraction:
                    0.9, // Slightly larger to ensure the width is noticeable
              ),
            ),
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.send, size: 40, color: Colors.orange),
                    SizedBox(height: 8),
                    Text('Send'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.payment, size: 40, color: Colors.blue),
                    SizedBox(height: 8),
                    Text('Pay'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.receipt_long, size: 40, color: Colors.green),
                    SizedBox(height: 8),
                    Text('Bills'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              leading:
                  const Icon(Icons.bar_chart, color: Colors.orange, size: 40),
              title: const Text('Statistics'),
              subtitle: const Text('Payment and Income'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.green, size: 40),
              title: const Text('Transactions'),
              subtitle: const Text('Transaction History'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.pink),
              onPressed: () {},
            ),
            const SizedBox(width: 32), // Space for the floating action button
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.attach_money, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
