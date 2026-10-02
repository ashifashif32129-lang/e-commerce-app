import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  String name = 'Ashif';
  String email = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
    email = user?.email ?? 'ashif@gmail.com';
    name = user?.displayName ?? 'Ashif';
  }

  void editProfile() {
    final nameController = TextEditingController(text: name);
    final phoneController = TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                name = nameController.text.trim();
                phone = phoneController.text.trim();
              });

              await user?.updateDisplayName(name);

              if (context.mounted) {
                Navigator.pop(context);
              }

              nameController.dispose();
              phoneController.dispose();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void openPage(String title, String description) {
    Get.to(
          () => SimpleFeaturePage(
        title: title,
        description: description,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.to(
                  () => const SettingsScreen(),
            ),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 42,
                  backgroundColor: Color(0xffe8edff),
                  child: Icon(
                    Icons.person,
                    size: 48,
                    color: Color(0xff4f65d9),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color,
                  ),
                ),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: editProfile,
                  icon: const Icon(
                    Icons.edit,
                    size: 16,
                  ),
                  label: const Text('Edit Profile'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const SectionTitle(title: 'My Shopping'),

          ProfileTile(
            icon: Icons.shopping_bag_outlined,
            title: 'My Orders',
            subtitle: 'View your order history',
            onTap: () => openPage(
              'My Orders',
              'Your orders will appear here.',
            ),
          ),

          ProfileTile(
            icon: Icons.favorite_border,
            title: 'My Wishlist',
            subtitle: 'Your saved products',
            onTap: () => openPage(
              'My Wishlist',
              'Your wishlist products will appear here.',
            ),
          ),

          ProfileTile(
            icon: Icons.location_on_outlined,
            title: 'My Addresses',
            subtitle: 'Manage delivery addresses',
            onTap: () => openPage(
              'My Addresses',
              'Add and manage your delivery addresses.',
            ),
          ),

          ProfileTile(
            icon: Icons.payment_outlined,
            title: 'Payment Methods',
            subtitle: 'Manage payment options',
            onTap: () => openPage(
              'Payment Methods',
              'Your payment options will appear here.',
            ),
          ),

          const SizedBox(height: 16),

          const SectionTitle(title: 'Account'),

          ProfileTile(
            icon: Icons.notifications_none,
            title: 'Notifications',
            subtitle: 'Notification preferences',
            onTap: () => Get.to(
                  () => const SettingsScreen(),
            ),
          ),

          ProfileTile(
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'App preferences',
            onTap: () => Get.to(
                  () => const SettingsScreen(),
            ),
          ),

          ProfileTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () => openPage(
              'Help & Support',
              'Contact support for assistance.',
            ),
          ),

          ProfileTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () => openPage(
              'Privacy Policy',
              'Privacy policy details go here.',
            ),
          ),

          ProfileTile(
            icon: Icons.info_outline,
            title: 'About App',
            onTap: () => openPage(
              'About App',
              'ShopEase\nVersion 1.0.0',
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(
                  color: Colors.red,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Logout'),
                    content: const Text(
                      'Are you sure you want to logout?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          Get.find<AuthController>().logout();
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// SECTION TITLE

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        top: 4,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// PROFILE TILE

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: const Color(0xff4f65d9),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle == null
            ? null
            : Text(subtitle!),
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }
}

// SETTINGS SCREEN

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool orderUpdates = true;
  bool offers = false;

  Widget settingSwitch(
      String title,
      String subtitle,
      bool value,
      ValueChanged<bool> onChanged,
      ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xff4f65d9),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SectionTitle(
            title: 'Preferences',
          ),

          // DARK MODE

          SwitchListTile(
            secondary: const Icon(
              Icons.dark_mode_outlined,
            ),
            title: const Text('Dark Mode'),
            subtitle: const Text(
              'Change app appearance',
            ),
            value: Get.isDarkMode,
            activeColor: const Color(0xff4f65d9),
            onChanged: (value) {
              Get.changeThemeMode(
                value
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
          ),

          const Divider(),

          // NOTIFICATIONS

          const SectionTitle(
            title: 'Notifications',
          ),

          settingSwitch(
            'All Notifications',
            'Enable or disable notifications',
            notifications,
                (v) {
              setState(() {
                notifications = v;

                if (!v) {
                  orderUpdates = false;
                  offers = false;
                }
              });
            },
          ),

          settingSwitch(
            'Order Updates',
            'Get updates about your orders',
            orderUpdates && notifications,
            notifications
                ? (v) {
              setState(() {
                orderUpdates = v;
              });
            }
                : (v) {},
          ),

          settingSwitch(
            'Offers & Discounts',
            'Receive offers and promotions',
            offers && notifications,
            notifications
                ? (v) {
              setState(() {
                offers = v;
              });
            }
                : (v) {},
          ),

          const Divider(),

          // MORE SETTINGS

          const SectionTitle(
            title: 'More',
          ),

          // LANGUAGE

          ListTile(
            leading: const Icon(
              Icons.language,
            ),
            title: const Text('Language'),
            subtitle: const Text('English'),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: const Text(
                    'Select Language',
                  ),
                  content: const Text(
                    'Language selection can be connected here.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),

          // ACCOUNT INFORMATION

          ListTile(
            leading: const Icon(
              Icons.person_outline,
            ),
            title: const Text(
              'Account Information',
            ),
            subtitle: const Text(
              'View your signed-in account',
            ),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {
              final currentUser =
                  FirebaseAuth.instance.currentUser;

              Get.dialog(
                AlertDialog(
                  title: const Text(
                    'Account Information',
                  ),
                  content: Text(
                    'Name: ${currentUser?.displayName ?? 'Not set'}\n'
                        'Email: ${currentUser?.email ?? 'Not available'}\n'
                        'Phone: ${currentUser?.phoneNumber ?? 'Not set'}',
                  ),
                  actions: [
                    TextButton(
                      onPressed: Get.back,
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),

          // CONTACT SUPPORT

          ListTile(
            leading: const Icon(
              Icons.support_agent_outlined,
            ),
            title: const Text(
              'Contact Support',
            ),
            subtitle: const Text(
              'Get help with your account',
            ),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: const Text(
                    'Help & Support',
                  ),
                  content: const Text(
                    'For help, contact the ShopEase support team. '
                        'Add your support email or phone number here.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: Get.back,
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),

          // CHANGE PASSWORD

          ListTile(
            leading: const Icon(
              Icons.lock_outline,
            ),
            title: const Text(
              'Change Password',
            ),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () async {
              final email =
                  FirebaseAuth.instance.currentUser?.email;

              if (email == null) return;

              try {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(
                  email: email,
                );

                Get.snackbar(
                  'Email sent',
                  'Check your email to reset your password',
                );
              } catch (e) {
                Get.snackbar(
                  'Error',
                  e.toString(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

// SIMPLE FEATURE PAGE

class SimpleFeaturePage extends StatelessWidget {
  final String title;
  final String description;

  const SimpleFeaturePage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}