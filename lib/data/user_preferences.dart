class UserPreferences {
  final int minAge;
  final int maxAge;
  final String education;
  final String work;
  final List<String> hobbies;
  final String relationshipGoal;

  const UserPreferences({
    required this.minAge,
    required this.maxAge,
    required this.education,
    required this.work,
    required this.hobbies,
    required this.relationshipGoal,
  });

  // Default preferences
  static const defaultPreferences = UserPreferences(
    minAge: 18,
    maxAge: 35,
    education: '',
    work: '',
    hobbies: [],
    relationshipGoal: 'Long-term Relationship',
  );

  // Create preferences from dating preferences screen data
  factory UserPreferences.fromDatingPreferences({
    required int minAge,
    required int maxAge,
    required String education,
    required String work,
    required List<String> hobbies,
    required String relationshipGoal,
  }) {
    return UserPreferences(
      minAge: minAge,
      maxAge: maxAge,
      education: education,
      work: work,
      hobbies: hobbies,
      relationshipGoal: relationshipGoal,
    );
  }

  // Get age range string
  String get ageRange => '$minAge-$maxAge';

  // Check if preferences are complete (for validation)
  bool get isComplete {
    return minAge > 0 &&
        maxAge > minAge &&
        education.isNotEmpty &&
        work.isNotEmpty &&
        hobbies.isNotEmpty &&
        relationshipGoal.isNotEmpty;
  }

  @override
  String toString() {
    return 'UserPreferences{'
        'minAge: $minAge, '
        'maxAge: $maxAge, '
        'education: $education, '
        'work: $work, '
        'hobbies: $hobbies, '
        'relationshipGoal: $relationshipGoal'
        '}';
  }
}
