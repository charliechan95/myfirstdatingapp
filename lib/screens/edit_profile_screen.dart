import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/mock_data.dart';
import '../theme.dart';
import '../l10n/translations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late TextEditingController _bioController;
  late TextEditingController _workController;
  late TextEditingController _educationController;
  late TextEditingController _datingPreferenceController;
  late TextEditingController _foodController;
  late TextEditingController _travelController;
  late TextEditingController _hobbyController;

  @override
  void initState() {
    super.initState();
    final user = MockData.currentUser;
    _bioController = TextEditingController(text: user.bio);
    _workController = TextEditingController(text: user.jobTitle);
    _educationController = TextEditingController(text: user.education);
    _datingPreferenceController = TextEditingController(text: user.datingPreference);
    _foodController = TextEditingController();
    _travelController = TextEditingController();
    _hobbyController = TextEditingController();
  }

  @override
  void dispose() {
    _bioController.dispose();
    _workController.dispose();
    _educationController.dispose();
    _datingPreferenceController.dispose();
    _foodController.dispose();
    _travelController.dispose();
    _hobbyController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // TODO: Implement image upload logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image selected')),
      );
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement save profile logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.editProfile),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Section
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: AppColors.primary),
                          image: DecorationImage(
                            image: AssetImage(MockData.currentUser.imageUrls.first),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(width: 3, color: Colors.white),
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Bio Section
                _buildSectionTitle(t.bio),
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: t.tellUsAboutYourself,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return t.pleaseEnterBio;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Work Section
                _buildSectionTitle(t.work),
                TextFormField(
                  controller: _workController,
                  decoration: InputDecoration(
                    hintText: t.yourJobTitle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),

                const SizedBox(height: 20),

                // Education Section
                _buildSectionTitle(t.education),
                TextFormField(
                  controller: _educationController,
                  decoration: InputDecoration(
                    hintText: t.yourEducation,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),

                const SizedBox(height: 20),

                // Dating Preference Section
                _buildSectionTitle(t.datingPreference),
                TextFormField(
                  controller: _datingPreferenceController,
                  decoration: InputDecoration(
                    hintText: t.whatAreYouLookingFor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),

                const SizedBox(height: 30),

                // Question Prompts Section
                _buildSectionTitle(t.questionPrompts),

                // Favorite Food
                TextFormField(
                  controller: _foodController,
                  decoration: InputDecoration(
                    labelText: t.favoriteFood,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),

                const SizedBox(height: 12),

                // Favorite Travel Destination
                TextFormField(
                  controller: _travelController,
                  decoration: InputDecoration(
                    labelText: t.favoriteTravelDestination,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),

                const SizedBox(height: 12),

                // Hobby
                TextFormField(
                  controller: _hobbyController,
                  decoration: InputDecoration(
                    labelText: t.favoriteHobby,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),

                const SizedBox(height: 40),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      t.saveProfile,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
