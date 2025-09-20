import 'package:dental_one/view_model/our_expert_view_model/our_expert_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dental_one/res/responsive/responsive.dart';

class OurExpertSection extends ConsumerStatefulWidget {
  const OurExpertSection({super.key});

  @override
  ConsumerState<OurExpertSection> createState() => _OurExpertSectionState();
}

class _OurExpertSectionState extends ConsumerState<OurExpertSection> {
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
      ref.read(ourExpertAnimationProvider.notifier).triggerSectionVisible();
    }
  }

  @override
  Widget build(BuildContext context) {
    final animationState = ref.watch(ourExpertAnimationProvider);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.valueWhen(context,
          mobile: 20,
          mobileSmall: 16,
          mobileLarge: 24,
          tablet: 10,
          tabletLarge: 10,
          desktop: 180,
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

          SizedBox(height: Responsive.spacing(context, 60,
            mobileSmallMultiplier: 0.7,
            mobileLargeMultiplier: 0.7,
            tabletMultiplier: 1.0,
            tabletLargeMultiplier: 1.0,
            desktopMultiplier: 1.0,
          )),

          // Team Members Section with Animation
          _buildAnimatedTeamMembersSection(context, animationState),

          SizedBox(height: Responsive.spacing(context, 70,
            mobileSmallMultiplier: 0.85,
            mobileLargeMultiplier: 0.85,
            tabletMultiplier: 1.15,
            tabletLargeMultiplier: 1.15,
            desktopMultiplier: 1.15,
          )),

          // Why Choose Our Team Section with Animation
          _buildAnimatedWhyChooseSection(context, animationState),
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
        transform: Matrix4.identity()..translate(0.0, isVisible ? 0.0 : -40.0),
        child: Column(
          children: [
            Text(
              'Meet Our Expert Team',
              style: GoogleFonts.poppins(
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
                'Our team of experienced dental professionals is dedicated to providing you with the highest quality care. Each member brings unique expertise and a shared commitment to your oral health and comfort.',
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

  Widget _buildAnimatedTeamMembersSection(BuildContext context, OurExpertAnimationState animationState) {
    final teamMembers = [
      {
        'name': 'Dr. Sarah Johnson',
        'role': 'Lead Dentist & Clinic Director',
        'experience': '15+ years',
        'image': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
        'description': 'Dr. Johnson is passionate about creating healthy, beautiful smiles with advanced dental care.',
        'education': 'DDS, Harvard School of Dental Medicine',
        'expertise': ['General Dentistry', 'Cosmetic Procedures'],
      },
      {
        'name': 'Dr. Michael Chen',
        'role': 'Orthodontist & Oral Surgeon',
        'experience': '12+ years',
        'image': 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
        'description': 'Specializing in orthodontics and oral surgery, Dr. Chen combines precision with patient comfort in every procedure.',
        'education': 'DDS, University of Pennsylvania',
        'expertise': ['Orthodontics', 'Oral Surgery', 'Implant Dentistry'],
      },
      {
        'name': 'Dr. Emily Rodriguez',
        'role': 'Pediatric Dentist',
        'experience': '8+ years',
        'image': 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80',
        'description': 'Dr. Rodriguez creates a fun, comfortable environment for children while providing exceptional pediatric dental care.',
        'education': 'DDS, UCLA School of Dentistry',
        'expertise': ['Pediatric Dentistry', 'Preventive Care'],
      },
    ];

    if (Responsive.isMobile(context)) {
      return Column(
        children: teamMembers.asMap().entries.map((entry) {
          final index = entry.key;
          final member = entry.value;
          final isVisible = animationState.teamMemberVisibilities.length > index
              ? animationState.teamMemberVisibilities[index]
              : false;

          return Padding(
            padding: EdgeInsets.only(bottom: Responsive.spacing(context, 32)),
            child: _buildAnimatedTeamMemberCard(member, context, isVisible, index),
          );
        }).toList(),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: teamMembers.asMap().entries.map((entry) {
          final index = entry.key;
          final member = entry.value;
          final isVisible = animationState.teamMemberVisibilities.length > index
              ? animationState.teamMemberVisibilities[index]
              : false;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.spacing(context, Responsive.isTablet(context) ? 7 : 12)),
              child: _buildAnimatedTeamMemberCard(member, context, isVisible, index),
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildAnimatedTeamMemberCard(Map<String, dynamic> member, BuildContext context, bool isVisible, int index) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500 + (index * 100)), // Stagger animation
      child: AnimatedContainer(
        duration: Duration(milliseconds: 700 + (index * 100)),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, isVisible ? 0.0 : 60.0),
        child: _TeamMemberCard(
          name: member['name'] as String,
          role: member['role'] as String,
          experience: member['experience'] as String,
          image: member['image'] as String,
          description: member['description'] as String,
          education: member['education'] as String,
          expertise: List<String>.from(member['expertise']),
          context: context,
        ),
      ),
    );
  }

  Widget _buildAnimatedWhyChooseSection(BuildContext context, OurExpertAnimationState animationState) {
    return AnimatedOpacity(
      opacity: animationState.isWhyChooseSectionVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, animationState.isWhyChooseSectionVisible ? 0.0 : 40.0),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(Responsive.valueWhen(context,
            mobile: 30,
            mobileSmall: 24,
            mobileLarge: 32,
            tablet: 34,
            tabletLarge: 36,
            desktop: 40,
          )),
          decoration: BoxDecoration(
            color: const Color(0xFFF7FAFC),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                'Why Choose Our Team?',
                style: GoogleFonts.poppins(
                  fontSize: Responsive.fontSize(context, 30,
                    mobileSmallScale: 0.8,    // 24px
                    mobileLargeScale: 0.85,   // 26px
                    tabletScale: 0.95,        // 28px
                    tabletLargeScale: 1.0,    // 30px
                    desktopScale: 1.0,        // 30px
                  ),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3748),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: Responsive.spacing(context, 36,
                mobileSmallMultiplier: 0.9,
                mobileLargeMultiplier: 0.9,
                tabletMultiplier: 1.1,
                tabletLargeMultiplier: 1.1,
                desktopMultiplier: 1.1,
              )),

              _buildAnimatedWhyChooseFeatures(context, animationState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedWhyChooseFeatures(BuildContext context, OurExpertAnimationState animationState) {
    final features = [
      {
        'icon': Icons.verified_outlined,
        'title': 'Board Certified',
        'description': 'All our dentists are board certified and maintain continuing education',
      },
      {
        'icon': Icons.school_outlined,
        'title': 'Extensive Training',
        'description': 'Graduates from top dental schools with specialized training',
      },
      {
        'icon': Icons.location_on_outlined,
        'title': 'Local Expertise',
        'description': 'Deep understanding of community dental health needs',
      },
    ];

    if (Responsive.isMobile(context)) {
      return Column(
        children: features.asMap().entries.map((entry) {
          final index = entry.key;
          final feature = entry.value;
          final isVisible = animationState.featureVisibilities.length > index
              ? animationState.featureVisibilities[index]
              : false;

          return Padding(
            padding: EdgeInsets.only(bottom: Responsive.spacing(context, 20)),
            child: _buildAnimatedFeatureCard(feature, context, isVisible, index),
          );
        }).toList(),
      );
    } else {
      return Row(
        children: features.asMap().entries.map((entry) {
          final index = entry.key;
          final feature = entry.value;
          final isVisible = animationState.featureVisibilities.length > index
              ? animationState.featureVisibilities[index]
              : false;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.spacing(context, 12)),
              child: _buildAnimatedFeatureCard(feature, context, isVisible, index),
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildAnimatedFeatureCard(Map<String, dynamic> feature, BuildContext context, bool isVisible, int index) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 400 + (index * 100)), // Stagger animation
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600 + (index * 100)),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, isVisible ? 0.0 : 30.0),
        child: Container(
          padding: EdgeInsets.all(Responsive.spacing(context, 24)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.spacing(context, 16)),
                decoration: BoxDecoration(
                  color: const Color(0xFF3182CE).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: const Color(0xFF3182CE),
                  size: Responsive.valueWhen(context,
                    mobile: 32,
                    mobileSmall: 28,
                    mobileLarge: 32,
                    tablet: 34,
                    tabletLarge: 36,
                    desktop: 38,
                  ),
                ),
              ),

              SizedBox(height: Responsive.spacing(context, 16)),

              Text(
                feature['title'] as String,
                style: GoogleFonts.inter(
                  fontSize: Responsive.fontSize(context, 20,
                    mobileSmallScale: 0.9,    // 18px
                    mobileLargeScale: 0.95,   // 19px
                    tabletScale: 1.0,         // 20px
                    tabletLargeScale: 1.0,    // 20px
                    desktopScale: 1.05,       // 21px
                  ),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D3748),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: Responsive.spacing(context, 8)),

              Text(
                feature['description'] as String,
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
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamMemberCard extends StatefulWidget {
  final String name;
  final String role;
  final String experience;
  final String image;
  final String description;
  final String education;
  final List<String> expertise;
  final BuildContext context;

  const _TeamMemberCard({
    required this.name,
    required this.role,
    required this.experience,
    required this.image,
    required this.description,
    required this.education,
    required this.expertise,
    required this.context,
  });

  @override
  State<_TeamMemberCard> createState() => _TeamMemberCardState();
}

class _TeamMemberCardState extends State<_TeamMemberCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Only enable hover effects on non-mobile devices
    final enableHover = !Responsive.isMobile(context);

    return MouseRegion(
      onEnter: enableHover ? (_) => setState(() => _isHovered = true) : null,
      onExit: enableHover ? (_) => setState(() => _isHovered = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(_isHovered && enableHover ? 1.02 : 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _isHovered && enableHover
                    ? Colors.black.withOpacity(0.15)
                    : Colors.black.withOpacity(0.08),
                blurRadius: _isHovered && enableHover ? 25 : 15,
                spreadRadius: 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with experience badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      height: Responsive.valueWhen(context,
                        mobile: 280,
                        mobileSmall: 250,
                        mobileLarge: 280,
                        tablet: 280,
                        tabletLarge: 300,
                        desktop: 320,
                      ),
                      width: double.infinity,
                      child: AnimatedScale(
                        scale: _isHovered && enableHover ? 1.15 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFF7FAFC),
                              child: Icon(
                                Icons.person,
                                size: Responsive.valueWhen(context,
                                  mobile: 80,
                                  mobileSmall: 70,
                                  mobileLarge: 80,
                                  tablet: 85,
                                  tabletLarge: 90,
                                  desktop: 95,
                                ),
                                color: const Color(0xFF718096),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Experience badge
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.spacing(context, 12),
                        vertical: Responsive.spacing(context, 6),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3182CE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.experience,
                        style: GoogleFonts.inter(
                          fontSize: Responsive.fontSize(context, 12,
                            mobileSmallScale: 0.9,
                            mobileLargeScale: 1.0,
                            tabletScale: 1.0,
                            tabletLargeScale: 1.1,
                            desktopScale: 1.1,
                          ),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(Responsive.spacing(context, Responsive.isTablet(context) ? 12 : 24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      widget.name,
                      style: GoogleFonts.inter(
                        fontSize: Responsive.fontSize(context, 22,
                          mobileSmallScale: 0.9,    // 20px
                          mobileLargeScale: 0.95,   // 21px
                          tabletScale: 1.0,         // 22px
                          tabletLargeScale: 1.0,    // 22px
                          desktopScale: 1.05,       // 23px
                        ),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2D3748),
                      ),
                    ),

                    SizedBox(height: Responsive.spacing(context, 4)),

                    // Role
                    Text(
                      widget.role,
                      style: GoogleFonts.inter(
                        fontSize: Responsive.fontSize(context, 16,
                          mobileSmallScale: 0.85,   // 14px
                          mobileLargeScale: 0.95,   // 15px
                          tabletScale: 1.0,         // 16px
                          tabletLargeScale: 1.0,    // 16px
                          desktopScale: 1.05,       // 17px
                        ),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3182CE),
                      ),
                    ),

                    SizedBox(height: Responsive.spacing(context, 16)),

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

                    SizedBox(height: Responsive.spacing(context, 16)),

                    // Education
                    Row(
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: Responsive.valueWhen(context,
                            mobile: 16,
                            mobileSmall: 14,
                            mobileLarge: 16,
                            tablet: 16,
                            tabletLarge: 17,
                            desktop: 18,
                          ),
                          color: const Color(0xFF718096),
                        ),
                        SizedBox(width: Responsive.spacing(context, 8)),
                        Expanded(
                          child: Text(
                            widget.education,
                            style: GoogleFonts.inter(
                              fontSize: Responsive.fontSize(context, 13,
                                mobileSmallScale: 0.9,    // 12px
                                mobileLargeScale: 0.95,   // 12px
                                tabletScale: 1.0,         // 13px
                                tabletLargeScale: 1.05,   // 14px
                                desktopScale: 1.1,        // 14px
                              ),
                              color: const Color(0xFF718096),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: Responsive.spacing(context, 16)),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}