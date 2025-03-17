import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/theme.dart';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'subscription.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  
  // Controllers for text fields
  final _usernameController = TextEditingController(text: '');
  final _firstnameController = TextEditingController(text: '');
  final _lastnameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _birthdayController = TextEditingController(text: '');
  final _genderController = TextEditingController(text: '');
  final _phoneController = TextEditingController(text: '');

  // Define colors for consistency
  final Color primaryGreen = const Color(0xFF207008); // Deeper green
  final Color secondaryGreen = const Color(0xFF46C221); // Medium green
  final Color lightGreen = const Color(0xFFE8F5E9); // Light green background
  final Color accentGreen = const Color(0xFF78F951); // Accent green
  
  @override
  void _fetchUserDetails() async {
    User? user = authService.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _emailController.text = user.email ?? 'No email';
            _usernameController.text = userDoc['username'] ?? 'No username';
            _firstnameController.text = userDoc['first_name'] ?? 'No first name';
            _lastnameController.text = userDoc['last_name'] ?? 'No last name';
            _phoneController.text = userDoc['phone'] ?? 'No phone number';
            _birthdayController.text = userDoc['birthday'] ?? 'No birthday';
            _genderController.text = userDoc['gender'] ?? 'No gender';
          });
        }
      } catch (e) {
        print('Error fetching user details: $e');
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdayController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  _buildSubscriptionCard(context),
                  const SizedBox(height: 32),
                  _buildProfileImage(),
                  const SizedBox(height: 32),
                  _buildProfileInformation(),
                  const SizedBox(height: 24),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          'Profile',
          style: GoogleFonts.outfit(
            fontSize: 32,
            color: AppColors.h1,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const Spacer(),
        _buildLogoutButton(context),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: const Icon(Icons.logout, color: AppColors.logout),
        onPressed: () => _showLogoutDialog(context),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Logout',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.inter(),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: Colors.grey[600],
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.inter(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  if (mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                      (route) => false,
                    );
                  }
                } catch (e) {
                  print('Logout failed: $e');
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubscriptionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryGreen, secondaryGreen],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF46C221).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubscriptionPage()),
          ),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subscribe Now for\nExclusive Benefits',
                        style: GoogleFonts.outfit(
                          color: AppColors.secondary,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildLearnMoreButton(),
                    ],
                  ),
                ),
                _buildSubscriptionIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLearnMoreButton() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Learn More',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.star,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/default_profile.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          if (_isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF46C221),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: GestureDetector(
                  onTap: _showImagePickerOptions,
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: Text('Take Photo', style: GoogleFonts.inter()),
            onTap: () {
              // Implement camera image picker
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text('Choose from Gallery', style: GoogleFonts.inter()),
            onTap: () {
              // Implement gallery image picker
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInformation() {
    return Column(
      children: [
        _buildProfileField(
          'Username',
          _usernameController,
          Icons.person_outline,
        ),
        _buildProfileField(
          'Email',
          _emailController,
          Icons.email_outlined,
          validator: _validateEmail,
        ),
        Row(
          children: [
            Expanded(
              child: _buildProfileField(
                'First Name',
                _firstnameController,
                Icons.person_outline,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildProfileField(
                'Last Name',
                _lastnameController,
                Icons.person_outline,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildProfileField(
                'Birthday',
                _birthdayController,
                Icons.calendar_today_outlined,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildProfileField(
                'Gender',
                _genderController,
                Icons.people_outline,
              ),
            ),
          ],
        ),
        _buildProfileField(
          'Contact Number',
          _phoneController,
          Icons.phone_outlined,
          validator: _validatePhone,
        ),
      ],
    );
  }

  

 Widget _buildProfileField(
  String label,
  TextEditingController controller,
  IconData icon, {
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.defaultText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),

        // ✅ If Editing Mode is Active
        if (_isEditing)
          label == 'Gender' 
            ? DropdownButtonFormField<String>(
                value: _genderController.text.isNotEmpty ? _genderController.text : null,
                onChanged: (String? newValue) {
                  setState(() {
                    _genderController.text = newValue!;
                  });
                },
                items: ['Male', 'Female', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  prefixIcon: Icon(icon, color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  filled: true,
                ),
              )
            : TextFormField(
                controller: controller,
                validator: validator,
                readOnly: label == 'Email' || label == 'Birthday', // ✅ Make Email & Birthday Always Read-Only
                onTap: () {
                  if (label == 'Birthday') {
                    _selectDate(context); // ✅ Opens Date Picker on Tap
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(icon, color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  filled: label == 'Email', // ✅ Darken background for Email
                  fillColor: label == 'Email' ? Colors.grey[200] : Colors.transparent,
                ),
                style: TextStyle(
                  color: label == 'Email' ? Colors.grey[600] : Colors.black,
                ),
              )

        // ✅ If NOT Editing, Show Read-Only Text
        else
          Row(
            children: [
              Icon(icon, color: Colors.grey[400], size: 20),
              const SizedBox(width: 8),
              Text(
                controller.text.isEmpty ? 'Not Set' : controller.text,
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

        if (!_isEditing) ...[
          const SizedBox(height: 8),
          const Divider(height: 1),
        ],
      ],
    ),
  );
}



  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validateBirthday(String? value) {
    if (value == null || value.isEmpty) {
      return 'Birthday is required';
    }

    try {
      DateTime.parse(value); // Ensure it's a valid date
    } catch (e) {
      return 'Enter a valid date (YYYY-MM-DD)';
    }

    return null;
  }


  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\(\d{3}\) \d{3}-\d{4}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  Widget _buildActionButtons() {
    return SizedBox(
      width: double.infinity,
      child: _isEditing
          ? Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.grey[800],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF46C221),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : ElevatedButton(
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF46C221).withOpacity(0.1),
                foregroundColor: const Color(0xFF46C221),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Edit Profile',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
    );
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      try {
        // Get the current user's ID
        String userId = FirebaseAuth.instance.currentUser!.uid;

        // Update Firestore with new profile info
        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          //'first_name': _firstNameController.text.trim(),
          //'last_name': _lastNameController.text.trim(),
          'email': _emailController.text.trim(),
          'username': _usernameController.text.trim(),
          'first_name': _firstnameController.text.trim(),
          'last_name': _lastnameController.text.trim(),
          'phone': _phoneController.text.trim(),
          'birthday': _birthdayController.text.trim(),
          'gender': _genderController.text.trim(),
          'updated_at': FieldValue.serverTimestamp(),
        });

        // Ensure the dialog is dismissed
        if (mounted) {
          Navigator.of(context, rootNavigator: true).pop();
        }

        if (mounted) {
          setState(() {
            _isEditing = false;
          });
        }

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Text('Profile updated successfully', style: GoogleFonts.inter()),
              ],
            ),
            backgroundColor: const Color(0xFF46C221),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      } catch (e) {
        if (mounted) {
          Navigator.of(context, rootNavigator: true).pop();
        }

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    // Add listeners to controllers if needed
    _emailController.addListener(() {
      // Implement email validation in real-time
    });

    _phoneController.addListener(() {
      // Implement phone number formatting in real-time
    });
  }
}

// Add this extension for input validation
extension StringValidation on String {
  bool isValidEmail() {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  bool isValidPhone() {
    return RegExp(r'^\(\d{3}\) \d{3}-\d{4}$').hasMatch(this);
  }

  String formatPhone() {
    // Remove all non-numeric characters
    String numbers = replaceAll(RegExp(r'[^\d]'), '');
    
    // Format the number
    if (numbers.length >= 10) {
      return '(${numbers.substring(0, 3)}) ${numbers.substring(3, 6)}-${numbers.substring(6, 10)}';
    }
    return this;
  }
}