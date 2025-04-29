import 'package:flutter/material.dart';

class ServicePage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {"title": "Web Development", "image": "assets/web.png"},
    {"title": "App Development", "image": "assets/app.png"},
    {"title": "Data Scraping", "image": "assets/scrape.png"},
    {"title": "Data Analysis", "image": "assets/analysis.png"},
    {"title": "AI Agents", "image": "assets/ai.png"},
    {"title": "UI/UX Design", "image": "assets/uiux.png"},
    {"title": "Branding", "image": "assets/branding.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          // Section Title
          Column(
            children: [
              Text(
                "Here’s how I can help you out !",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.lightBlueAccent,
                  decorationThickness: 2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFBEE3F8),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  "Services",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              Divider(height: 40, thickness: 1),
            ],
          ),

          // Services Grid
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: services.map((service) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Container(
                  width: 140,
                  height: 160,
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          service['image']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        service['title']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 40),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
