import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';
import '../l10n/translations.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _faceVerification = true;
  bool _phoneVerification = true;
  bool _aiScamPrevention = true;
  bool _privateProfile = false;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.verificationSecurity,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Safety First Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF4D67), Color(0xFFFF8A5C)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.security, color: Colors.white, size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.safetyFirst,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t.safetyDescription,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().scale(),
          const SizedBox(height: 32),

          // Settings
          _buildSwitchItem(
            icon: Icons.person_search,
            title: t.faceVerification,
            subtitle: t.faceVerificationDescription,
            value: _faceVerification,
            onChanged: (v) => setState(() => _faceVerification = v),
          ),
          const SizedBox(height: 24),
          _buildSwitchItem(
            icon: Icons.phone_iphone,
            title: t.phoneVerification,
            subtitle: t.phoneVerificationDescription,
            value: _phoneVerification,
            onChanged: (v) => setState(() => _phoneVerification = v),
          ),
          const SizedBox(height: 24),
          _buildSwitchItem(
            icon: Icons.shield,
            title: t.aiScamPrevention,
            subtitle: t.aiScamPreventionDescription,
            value: _aiScamPrevention,
            onChanged: (v) => setState(() => _aiScamPrevention = v),
          ),
          const SizedBox(height: 24),
          _buildSwitchItem(
            icon: Icons.lock_outline,
            title: t.privateProfile,
            subtitle: t.privateProfileDescription,
            value: _privateProfile,
            onChanged: (v) => setState(() => _privateProfile = v),
          ),

          const SizedBox(height: 32),
          Text(
            t.firebaseNote,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ],
    );
  }
}
