import 'package:dental_one/res/app_colors/app_colors.dart';
import 'package:dental_one/res/responsive/responsive.dart';
import 'package:dental_one/view_model/service_view_model/service_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesSection extends ConsumerStatefulWidget {
  const ServicesSection({super.key});

  @override
  ConsumerState<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends ConsumerState<ServicesSection> {
  late ScrollController _scrollController;
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    // Find the nearest ScrollController from the widget tree
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController = Scrollable.of(context).widget.controller ?? ScrollController();
      _scrollController.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_hasTriggered) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;

    // Trigger animation when section is 20% visible from bottom
    if (position.dy < screenHeight * 0.8) {
      _hasTriggered = true;
      ref.read(servicesAnimationProvider.notifier).triggerSectionVisible();
    }
  }

  @override
  Widget build(BuildContext context) {
    final animationState = ref.watch(servicesAnimationProvider);

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F9FA),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.valueWhen(context,
          mobile: 20,
          mobileSmall: 16,
          mobileLarge: 24,
          tablet: 24,
          tabletLarge: 50,
          desktop: 80,
        ),
        vertical: Responsive.valueWhen(context,
          mobile: 60,
          mobileSmall: 50,
          mobileLarge: 60,
          tablet: 80,
          tabletLarge: 80,
          desktop: 80,
        ),
      ),
      child: Column(
        children: [
          // Header Section with Animation
          _buildAnimatedHeaderSection(context, animationState.isHeaderVisible),

          SizedBox(height: Responsive.spacing(context, 50,
            mobileSmallMultiplier: 0.8,
            mobileLargeMultiplier: 0.8,
            tabletMultiplier: 1.2,
            tabletLargeMultiplier: 1.2,
            desktopMultiplier: 1.2,
          )),

          // Service Cards Grid with Animation
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.valueWhen(context,
                mobile: 20,
                mobileSmall: 16,
                mobileLarge: 20,
                tablet: 4,
                tabletLarge: 30,
                desktop: 140,
              ),
            ),
            child: _buildAnimatedServicesGrid(context, animationState),
          ),

          SizedBox(height: Responsive.spacing(context, 70,
            mobileSmallMultiplier: 0.85,
            mobileLargeMultiplier: 0.85,
            tabletMultiplier: 1.15,
            tabletLargeMultiplier: 1.15,
            desktopMultiplier: 1.15,
          )),

          // Footer Section with Animation
          _buildAnimatedFooterSection(context, animationState.isFooterVisible),
        ],
      ),
    );
  }

  Widget _buildAnimatedHeaderSection(BuildContext context, bool isVisible) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, isVisible ? 0.0 : -30.0),
        child: Column(
          children: [
            Text(
              'Our Dental Services',
              style: GoogleFonts.inter(
                fontSize: Responsive.fontSize(context, 40,
                  mobileSmallScale: 0.8,    // 32px
                  mobileLargeScale: 0.85,   // 34px
                  tabletScale: 0.9,         // 36px
                  tabletLargeScale: 0.95,   // 38px
                  desktopScale: 1.0,        // 40px
                ),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: Responsive.spacing(context, 16)),

            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text(
                'We offer a comprehensive range of dental services to meet all your oral health needs. From routine cleanings to advanced procedures, our expert team is here to help you achieve and maintain optimal dental health.',
                style: GoogleFonts.inter(
                  fontSize: Responsive.fontSize(context, 18,
                    mobileSmallScale: 0.85,   // 15px
                    mobileLargeScale: 0.9,    // 16px
                    tabletScale: 1.0,         // 18px
                    tabletLargeScale: 1.0,    // 18px
                    desktopScale: 1.0,        // 18px
                  ),
                  color: const Color(0xFF718096),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedServicesGrid(BuildContext context, ServicesAnimationState animationState) {
    final services = [
      {
        'icon': Icons.favorite_outline,
        'title': 'General Dentistry',
        'description': 'Complete oral care with cleanings, fillings, and preventive treatments.',
        'features': ['Regular Cleanings', 'Cavity Fillings', 'Oral Exams', 'Fluoride Treatments'],
      },
      {
        'icon': Icons.auto_awesome,
        'title': 'Cosmetic Dentistry',
        'description': 'Enhance your smile with our advanced cosmetic dental procedures.',
        'features': ['Teeth Whitening', 'Veneers', 'Bonding', 'Smile Makeovers'],
      },
      {
        'icon': Icons.straighten,
        'title': 'Orthodontics',
        'description': 'Straighten your teeth with traditional braces or modern clear aligners.',
        'features': ['Metal Braces', 'Clear Aligners', 'Retainers', 'Bite Correction'],
      },
      {
        'icon': Icons.local_hospital_outlined,
        'title': 'Emergency Care',
        'description': 'Immediate dental care for urgent situations and dental emergencies.',
        'features': ['24/7 Availability', 'Pain Relief', 'Urgent Repairs', 'Same-Day Treatment'],
      },
      {
        'icon': Icons.medical_services_outlined,
        'title': 'Oral Surgery',
        'description': 'Expert surgical procedures performed with precision and care.',
        'features': ['Tooth Extractions', 'Wisdom Teeth', 'Implant Surgery', 'Gum Surgery'],
      },
      {
        'icon': Icons.child_care,
        'title': 'Pediatric Dentistry',
        'description': 'Specialized dental care designed specifically for children and teens.',
        'features': ['Kid-Friendly Environment', 'Preventive Care', 'Sealants', 'Education'],
      },
    ];

    if (Responsive.isMobile(context)) {
      return Column(
        children: services.asMap().entries.map((entry) {
          final index = entry.key;
          final service = entry.value;
          final isVisible = animationState.cardVisibilities.length > index
              ? animationState.cardVisibilities[index]
              : false;

          return Padding(
            padding: EdgeInsets.only(bottom: Responsive.spacing(context, 20)),
            child: _buildAnimatedServiceCard(service, context, isVisible, index),
          );
        }).toList(),
      );
    } else {
      // Use LayoutBuilder for better responsive handling
      return LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = Responsive.valueWhen(context,
            mobile: 1,
            tablet: 3,
            tabletLarge: 3,
            desktop: 3,
          );

          final spacing = Responsive.spacing(context, 20);
          final availableWidth = constraints.maxWidth;
          final totalSpacing = spacing * (crossAxisCount - 1);
          final cardWidth = (availableWidth - totalSpacing) / crossAxisCount;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: services.asMap().entries.map((entry) {
              final index = entry.key;
              final service = entry.value;
              final isVisible = animationState.cardVisibilities.length > index
                  ? animationState.cardVisibilities[index]
                  : false;

              return SizedBox(
                width: cardWidth,
                child: _buildAnimatedServiceCard(service, context, isVisible, index),
              );
            }).toList(),
          );
        },
      );
    }
  }

  Widget _buildAnimatedServiceCard(Map<String, dynamic> service, BuildContext context, bool isVisible, int index) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 400 + (index * 100)), // Stagger animation
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600 + (index * 100)),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, isVisible ? 0.0 : 50.0),
        child: _ServiceCard(
          icon: service['icon'] as IconData,
          title: service['title'] as String,
          description: service['description'] as String,
          features: List<String>.from(service['features']),
          context: context,
        ),
      ),
    );
  }

  Widget _buildAnimatedFooterSection(BuildContext context, bool isVisible) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, isVisible ? 0.0 : 30.0),
        child: Container(
          width: Responsive.valueWhen(context,
            mobile: MediaQuery.of(context).size.width * 0.84,
            mobileSmall: MediaQuery.of(context).size.width * 0.9,
            mobileLarge: MediaQuery.of(context).size.width * 0.82,
            tablet: MediaQuery.of(context).size.width * 0.92,
            tabletLarge: MediaQuery.of(context).size.width * 0.9,
            desktop: MediaQuery.of(context).size.width * 0.74,
          ),
          padding: EdgeInsets.all(Responsive.valueWhen(context,
            mobile: 32,
            mobileSmall: 24,
            mobileLarge: 36,
            tablet: 38,
            tabletLarge: 40,
            desktop: 42,
          )),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "Don't See What You Need?",
                style: GoogleFonts.inter(
                  fontSize: Responsive.fontSize(context, 28,
                    mobileSmallScale: 0.75,   // 21px
                    mobileLargeScale: 0.8,    // 22px
                    tabletScale: 0.9,         // 25px
                    tabletLargeScale: 0.95,   // 27px
                    desktopScale: 1.0,        // 28px
                  ),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3748),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: Responsive.spacing(context, 13,
                mobileSmallMultiplier: 0.8,
                mobileLargeMultiplier: 0.8,
                tabletMultiplier: 1.2,
                tabletLargeMultiplier: 1.2,
                desktopMultiplier: 1.2,
              )),

              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  'We offer many additional specialized services. Contact us to discuss your specific dental needs and we\'ll be happy to help you find the right treatment plan.',
                  style: GoogleFonts.inter(
                    fontSize: Responsive.fontSize(context, 16,
                      mobileSmallScale: 0.85,   // 14px
                      mobileLargeScale: 0.9,    // 14px
                      tabletScale: 1.0,         // 16px
                      tabletLargeScale: 1.0,    // 16px
                      desktopScale: 1.0,        // 16px
                    ),
                    color: const Color(0xFF718096),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: Responsive.spacing(context, 32)),

              ElevatedButton(
                onPressed: () {
                  // Handle contact action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3182CE),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.valueWhen(context,
                      mobile: 32,
                      mobileSmall: 28,
                      mobileLarge: 34,
                      tablet: 36,
                      tabletLarge: 38,
                      desktop: 40,
                    ),
                    vertical: Responsive.valueWhen(context,
                      mobile: 16,
                      mobileSmall: 14,
                      mobileLarge: 16,
                      tablet: 17,
                      tabletLarge: 17,
                      desktop: 18,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Contact Us Today',
                  style: GoogleFonts.inter(
                    fontSize: Responsive.fontSize(context, 16,
                      mobileSmallScale: 0.85,   // 14px
                      mobileLargeScale: 0.9,    // 14px
                      tabletScale: 0.95,        // 15px
                      tabletLargeScale: 1.0,    // 16px
                      desktopScale: 1.0,        // 16px
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String> features;
  final BuildContext context;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
    required this.context,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;
  bool _isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    // Only enable hover effects on non-mobile devices
    final enableHover = !Responsive.isMobile(context);

    return MouseRegion(
      onEnter: enableHover ? (_) => setState(() => _isHovered = true) : null,
      onExit: enableHover ? (_) => setState(() => _isHovered = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered && enableHover ? 1.02 : 1.0),
        child: Container(
          padding: EdgeInsets.all(Responsive.valueWhen(context,
            mobile: 26,
            mobileSmall: 20,
            mobileLarge: 27,
            tablet: 12,
            tabletLarge: 22,
            desktop: 32,
          )),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _isHovered && enableHover
                    ? Colors.black.withOpacity(0.1)
                    : Colors.black.withOpacity(0.06),
                blurRadius: _isHovered && enableHover ? 20 : 4,
                spreadRadius: _isHovered && enableHover ? 1 : 0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(Responsive.valueWhen(context,
                  mobile: 16,
                  mobileSmall: 14,
                  mobileLarge: 16,
                  tablet: 12,
                  tabletLarge: 14,
                  desktop: 16,
                )),
                decoration: BoxDecoration(
                  color: const Color(0xFF3182CE).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.icon,
                  color: const Color(0xFF3182CE),
                  size: Responsive.valueWhen(context,
                    mobile: 32,
                    mobileSmall: 28,
                    mobileLarge: 32,
                    tablet: 28,
                    tabletLarge: 30,
                    desktop: 32,
                  ),
                ),
              ),

              SizedBox(height: Responsive.spacing(context, 22,
                tabletMultiplier: 0.8,
                tabletLargeMultiplier: 0.9,
              )),

              // Title
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: Responsive.fontSize(context, 22,
                    mobileSmallScale: 0.75,   // 17px
                    mobileLargeScale: 0.8,    // 18px
                    tabletScale: 0.9,         // 20px
                    tabletLargeScale: 0.95,   // 21px
                    desktopScale: 1.0,        // 22px
                  ),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D3748),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: Responsive.spacing(context, 12)),

              // Description
              Text(
                widget.description,
                style: GoogleFonts.inter(
                  fontSize: Responsive.fontSize(context, 15,
                    mobileSmallScale: 0.9,    // 14px
                    mobileLargeScale: 0.95,   // 14px
                    tabletScale: 1.0,         // 15px
                    tabletLargeScale: 1.0,    // 15px
                    desktopScale: 1.05,       // 16px
                  ),
                  color: const Color(0xFF718096),
                  height: 1.5,
                ),
              ),

              SizedBox(height: Responsive.spacing(context, 20)),

              // Features
              ...widget.features.map((feature) =>
                  Padding(
                    padding: EdgeInsets.only(bottom: Responsive.spacing(context, 8)),
                    child: Row(
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3182CE),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: Responsive.spacing(context, 12)),
                        Flexible(
                          child: Text(
                            feature,
                            style: GoogleFonts.inter(
                              fontSize: Responsive.fontSize(context, 14,
                                mobileSmallScale: 0.85,   // 12px
                                mobileLargeScale: 0.9,    // 13px
                                tabletScale: 1.0,         // 14px
                                tabletLargeScale: 1.0,    // 14px
                                desktopScale: 1.05,       // 15px
                              ),
                              color: const Color(0xFF4A5568),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ),

              SizedBox(height: Responsive.spacing(context, 24)),

              // Learn More Button
              Container(
                width: double.infinity,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: enableHover ? (_) => setState(() => _isButtonHovered = true) : null,
                  onExit: enableHover ? (_) => setState(() => _isButtonHovered = false) : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: _isButtonHovered && enableHover
                          ? const Color(0xFF2F855A)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Handle learn more action
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: Responsive.spacing(context, 12)),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Learn More',
                            style: GoogleFonts.inter(
                              fontSize: Responsive.fontSize(context, 15,
                                mobileSmallScale: 0.9,    // 14px
                                mobileLargeScale: 0.95,   // 14px
                                tabletScale: 1.0,         // 15px
                                tabletLargeScale: 1.0,    // 15px
                                desktopScale: 1.05,       // 16px
                              ),
                              fontWeight: FontWeight.w600,
                              color: _isButtonHovered && enableHover
                                  ? Colors.white
                                  : AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(width: Responsive.spacing(context, 8)),
                          Icon(
                            Icons.arrow_forward,
                            color: _isButtonHovered && enableHover
                                ? Colors.white
                                : AppColors.primaryColor,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}