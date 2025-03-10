import 'package:flutter/material.dart';
import '../utils/theme.dart';

class CustomizePage extends StatefulWidget {
  const CustomizePage({Key? key}) : super(key: key);

  @override
  _CustomizePageState createState() => _CustomizePageState();
}

class _CustomizePageState extends State<CustomizePage> {
  /// The color options remain so users can pick from them.
  final List<Color> colorOptions = const [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 106, 0),
    Color.fromARGB(255, 251, 255, 0),
    Color.fromARGB(255, 13, 255, 0),
    Color.fromARGB(255, 0, 8, 255),
  ];

  final List<String> shapeOptions = ['Square', 'Circle', 'Rectangle'];

  // Initial customization values
  Color selectedColor = const Color(0xFF46C221);
  double selectedSize = 50;
  String selectedShape = 'Square';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade50,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.h1),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Customize',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.h1,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              /// Preview at the top
              Card(
                color: Colors.green.shade50,
                margin: const EdgeInsets.only(top: 20, bottom: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: selectedSize * 2,
                    height: selectedSize * 2,
                    decoration: BoxDecoration(
                      color: selectedColor,
                      shape: selectedShape == 'Circle' ? BoxShape.circle : BoxShape.rectangle,
                      borderRadius: selectedShape == 'Rectangle'
                          ? BorderRadius.circular(12)
                          : (selectedShape == 'Square' ? BorderRadius.circular(4) : null),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.h1.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// Color Section
              _buildSection(
                context,
                title: 'Color',
                icon: Icons.palette,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: colorOptions.map((color) {
                      final bool isSelected = (selectedColor == color);
                      return GestureDetector(
                        onTap: () => setState(() => selectedColor = color),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.green.shade700 : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.h2.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: isSelected
                              ? Center(
                                  child: Icon(
                                    Icons.check,
                                    color: color.computeLuminance() > 0.5 ? AppColors.h1 : Colors.white,
                                    size: 20,
                                  ),
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              /// Shape Section
              _buildSection(
                context,
                title: 'Shape',
                icon: Icons.category,
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: shapeOptions.map((shape) {
                      final bool isSelected = (selectedShape == shape);
                      return GestureDetector(
                        onTap: () => setState(() => selectedShape = shape),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Color(0xFF46C221), Color(0xFF207008)],
                                  )
                                : null,
                            color: isSelected ? null : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.h2.withOpacity(0.05),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              shape,
                              style: TextStyle(
                                color: isSelected ? Colors.white : AppColors.h1,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              /// Size Section
              _buildSection(
                context,
                title: 'Size',
                icon: Icons.straighten,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Min/Max labels
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Small', style: TextStyle(color: AppColors.h2, fontSize: 12)),
                        Text('Large', style: TextStyle(color: AppColors.h2, fontSize: 12)),
                      ],
                    ),
                    // Slider
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 4,
                        activeTrackColor: const Color(0xFF46C221),
                        inactiveTrackColor: Colors.green.shade100,
                        thumbColor: const Color(0xFF207008),
                        overlayColor: Colors.green.shade600.withOpacity(0.2),
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
                      ),
                      child: Slider(
                        value: selectedSize,
                        min: 20,
                        max: 100,
                        divisions: 8,
                        label: '${selectedSize.round()}',
                        onChanged: (value) => setState(() => selectedSize = value),
                      ),
                    ),
                    // Display chosen size
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          '${selectedSize.round()} px',
                          style: const TextStyle(
                            color: AppColors.h1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// Apply Changes Button
              ElevatedButton(
                onPressed: () {
                  // Show confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Changes applied successfully!'),
                      backgroundColor: const Color(0xFF207008),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF46C221),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Color(0xFF46C221)),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Apply Changes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper widget for each section (Color, Shape, Size)
  Widget _buildSection(BuildContext context, { 
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 18, color: AppColors.h1),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.h1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}