import 'package:dental_one/l10n/app_localizations.dart';
import 'package:dental_one/res/app_colors/app_colors.dart';
import 'package:dental_one/res/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final String currentSection;
  final VoidCallback? onHomePressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onServicesPressed;
  final VoidCallback? onExpertsPressed;
  final VoidCallback? onBookNowPressed;

  const MyAppBar({
    super.key,
    required this.currentSection,
    this.onHomePressed,
    this.onAboutPressed,
    this.onServicesPressed,
    this.onExpertsPressed,
    this.onBookNowPressed,
  });

  @override
  ConsumerState<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _MyAppBarState extends ConsumerState<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    final currentLocale = ref.watch(languageProvider);
    final selectedLanguage = currentLocale.languageCode == 'en' ? 'English' : 'Arabic';

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // Logo
              const Text(
                'DentalCare',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const Spacer(),

              // Desktop Navigation
              if (MediaQuery.of(context).size.width > 1050) ...[
                _buildNavItem(AppLocalizations.of(context)!.home.toString(), widget.currentSection == 'Home', widget.onHomePressed),
                const SizedBox(width: 40),
                _buildNavItem(AppLocalizations.of(context)!.aboutUs.toString(), widget.currentSection == 'About', widget.onAboutPressed),
                const SizedBox(width: 40),
                _buildNavItem(AppLocalizations.of(context)!.services.toString(), widget.currentSection == 'Services', widget.onServicesPressed),
                const SizedBox(width: 40),
                _buildNavItem(AppLocalizations.of(context)!.ourExperts.toString(), widget.currentSection == 'Our Experts', widget.onExpertsPressed),
                const SizedBox(width: 40),
                _buildBookNowButton(),
                const SizedBox(width: 20),

                // Language Dropdown
                _buildLanguageDropdown(selectedLanguage),
              ] else ...[
                // Mobile Navigation (currently commented out)
                // Builder(
                //   builder: (context) => IconButton(
                //     icon: const Icon(Icons.menu, color: Color(0xFF2D3748), size: 28),
                //     onPressed: () => Scaffold.of(context).openEndDrawer(),
                //   ),
                // ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, bool isActive, VoidCallback? onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? AppColors.primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              color: isActive ? AppColors.primaryColor : const Color(0xFF4A5568),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookNowButton() {
    return InkWell(
      onTap: widget.onBookNowPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A0D6EFD),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          AppLocalizations.of(context)!.bookNow.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown(String selectedLanguage) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLanguage,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primaryColor,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          items: const [
            DropdownMenuItem(
              value: 'English',
              child: Row(
                children: [
                  Icon(Icons.language, color: AppColors.primaryColor, size: 20),
                  SizedBox(width: 10),
                  Text('English'),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Arabic',
              child: Row(
                children: [
                  Icon(Icons.language, color: AppColors.primaryColor, size: 20),
                  SizedBox(width: 10),
                  Text('Arabic'),
                ],
              ),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              final languageCode = value == 'English' ? 'en' : 'ar';
              ref.read(languageProvider.notifier).changeLanguage(languageCode);
            }
          },
        ),
      ),
    );
  }
}