import 'package:dental_one/res/app_colors/app_colors.dart';
import 'package:dental_one/view/about_section/about_section.dart';
import 'package:dental_one/view/book_now_section/book_now_section.dart';
import 'package:dental_one/view/footer_section/footer_section.dart';
import 'package:dental_one/view/home_section/home_section.dart';
import 'package:dental_one/view/location_section/location_section.dart';
import 'package:dental_one/view/my_app_bar/my_app_bar.dart';
import 'package:dental_one/view/our_experte_section/our_experte_section.dart';
import 'package:dental_one/view/services_section/services_section.dart';
import 'package:flutter/material.dart';

class AllSections extends StatefulWidget {
  const AllSections({super.key});

  @override
  State<AllSections> createState() => _AllSectionsState();
}

class _AllSectionsState extends State<AllSections> {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingButton = false;
  String _currentSection = 'Home';

  // Global keys for each section
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _expertsKey = GlobalKey();
  final GlobalKey _bookNowKey = GlobalKey();

  // Track section positions to avoid repeated calculations
  final Map<String, double> _sectionPositions = {};
  bool _isCalculatingPositions = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!mounted || _isCalculatingPositions) return;

    // Show floating button when user scrolls down from home section
    if (_scrollController.offset > 200 && !_showFloatingButton) {
      if (mounted) {
        setState(() {
          _showFloatingButton = true;
        });
      }
    } else if (_scrollController.offset <= 200 && _showFloatingButton) {
      if (mounted) {
        setState(() {
          _showFloatingButton = false;
        });
      }
    }

    // Use a debounced approach for section updates
    _debouncedUpdateCurrentSection();
  }

  void _debouncedUpdateCurrentSection() {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted && !_isCalculatingPositions) {
        _updateCurrentSection();
      }
    });
  }

  void _updateCurrentSection() {
    if (!mounted || !_scrollController.hasClients || _isCalculatingPositions) return;

    _isCalculatingPositions = true;

    try {
      final scrollOffset = _scrollController.offset;

      // Calculate positions only when needed
      _calculateSectionPositions();

      String newSection = _determineSectionFromOffset(scrollOffset);

      if (newSection != _currentSection && mounted) {
        setState(() {
          _currentSection = newSection;
        });
      }
    } catch (e) {
      // Handle any errors silently
      debugPrint('Error updating current section: $e');
    } finally {
      _isCalculatingPositions = false;
    }
  }

  void _calculateSectionPositions() {
    _sectionPositions.clear();

    final sections = [
      ('Home', _homeKey),
      ('About', _aboutKey),
      ('Services', _servicesKey),
      ('Our Experts', _expertsKey),
      ('Book Now', _bookNowKey),
    ];

    for (final (name, key) in sections) {
      final position = _getSectionPositionSafely(key);
      if (position != null) {
        _sectionPositions[name] = position;
      }
    }
  }

  String _determineSectionFromOffset(double scrollOffset) {
    if (_sectionPositions.isEmpty) return _currentSection;

    final screenHeight = MediaQuery.of(context).size.height;
    final viewportCenter = scrollOffset + (screenHeight / 2);

    // Sort sections by position
    final sortedSections = _sectionPositions.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    // Find the current section based on viewport center
    String currentSection = 'Home';
    for (final entry in sortedSections) {
      if (viewportCenter >= entry.value) {
        currentSection = entry.key;
      } else {
        break;
      }
    }

    return currentSection;
  }

  double? _getSectionPositionSafely(GlobalKey key) {
    if (!mounted) return null;

    try {
      final context = key.currentContext;
      if (context == null) return null;

      // More robust element checking
      final element = context as Element;
      if (!element.mounted) return null;

      final renderObject = element.renderObject;
      if (renderObject == null) return null;

      final renderBox = renderObject as RenderBox?;
      if (renderBox == null || !renderBox.hasSize || !renderBox.attached) {
        return null;
      }

      final position = renderBox.localToGlobal(Offset.zero);
      return position.dy + _scrollController.offset -
          MediaQuery.of(context).padding.top - 80;

    } catch (e) {
      // Return null for any error
      return null;
    }
  }

  // Simplified scroll to section method
  void scrollToSection(GlobalKey key) {
    if (!mounted) return;

    // Use a more reliable approach
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final context = key.currentContext;
      if (context == null) return;

      try {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
          alignment: 0.0, // Align to top
        );
      } catch (e) {
        debugPrint('Scroll to section failed: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: MyAppBar(
        currentSection: _currentSection,
        onHomePressed: () => scrollToSection(_homeKey),
        onAboutPressed: () => scrollToSection(_aboutKey),
        onServicesPressed: () => scrollToSection(_servicesKey),
        onExpertsPressed: () => scrollToSection(_expertsKey),
        onBookNowPressed: () => scrollToSection(_bookNowKey),
      ),
      endDrawer: MediaQuery.of(context).size.width <= 768
          ? MobileDrawer(
        currentSection: _currentSection,
        onHomePressed: () {
          Navigator.of(context).pop();
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) scrollToSection(_homeKey);
          });
        },
        onAboutPressed: () {
          Navigator.of(context).pop();
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) scrollToSection(_aboutKey);
          });
        },
        onServicesPressed: () {
          Navigator.of(context).pop();
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) scrollToSection(_servicesKey);
          });
        },
        onExpertsPressed: () {
          Navigator.of(context).pop();
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) scrollToSection(_expertsKey);
          });
        },
        onBookNowPressed: () {
          Navigator.of(context).pop();
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) scrollToSection(_bookNowKey);
          });
        },
      )
          : null,
      floatingActionButton: AnimatedOpacity(
        opacity: _showFloatingButton ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: _showFloatingButton
            ? FloatingActionButton(
          onPressed: () => scrollToSection(_homeKey),
          backgroundColor: AppColors.primaryColor,
          elevation: 6,
          child: const Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white,
            size: 28,
          ),
        )
            : const SizedBox.shrink(),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              key: _homeKey,
              child: const HomeSection(),
            ),
            Container(
              key: _aboutKey,
              child: const AboutSection(),
            ),
            Container(
              key: _servicesKey,
              child: const ServicesSection(),
            ),
            Container(
              key: _expertsKey,
              child: const OurExpertSection(),
            ),
            Container(
              key: _bookNowKey,
              child: const BookNowSection(),
            ),
            const LocationSection(),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}

