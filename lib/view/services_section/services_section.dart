import 'package:dental_one/res/app_colors/app_colors.dart';
import 'package:dental_one/res/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F9FA),
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(context),
        vertical: Responsive.isMobile(context) ? 60 : 80,
      ),
      child: Column(
        children: [
          // Header Section
          _buildHeaderSection(context),

          SizedBox(height: Responsive.isMobile(context) ? 40 : 60),

          // Service Cards Grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 20 :  Responsive.isTablet(context) ? 10 : 140.0),
            child: _buildServicesGrid(context),
          ),

          SizedBox(height: Responsive.isMobile(context) ? 60 : 80),

          // Footer Section
          _buildFooterSection(context),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Our Dental Services',
          style: GoogleFonts.inter(
            fontSize: Responsive.isMobile(context) ? 32 : (Responsive.isTablet(context) ? 36 : 40),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D3748),
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),

        Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Text(
            'We offer a comprehensive range of dental services to meet all your oral health needs. From routine cleanings to advanced procedures, our expert team is here to help you achieve and maintain optimal dental health.',
            style: GoogleFonts.inter(
              fontSize: Responsive.isMobile(context) ? 16 : 18,
              color: const Color(0xFF718096),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {
        'icon': Icons.favorite_outline,
        'title': 'General Dentistry',
        'description': 'Comprehensive oral health care including cleanings, fillings, and preventive treatments.',
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
        children: services.map((service) =>
            Padding(
              padding: EdgeInsets.only(bottom: Responsive.isMobile(context) ? 18 : 24),
              child: _buildServiceCard(service, context),
            ),
        ).toList(),
      );
    } else if (Responsive.isTablet(context)) {
      return Column(
        children: [
          Row(
            children: services.take(2).map((service) =>
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _buildServiceCard(service, context),
                  ),
                ),
            ).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: services.skip(2).take(2).map((service) =>
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _buildServiceCard(service, context),
                  ),
                ),
            ).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: services.skip(4).take(2).map((service) =>
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _buildServiceCard(service, context),
                  ),
                ),
            ).toList(),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: services.take(3).map((service) =>
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _buildServiceCard(service, context),
                  ),
                ),
            ).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: services.skip(3).take(3).map((service) =>
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _buildServiceCard(service, context),
                  ),
                ),
            ).toList(),
          ),
        ],
      );
    }
  }

  Widget _buildServiceCard(Map<String, dynamic> service, BuildContext context) {
    return _ServiceCard(
      icon: service['icon'] as IconData,
      title: service['title'] as String,
      description: service['description'] as String,
      features: List<String>.from(service['features']),
      context: context,
    );
  }

  Widget _buildFooterSection(BuildContext context) {
    return Container(
      width: Responsive.isMobile(context) ? MediaQuery.of(context).size.width * 0.84 : MediaQuery.of(context).size.width * 0.74,
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 32 : 42),
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
              fontSize: Responsive.isMobile(context) ? 22 : 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D3748),
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: Responsive.isMobile(context) ? 10 : 16),

          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'We offer many additional specialized services. Contact us to discuss your specific dental needs and we\'ll be happy to help you find the right treatment plan.',
              style: GoogleFonts.inter(
                fontSize: Responsive.isMobile(context) ? 14 : 16,
                color: const Color(0xFF718096),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 32),

          ElevatedButton(
            onPressed: () {
              // Handle contact action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3182CE),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 32 : 40,
                vertical: Responsive.isMobile(context) ? 16 : 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Contact Us Today',
              style: GoogleFonts.inter(
                fontSize: Responsive.isMobile(context) ? 14 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for responsive design using your Responsive class
  double _getHorizontalPadding(BuildContext context) {
    if (Responsive.isMobile(context)) return 20;
    if (Responsive.isTablet(context)) return 30;
    return 80;
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        child: Container(
          height: Responsive.isTablet(context) ? 440 : 420,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? Colors.black.withOpacity(0.1) : Colors.black.withOpacity(0.06),
                blurRadius: _isHovered ? 20 : 4,
                spreadRadius: _isHovered ? 1 : 0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(Responsive.isTablet(context) ? 12 : 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF3182CE).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.icon,
                  color: const Color(0xFF3182CE),
                  size: Responsive.isTablet(context) ? 28 : 32,
                ),
              ),

              SizedBox(height: Responsive.isTablet(context) ? 18 : 24),

              // Title
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: Responsive.isMobile(context) ? 17 : Responsive.isTablet(context) ? 20 : 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D3748),
                ),
              ),

              const SizedBox(height: 12),

              // Description
              Text(
                widget.description,
                style: GoogleFonts.inter(
                  fontSize: Responsive.isMobile(context) ? 14 : 15,
                  color: const Color(0xFF718096),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),

              // Features
              ...widget.features.map((feature) =>
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: GoogleFonts.inter(
                              fontSize: Responsive.isMobile(context) ? 12 : 14,
                              color: const Color(0xFF4A5568),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ),

              const Spacer(),

              // Learn More Button
              Container(
                width: double.infinity,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Builder(
                    builder: (context) {
                      bool isButtonHovered = false;
                      return StatefulBuilder(
                        builder: (context, setButtonState) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: isButtonHovered
                                  ? const Color(0xFF2F855A)  // Darker green on hover
                                  : const Color(0xFFFFFFFF), // White background
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // Handle learn more action
                              },
                              onHover: (hovered) {
                                setButtonState(() {
                                  isButtonHovered = hovered;
                                });
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    style: GoogleFonts.inter(
                                      fontSize: Responsive.isMobile(context) ? 14 : 15,
                                      fontWeight: FontWeight.w600,
                                      color: !isButtonHovered ? AppColors.primaryColor : Colors.white,
                                    ),
                                    child: const Text('Learn More'),
                                  ),
                                  const SizedBox(width: 8),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: !isButtonHovered ? AppColors.primaryColor : Colors.white,
                                      size: 18,
                                      key: ValueKey(isButtonHovered),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
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