import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme.dart';
import '../nav.dart';
import '../data/user_preferences.dart';

class DatingPreferencesScreen extends StatefulWidget {
  const DatingPreferencesScreen({super.key});

  @override
  State<DatingPreferencesScreen> createState() => _DatingPreferencesScreenState();
}

class _DatingPreferencesScreenState extends State<DatingPreferencesScreen> {
  String? _selectedAgeRange;
  String? _selectedEducation;
  String? _selectedWork;
  List<String> _selectedHobbies = [];
  String? _selectedRelationshipGoal;

  final List<String> _ageRanges = [
    '18-25',
    '26-30',
    '31-35',
    '36-40',
    '41-45',
    '46-50',
    '50+'
  ];

  final List<String> _educationOptions = [
    'High School',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'PhD',
    'Vocational',
    'Other'
  ];

  final List<String> _workOptions = [
    'Student',
    'Professional',
    'Entrepreneur',
    'Self-Employed',
    'Retired',
    'Other'
  ];

  final List<String> _hobbies = [
    'Reading',
    'Traveling',
    'Sports',
    'Music',
    'Art',
    'Cooking',
    'Gaming',
    'Fitness',
    'Photography',
    'Nature',
    'Movies',
    'Dancing'
  ];

  final List<String> _relationshipGoals = [
    'Casual Dating',
    'Long-term Relationship',
    'Marriage',
    'Friendship',
    'Open to Anything'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dating Preferences'),
        backgroundColor: AppTheme.primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.gradient,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AI Assistant Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: const Icon(
                        Icons.psychology,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: const Text(
                        '🎯 AI Dating Assistant',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Age Range
              _buildSection(
                title: 'Age Range',
                hint: 'Select preferred age range',
                content: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _ageRanges.map((ageRange) {
                    final isSelected = _selectedAgeRange == ageRange;
                    return ChoiceChip(
                      label: Text(ageRange),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedAgeRange = selected ? ageRange : null;
                        });
                      },
                      selectedColor: AppTheme.primary,
                      backgroundColor: Colors.white.withOpacity(0.9),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? Colors.transparent : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),

              // Education
              _buildSection(
                title: 'Education',
                hint: 'Select preferred education level',
                content: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _educationOptions.map((education) {
                    final isSelected = _selectedEducation == education;
                    return ChoiceChip(
                      label: Text(education),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedEducation = selected ? education : null;
                        });
                      },
                      selectedColor: AppTheme.primary,
                      backgroundColor: Colors.white.withOpacity(0.9),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? Colors.transparent : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),

              // Work Status
              _buildSection(
                title: 'Work Status',
                hint: 'Select preferred work status',
                content: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _workOptions.map((work) {
                    final isSelected = _selectedWork == work;
                    return ChoiceChip(
                      label: Text(work),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedWork = selected ? work : null;
                        });
                      },
                      selectedColor: AppTheme.primary,
                      backgroundColor: Colors.white.withOpacity(0.9),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? Colors.transparent : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),

              // Hobbies & Interests
              _buildSection(
                title: 'Hobbies & Interests',
                hint: 'Select hobbies you enjoy (multiple)',
                content: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _hobbies.map((hobby) {
                    final isSelected = _selectedHobbies.contains(hobby);
                    return FilterChip(
                      label: Text(hobby),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedHobbies.add(hobby);
                          } else {
                            _selectedHobbies.remove(hobby);
                          }
                        });
                      },
                      selectedColor: AppTheme.primary,
                      backgroundColor: Colors.white.withOpacity(0.9),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? Colors.transparent : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),

              // Relationship Goals
              _buildSection(
                title: 'Relationship Goals',
                hint: 'What are you looking for?',
                content: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _relationshipGoals.map((goal) {
                    final isSelected = _selectedRelationshipGoal == goal;
                    return ChoiceChip(
                      label: Text(goal),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedRelationshipGoal = selected ? goal : null;
                        });
                      },
                      selectedColor: AppTheme.primary,
                      backgroundColor: Colors.white.withOpacity(0.9),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? Colors.transparent : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 40),

              // AI Advice Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '💡 AI Matchmaking Advice:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Based on your preferences, we recommend:\n\n• Being open to profiles that share similar hobbies\n• Considering partners with compatible education levels\n• Focusing on shared relationship goals\n• Prioritizing quality over quantity in matches',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Continue Button
              Center(
                child: ElevatedButton(
                  onPressed: _validateAndContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String hint,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hint,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  void _validateAndContinue() {
    if (_selectedAgeRange == null ||
        _selectedEducation == null ||
        _selectedWork == null ||
        _selectedHobbies.isEmpty ||
        _selectedRelationshipGoal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all sections'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Parse age range
    final ageRangeParts = _selectedAgeRange!.split('-');
    final minAge = int.parse(ageRangeParts[0]);
    final maxAge = int.parse(ageRangeParts[1]);

    // Create user preferences object
    final preferences = UserPreferences.fromDatingPreferences(
      minAge: minAge,
      maxAge: maxAge,
      education: _selectedEducation!,
      work: _selectedWork!,
      hobbies: List.from(_selectedHobbies),
      relationshipGoal: _selectedRelationshipGoal!,
    );

    // Save preferences and navigate to AI advice screen
    context.push(AppRoutes.aiDatingAdvice, extra: preferences);
  }
}
