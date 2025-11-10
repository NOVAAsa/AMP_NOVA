import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const SaladApp());
}

class SaladApp extends StatelessWidget {
  const SaladApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Salad Catalog",
      theme: ThemeData(fontFamily: "Poppins"),
      home: const HomeSaladPage(),
    );
  }
}

class HomeSaladPage extends StatelessWidget {
  const HomeSaladPage({super.key});

  final List<Map<String, String>> salads = const [
    {"name": "Salad Strawberry", "price": "Rp 15.000", "img": "assets/salad1.png"},
    {"name": "Salad Buah Mix", "price": "Rp 17.000", "img": "assets/salad2.png"},
    {"name": "Salad Anggur", "price": "Rp 18.000", "img": "assets/salad3.jpg"},
    {"name": "Salad Mangga", "price": "Rp 16.000", "img": "assets/salad4.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700.withOpacity(0.7),
          elevation: 0,
          title: const Text("Katalog Salad Buah",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "List View"),
              Tab(text: "Grid View"),
            ],
          ),
        ),

        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6EB6FF), Color(0xFF004AAD)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: TabBarView(
            children: [
              // 📍 LIST VIEW
              ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: salads.length,
                itemBuilder: (context, index) {
                  return SaladCard(salad: salads[index]);
                },
              ),

              // 🧩 GRID VIEW
              GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: salads.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
                itemBuilder: (context, index) {
                  final item = salads[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SaladDetailPage(salad: item)));
                    },
                    child: GlassBox(
                      padding: EdgeInsets.zero,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Image.asset(item["img"]!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover),
                            Container(color: Colors.black.withOpacity(0.25)),
                            Positioned(
                              bottom: 8,
                              left: 10,
                              child: Text(item["name"]!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SaladCard extends StatelessWidget {
  final Map<String, String> salad;
  const SaladCard({super.key, required this.salad});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => SaladDetailPage(salad: salad)));
      },
      child: GlassBox(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(salad["img"]!,
                  width: 70, height: 70, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(salad["name"]!,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(salad["price"]!,
                    style: const TextStyle(color: Colors.white70)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SaladDetailPage extends StatelessWidget {
  final Map<String, String> salad;
  const SaladDetailPage({super.key, required this.salad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700.withOpacity(0.5),
        elevation: 0,
        title: Text(salad["name"]!, style: const TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6EB6FF), Color(0xFF004AAD)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: GlassBox(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(salad["name"]!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text("Harga: ${salad["price"]!}",
                      style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 22),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.85),
                        foregroundColor: Colors.black),
                    onPressed: () {},
                    child: const Text("Pesan Sekarang"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 💠 GLASSMORPHISM WIDGET
class GlassBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GlassBox({super.key, required this.child, this.padding, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: padding ?? const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
