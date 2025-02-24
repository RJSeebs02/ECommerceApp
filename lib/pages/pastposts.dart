import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PastPostsPage extends StatelessWidget {
  const PastPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar with a green background and white text
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Past Posts',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      // Unique background gradient for the page
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade50,
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // Grid view of past posts
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: 6, // Example: 6 past posts
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Post image placeholder with a green tint
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Container(
                          color: Colors.green.shade100,
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.green.shade600,
                          ),
                        ),
                      ),
                    ),
                    // Post title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Post Title ${index + 1}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                    // Post date
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Posted on ${DateTime.now().subtract(Duration(days: index * 5)).toLocal().toString().substring(0, 10)}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.green.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