// Mobile Drawer Widget
class MobileDrawer extends StatelessWidget {
  final String currentSection;
  final VoidCallback onHomePressed;
  final VoidCallback onAboutPressed;
  final VoidCallback onServicesPressed;
  final VoidCallback onExpertsPressed;
  final VoidCallback onBookNowPressed;

  const MobileDrawer({
    super.key,
    required this.currentSection,
    required this.onHomePressed,
    required this.onAboutPressed,
    required this.onServicesPressed,
    required this.onExpertsPressed,
    required this.onBookNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_hospital,
                    color: AppColors.primaryColor,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'DentalCare',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  _buildDrawerItem(
                    context,
                    'Home',
                    Icons.home_outlined,
                    currentSection == 'Home',
                    onHomePressed,
                  ),
                  _buildDrawerItem(
                    context,
                    'About',
                    Icons.info_outline,
                    currentSection == 'About',
                    onAboutPressed,
                  ),
                  _buildDrawerItem(
                    context,
                    'Services',
                    Icons.medical_services_outlined,
                    currentSection == 'Services',
                    onServicesPressed,
                  ),
                  _buildDrawerItem(
                    context,
                    'Our Experts',
                    Icons.people_outline,
                    currentSection == 'Our Experts',
                    onExpertsPressed,
                  ),
                  _buildDrawerItem(
                    context,
                    'Book Now',
                    Icons.calendar_today_outlined,
                    currentSection == 'Book Now',
                    onBookNowPressed,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                '© 2024 DentalCare',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context,
      String title,
      IconData icon,
      bool isActive,
      VoidCallback onTap,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? AppColors.primaryColor : Colors.grey[600],
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.primaryColor : Colors.grey[800],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            fontSize: 16,
          ),
        ),
        selected: isActive,
        selectedTileColor: AppColors.primaryColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: onTap,
      ),
    );
  }
}