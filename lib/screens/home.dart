import 'package:flutter/material.dart';
import 'package:portfolio/screens/chatscreen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  final Uri githubUrl = Uri.parse("https://github.com/manahilshakil");
  final Uri linkedinUrl = Uri.parse("https://linkedin.com/in/manahilshakil");
  final Uri emailUrl = Uri.parse("mailto:i.manahilshakil@gmail.com");

  void _launchURL(Uri url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  final List<Map<String, String>> services = [
    {"image": "assets/images/web.png"},
    {"image": "assets/images/app.png"},
    {"image": "assets/images/scrape.png"},
    {"image": "assets/images/analysis.png"},
    {"image": "assets/images/ai.png"},
    {"image": "assets/images/uiux.png"},
    {"image": "assets/images/branding.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Manahil's Portfolio",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(onPressed: () {}, child: Text("Home", style: TextStyle(color: Colors.black))),
          TextButton(onPressed: () {}, child: Text("Work", style: TextStyle(color: Colors.black))),
          TextButton(onPressed: () {}, child: Text("Contact", style: TextStyle(color: Colors.black))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF63B3ED),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text("Get Tutored", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Decorative Triangle
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomPaint(
              size: Size(100, 100),
              painter: TrianglePainter(),
            ),
          ),

          // Main Content
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            children: [
              SizedBox(height: 120),
              Center(child: CircleAvatar(radius: 40, backgroundColor: Colors.grey[300])),
              SizedBox(height: 20),
              Text(
                "Your One-Stop Shop for Websites, \nApps, AI/ML and Data Analysis",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.code, color: Color(0xFF63B3ED)), onPressed: () => _launchURL(githubUrl)),
                  IconButton(icon: Icon(Icons.work, color: Color(0xFF63B3ED)), onPressed: () => _launchURL(linkedinUrl)),
                  IconButton(icon: Icon(Icons.email, color: Color(0xFF63B3ED)), onPressed: () => _launchURL(emailUrl)),
                ],
              ),
              SizedBox(height: 200),

              // Services Header
              Divider(),
              SizedBox(height: 60),
              Center(
                child: Text("Here’s how I can help you out !",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFBEE3F8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Services", style: TextStyle(fontWeight: FontWeight.w500)),
                ),
              ),
              SizedBox(height: 30),

              // Service Cards
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: services.map((service) {
                  return _HoverCard(imagePath: service['image']!);
                }).toList(),
              ),

              SizedBox(height: 80),
            ],
          ),

          // Floating Chat Button
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80, right: 20),
        child: Material(
          type: MaterialType.transparency,
          child: CocoBotChat(scrollController: ScrollController()),
        ),
      ),
    ),
  );
              },
              icon: Icon(Icons.chat,color: Colors.white,),
              label: Text("Chat with Coco",style: TextStyle(color: Colors.white),),
              backgroundColor: Color(0xFF63B3ED),
            ),
          ),
        ],
      ),
    );
  }
}


class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFF63B3ED)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _HoverCard extends StatefulWidget {
  final String imagePath;
  const _HoverCard({required this.imagePath});

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.2 : 1.0,
        duration: Duration(milliseconds: 200),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: 150,
            height: 150,
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
