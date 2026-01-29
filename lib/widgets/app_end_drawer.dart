import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme.dart';
import '../l10n/translations.dart';

class AppEndDrawer extends StatelessWidget {
  const AppEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                  ),
                  child: const Icon(Icons.favorite, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.appTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      t.findYourPerfectMatch,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.local_fire_department,
                  title: t.matches,
                  color: AppColors.primary,
                  onTap: () => context.go('/'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.explore_outlined,
                  title: t.discover,
                  color: AppColors.primary,
                  onTap: () => context.push('/explore'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.chat_bubble_outline,
                  title: t.messages,
                  color: AppColors.primary,
                  onTap: () => context.push('/chats'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  title: t.profile,
                  color: AppColors.primary,
                  onTap: () => context.push('/profile'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.calendar_today_outlined,
                  title: t.singlesEvents,
                  color: AppColors.primary,
                  onTap: () => context.push('/events'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.workspace_premium_outlined,
                  title: t.subscriptionPlans,
                  color: AppColors.primary,
                  onTap: () => context.push('/subscription'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.security_outlined,
                  title: t.verificationSecurity,
                  color: AppColors.primary,
                  onTap: () => context.push('/security'),
                ),
                const Divider(height: 32),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings_outlined,
                  title: t.settings,
                  color: AppColors.primary,
                  onTap: () {},
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.help_outline,
                  title: t.help,
                  color: AppColors.primary,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onTap: () {
        Scaffold.of(context).closeEndDrawer();
        onTap();
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
