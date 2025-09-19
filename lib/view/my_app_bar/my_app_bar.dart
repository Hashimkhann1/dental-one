import 'package:dental_one/res/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
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
  Widget build(BuildContext context) {
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
              if (MediaQuery.of(context).size.width > 768) ...[
                _buildNavItem('Home', currentSection == 'Home', onHomePressed),
                const SizedBox(width: 40),
                _buildNavItem('About', currentSection == 'About', onAboutPressed),
                const SizedBox(width: 40),
                _buildNavItem('Services', currentSection == 'Services', onServicesPressed),
                const SizedBox(width: 40),
                _buildNavItem('Our Experts', currentSection == 'Our Experts', onExpertsPressed),
                const SizedBox(width: 40),
                _buildBookNowButton(),
              ] else ...[
                // Mobile Navigation
                // Builder(
                //   builder: (context) => IconButton(
                //     icon: const Icon(
                //       Icons.menu,
                //       color: Color(0xFF2D3748),
                //       size: 28,
                //     ),
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
      onTap: onBookNowPressed,
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
        child: const Text(
          'Book Now',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

// Mobile Drawer
class MobileDrawer extends StatelessWidget {
  final String currentSection;
  final VoidCallback? onHomePressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onServicesPressed;
  final VoidCallback? onExpertsPressed;
  final VoidCallback? onBookNowPressed;

  const MobileDrawer({
    super.key,
    required this.currentSection,
    this.onHomePressed,
    this.onAboutPressed,
    this.onServicesPressed,
    this.onExpertsPressed,
    this.onBookNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FAFC),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.05),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.local_hospital,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'DentalCare',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Navigation Items
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildMobileNavItem('Home', Icons.home_outlined, Icons.home, currentSection == 'Home', onHomePressed),
                      _buildMobileNavItem('About', Icons.info_outline, Icons.info, currentSection == 'About', onAboutPressed),
                      _buildMobileNavItem('Services', Icons.medical_services_outlined, Icons.medical_services, currentSection == 'Services', onServicesPressed),
                      _buildMobileNavItem('Our Experts', Icons.people_outline, Icons.people, currentSection == 'Our Experts', onExpertsPressed),

                      const SizedBox(height: 30),

                      // Book Now Button
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: ElevatedButton(
                          onPressed: onBookNowPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 8,
                            shadowColor: AppColors.primaryColor.withOpacity(0.4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.calendar_today, size: 20),
                              const SizedBox(width: 12),
                              const Text(
                                'Book Appointment',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Footer
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Emergency Contact',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF64748B),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '+1 (555) 123-4567',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(String title, IconData outlineIcon, IconData filledIcon, bool isActive, VoidCallback? onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isActive ? AppColors.primaryColor.withOpacity(0.2) : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isActive ? filledIcon : outlineIcon,
                    key: ValueKey(isActive),
                    color: isActive ? AppColors.primaryColor : const Color(0xFF64748B),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive ? AppColors.primaryColor : const Color(0xFF374151),
                    ),
                  ),
                ),
                if (isActive)
                  AnimatedScale(
                    scale: 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
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
}