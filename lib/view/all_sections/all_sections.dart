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
  String _currentSection = 'Home'; // Track current active section

  // Global keys for each section
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _expertsKey = GlobalKey();
  final GlobalKey _bookNowKey = GlobalKey();

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
    // Show floating button when user scrolls down from home section
    if (_scrollController.offset > 200 && !_showFloatingButton) {
      setState(() {
        _showFloatingButton = true;
      });
    } else if (_scrollController.offset <= 200 && _showFloatingButton) {
      setState(() {
        _showFloatingButton = false;
      });
    }

    // Determine current section based on scroll position
    _updateCurrentSection();
  }

  void _updateCurrentSection() {
    final scrollOffset = _scrollController.offset;

    // Get positions of each section
    final homePosition = _getSectionPosition(_homeKey);
    final aboutPosition = _getSectionPosition(_aboutKey);
    final servicesPosition = _getSectionPosition(_servicesKey);
    final expertsPosition = _getSectionPosition(_expertsKey);
    final bookNowPosition = _getSectionPosition(_bookNowKey);

    String newSection = 'Home';

    // Determine which section is currently visible
    // Add some offset to account for app bar height
    final adjustedOffset = scrollOffset + 100;

    if (bookNowPosition != null && adjustedOffset >= bookNowPosition) {
      newSection = 'Book Now';
    } else if (expertsPosition != null && adjustedOffset >= expertsPosition) {
      newSection = 'Our Experts';
    } else if (servicesPosition != null && adjustedOffset >= servicesPosition) {
      newSection = 'Services';
    } else if (aboutPosition != null && adjustedOffset >= aboutPosition) {
      newSection = 'About';
    } else {
      newSection = 'Home';
    }

    if (newSection != _currentSection) {
      setState(() {
        _currentSection = newSection;
      });
    }
  }

  double? _getSectionPosition(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        return position.dy + _scrollController.offset - MediaQuery.of(context).padding.top - 80; // Subtract app bar height
      }
    }
    return null;
  }

  // Method to scroll to a specific section
  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
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
          scrollToSection(_homeKey);
        },
        onAboutPressed: () {
          Navigator.of(context).pop();
          scrollToSection(_aboutKey);
        },
        onServicesPressed: () {
          Navigator.of(context).pop();
          scrollToSection(_servicesKey);
        },
        onExpertsPressed: () {
          Navigator.of(context).pop();
          scrollToSection(_expertsKey);
        },
        onBookNowPressed: () {
          Navigator.of(context).pop();
          scrollToSection(_bookNowKey);
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
        child: Column(
          children: [
            Container(
              key: _homeKey,
              child: const HomeSection(),
            ),
            Container(
              key: _aboutKey,
              child: const AboutSection(), // Simple - no special key needed
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