import 'package:dental_one/l10n/app_localizations.dart';
import 'package:dental_one/res/app_colors/app_colors.dart';
import 'package:dental_one/res/responsive/responsive.dart';
import 'package:dental_one/view_model/about_view_model/about_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSection extends ConsumerStatefulWidget {
  const AboutSection({super.key});

  @override
  ConsumerState<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends ConsumerState<AboutSection> {
  bool _hasAnimated = false;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupScrollListener();
    });
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _setupScrollListener() {
    try {
      final scrollableState = Scrollable.maybeOf(context);
      if (scrollableState != null) {
        _scrollController = scrollableState.widget.controller;
        _scrollController?.addListener(_onScroll);
      }
    } catch (e) {}
  }

  void _onScroll() {
    if (_hasAnimated || !mounted) return;

    try {
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) return;

      final size = renderBox.size;
      final position = renderBox.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;

      final visibleTop = position.dy < screenHeight ? position.dy : screenHeight;
      final visibleBottom = position.dy + size.height > 0 ? position.dy + size.height : 0;

      if (visibleTop < screenHeight && visibleBottom > 0) {
        final visibleHeight = (visibleBottom - visibleTop).clamp(0.0, size.height);
        final visibilityFraction = visibleHeight / size.height;

        if (visibilityFraction >= 0.3) {
          _triggerAnimations();
        }
      }
    } catch (e) {}
  }

  void _triggerAnimations() {
    if (!_hasAnimated && mounted) {
      setState(() {
        _hasAnimated = true;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(aboutAnimationProvider.notifier).triggerAnimations();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final animationState = ref.watch(aboutAnimationProvider);
    final loc = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.valueWhen(
          context,
          mobile: 20,
          mobileSmall: 16,
          mobileLarge: 24,
          tablet: 40,
          desktop: MediaQuery.of(context).size.width < 1440
              ? MediaQuery.of(context).size.width * 0.03
              : MediaQuery.of(context).size.width * 0.11,
        ),
        vertical: Responsive.valueWhen(
          context,
          mobile: 60,
          mobileSmall: 50,
          mobileLarge: 60,
          tablet: 80,
          desktop: 80,
        ),
      ),
      child: Column(
        children: [
          _buildTopSection(context, animationState, loc),
          SizedBox(height: Responsive.spacing(context, 60)),
          _buildFeaturesSection(context, animationState, loc),
          SizedBox(height: Responsive.spacing(context, 60)),
          _buildMissionSection(context, animationState, loc),
        ],
      ),
    );
  }

  Widget _buildTopSection(BuildContext context, AboutAnimationState animationState, AppLocalizations loc) {
    return Column(
      children: [
        FadeInSlideUp(
          isVisible: animationState.isTitleVisible,
          duration: const Duration(milliseconds: 800),
          child: Text(
            loc.aboutTitle,
            style: GoogleFonts.poppins(
              fontSize: Responsive.fontSize(context, 36,
                  mobileSmallScale: 0.7,
                  mobileLargeScale: 0.85,
                  tabletScale: 0.95,
                  desktopScale: 1.0),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D3748),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 24)),
        FadeInSlideUp(
          isVisible: animationState.isDescriptionVisible,
          duration: const Duration(milliseconds: 700),
          slideDistance: 20.0,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 840),
            child: Text(
              loc.aboutDescription,
              style: GoogleFonts.poppins(
                fontSize: Responsive.fontSize(context, 16,
                    mobileSmallScale: 0.9,
                    mobileLargeScale: 1.0,
                    tabletScale: 1.05,
                    desktopScale: 1.1),
                color: Colors.black.withOpacity(0.6),
                height: 1.6,
              ),
              textAlign: Responsive.isMobile(context) ? TextAlign.start : TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(BuildContext context, AboutAnimationState animationState, AppLocalizations loc) {
    final features = [
      {
        'icon': Icons.favorite_outline,
        'title': loc.featurePatientCareTitle,
        'subtitle': loc.featurePatientCareSubtitle,
      },
      {
        'icon': Icons.star_outline,
        'title': loc.featureExcellenceTitle,
        'subtitle': loc.featureExcellenceSubtitle,
      },
      {
        'icon': Icons.people_outline,
        'title': loc.featureExperiencedTeamTitle,
        'subtitle': loc.featureExperiencedTeamSubtitle,
      },
      {
        'icon': Icons.schedule_outlined,
        'title': loc.featureSchedulingTitle,
        'subtitle': loc.featureSchedulingSubtitle,
      },
    ];

    final cardHeight = Responsive.valueWhen(
      context,
      mobile: 240.0,
      mobileSmall: 220.0,
      mobileLarge: 250.0,
      tablet: 230.0,
      tabletLarge: 240.0,
      desktop: 260.0,
    );

    if (Responsive.isMobile(context)) {
      return Column(
        children: features.asMap().entries.map((entry) {
          final index = entry.key;
          final feature = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: Responsive.spacing(context, 32)),
            child: ScaleIn(
              isVisible: animationState.featuresVisible.length > index
                  ? animationState.featuresVisible[index]
                  : false,
              duration: const Duration(milliseconds: 600),
              child: SizedBox(
                height: cardHeight,
                child: _buildFeatureCard(
                  feature['icon'] as IconData,
                  feature['title'] as String,
                  feature['subtitle'] as String,
                  context,
                  index,
                ),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = 4;
          final spacing = Responsive.valueWhen(
            context,
            mobile: 16.0,
            mobileSmall: 13.0,
            mobileLarge: 16.0,
            tablet: 10.0,
            tabletLarge: 16.0,
            desktop: 16.0,
          );
          final availableWidth = constraints.maxWidth;
          final totalSpacing = spacing * (crossAxisCount - 1);
          final cardWidth = (availableWidth - totalSpacing) / crossAxisCount;

          return Wrap(
            spacing: spacing,
            runSpacing: 20.0,
            children: features.asMap().entries.map((entry) {
              final index = entry.key;
              final feature = entry.value;
              return SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: ScaleIn(
                  isVisible: animationState.featuresVisible.length > index
                      ? animationState.featuresVisible[index]
                      : false,
                  duration: const Duration(milliseconds: 600),
                  initialScale: 0.9,
                  child: _buildFeatureCard(
                    feature['icon'] as IconData,
                    feature['title'] as String,
                    feature['subtitle'] as String,
                    context,
                    index,
                  ),
                ),
              );
            }).toList(),
          );
        },
      );
    }
  }

  Widget _buildFeatureCard(
      IconData icon, String title, String subtitle, BuildContext context, int index) {
    return _FeatureCard(
      icon: icon,
      title: title,
      subtitle: subtitle,
      context: context,
      index: index,
    );
  }

  Widget _buildMissionSection(BuildContext context, AboutAnimationState animationState, AppLocalizations loc) {
    return FadeInSlideUp(
      isVisible: animationState.isMissionVisible,
      duration: const Duration(milliseconds: 800),
      slideDistance: 40.0,
      child: Container(
        padding: EdgeInsets.all(
          Responsive.valueWhen(context, mobile: 32, mobileSmall: 24, mobileLarge: 36, tablet: 40, desktop: 48),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF7FAFC),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Responsive.isMobile(context)
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMissionContent(context, animationState, loc),
            SizedBox(height: Responsive.spacing(context, 40)),
            _buildStatsGrid(context, animationState, loc),
          ],
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: _buildMissionContent(context, animationState, loc)),
            SizedBox(width: Responsive.spacing(context, 60)),
            Expanded(flex: 2, child: _buildStatsGrid(context, animationState, loc)),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionContent(BuildContext context, AboutAnimationState animationState, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideInFromLeft(
          isVisible: animationState.isMissionVisible,
          duration: const Duration(milliseconds: 600),
          slideDistance: 60.0,
          child: Text(
            loc.missionTitle,
            style: GoogleFonts.poppins(
              fontSize: Responsive.fontSize(context, 32,
                  mobileSmallScale: 0.75,
                  mobileLargeScale: 0.9,
                  tabletScale: 1.0,
                  desktopScale: 1.0),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D3748),
            ),
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 20)),
        SlideInFromLeft(
          isVisible: animationState.isMissionVisible,
          duration: const Duration(milliseconds: 700),
          slideDistance: 40.0,
          child: Text(
            loc.missionDescription,
            style: GoogleFonts.poppins(
              fontSize: Responsive.fontSize(context, 14,
                  mobileSmallScale: 0.9,
                  mobileLargeScale: 1.0,
                  tabletScale: 1.0,
                  desktopScale: 1.0),
              color: Colors.black.withOpacity(0.6),
              height: 1.6,
            ),
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 32)),
        SlideInFromLeft(
          isVisible: animationState.isMissionVisible,
          duration: const Duration(milliseconds: 800),
          slideDistance: 30.0,
          child: Column(
            children: [
              _buildBulletPoint(loc.missionPoint1),
              SizedBox(height: Responsive.spacing(context, 12)),
              _buildBulletPoint(loc.missionPoint2),
              SizedBox(height: Responsive.spacing(context, 12)),
              _buildBulletPoint(loc.missionPoint3),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, right: 12),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: Responsive.fontSize(context, 15,
                  mobileSmallScale: 0.9,
                  mobileLargeScale: 1.0,
                  tabletScale: 1.0,
                  desktopScale: 1.1),
              color: AppColors.blackColor,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context, AboutAnimationState animationState, AppLocalizations loc) {
    final stats = [
      {'number': '10+', 'label': loc.statYearsOfService},
      {'number': '5000+', 'label': loc.statHappyPatients},
      {'number': '8', 'label': loc.statExpertDentists},
      {'number': '24/7', 'label': loc.statEmergencyCare},
    ];

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildAnimatedStatCard(stats[0], 0, context, animationState)),
            SizedBox(width: Responsive.spacing(context, 16)),
            Expanded(child: _buildAnimatedStatCard(stats[1], 1, context, animationState)),
          ],
        ),
        SizedBox(height: Responsive.spacing(context, 16)),
        Row(
          children: [
            Expanded(child: _buildAnimatedStatCard(stats[2], 2, context, animationState)),
            SizedBox(width: Responsive.spacing(context, 16)),
            Expanded(child: _buildAnimatedStatCard(stats[3], 3, context, animationState)),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedStatCard(
      Map<String, String> stat, int index, BuildContext context, AboutAnimationState animationState) {
    final isVisible = animationState.statsVisible.length > index
        ? animationState.statsVisible[index]
        : false;

    return ScaleIn(
      isVisible: isVisible,
      duration: const Duration(milliseconds: 500),
      initialScale: 0.9,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.spacing(context, 14),
          vertical: Responsive.spacing(context, 20),
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: CountUpAnimation(
          endValue: stat['number']!,
          label: stat['label']!,
          isVisible: isVisible,
          duration: const Duration(milliseconds: 1200),
          numberStyle: GoogleFonts.poppins(
            fontSize: Responsive.fontSize(context, 28,
                mobileSmallScale: 0.75,
                mobileLargeScale: 0.9,
                tabletScale: 0.79,
                desktopScale: 1.1),
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            height: 1,
          ),
          labelStyle: GoogleFonts.poppins(
            fontSize: Responsive.fontSize(context, 14,
                mobileSmallScale: 0.85,
                mobileLargeScale: 0.95,
                tabletScale: 1.0,
                desktopScale: 1.1),
            color: const Color(0xFF4A5568),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final BuildContext context;
  final int index;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.context,
    required this.index,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _shadowAnimation = Tween<double>(begin: 8.0, end: 15.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enableHover = !Responsive.isMobile(context);

    Widget cardContent = AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: enableHover ? _scaleAnimation.value : 1.0,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.valueWhen(
                context,
                mobile: 20,
                mobileSmall: 16,
                mobileLarge: 24,
                tablet: 12,
                desktop: 26,
              ),
              vertical: Responsive.valueWhen(
                context,
                mobile: 24,
                mobileSmall: 20,
                mobileLarge: 28,
                tablet: 20,
                desktop: 30,
              ),
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _isHovered && enableHover
                      ? Colors.grey.shade300
                      : Colors.grey.shade200,
                  blurRadius: _shadowAnimation.value,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(color: const Color(0xFFF1F1F1)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  size: Responsive.valueWhen(
                    context,
                    mobile: 38,
                    mobileSmall: 30,
                    mobileLarge: 36,
                    tablet: 40,
                    desktop: 50,
                  ),
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: Responsive.spacing(context, 16)),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: Responsive.fontSize(context, 16,
                        mobileSmallScale: 0.85,
                        mobileLargeScale: 1.0,
                        tabletScale: 1.0,
                        desktopScale: 1.1),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2D3748),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Responsive.spacing(context, 10)),
                Text(
                  widget.subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: Responsive.fontSize(context, 13,
                        mobileSmallScale: 0.9,
                        mobileLargeScale: 1.0,
                        tabletScale: 1.0,
                        desktopScale: 1.0),
                    color: Colors.black.withOpacity(0.55),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );

    if (enableHover) {
      cardContent = MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          _hoverController.forward();
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          _hoverController.reverse();
        },
        child: cardContent,
      );
    }

    return cardContent;
  }
}
