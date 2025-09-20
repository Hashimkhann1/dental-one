import 'package:dental_one/res/app_colors/app_colors.dart';
import 'package:dental_one/res/responsive/responsive.dart';
import 'package:dental_one/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSection extends ConsumerStatefulWidget {
  const HomeSection({super.key});

  @override
  ConsumerState<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends ConsumerState<HomeSection>
    with SingleTickerProviderStateMixin {

  bool _imageLoaded = false;
  bool _animationsStarted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(homeViewModelProvider.notifier);
      viewModel.initializeAnimations(this);
      // Don't start animations here - wait for image to load
    });
  }

  @override
  void dispose() {
    final viewModel = ref.read(homeViewModelProvider.notifier);
    viewModel.disposeControllers();
    super.dispose();
  }

  // Called when image loads successfully
  void _onImageLoaded() {
    if (!_imageLoaded) {
      setState(() {
        _imageLoaded = true;
      });

      // Start animations only after image loads
      if (!_animationsStarted) {
        _animationsStarted = true;
        final viewModel = ref.read(homeViewModelProvider.notifier);
        Future.delayed(const Duration(milliseconds: 100), () {
          viewModel.startAnimations();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.86,
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.valueWhen(context,
                  mobile: 20,
                  mobileSmall: 16,
                  mobileLarge: 24,
                  tablet: 40,
                  tabletLarge: 60,
                  desktop: 200,
                ),
                vertical: Responsive.valueWhen(context,
                  mobile: 28,
                  mobileSmall: 24,
                  mobileLarge: 32,
                  tablet: 20,
                  tabletLarge: 24,
                  desktop: 0,
                ),
              ),
              child: Responsive.isDesktop(context)
                  ? _buildDesktopLayout(context)
                  : _buildMobileLayout(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _buildLeftContent(context),
        ),
        SizedBox(width: Responsive.valueWhen(context,
          tablet: 40,
          tabletLarge: 60,
          desktop: 80, mobile: 20,
        )),
        Expanded(
          flex: 6,
          child: _buildRightImage(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildRightImage(context),
        SizedBox(height: Responsive.spacing(context, 68)),
        _buildLeftContent(context),
      ],
    );
  }

  Widget _buildLeftContent(BuildContext context) {
    final animationState = ref.watch(homeViewModelProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Heading - Optimized Animation
        OptimizedAnimatedWidget(
          opacity: animationState.headingOpacity,
          slideX: animationState.headingSlide,
          child: _buildMainHeading(context),
        ),

        SizedBox(height: Responsive.spacing(context, 16)),

        // Description - Optimized Animation
        OptimizedAnimatedWidget(
          opacity: animationState.descriptionOpacity,
          slideX: animationState.descriptionSlide,
          child: _buildDescription(context),
        ),

        SizedBox(height: Responsive.spacing(context, 30)),

        // Buttons - Optimized Animation
        OptimizedAnimatedWidget(
          opacity: animationState.buttonsOpacity,
          slideX: animationState.buttonsSlide,
          child: _buildButtons(context),
        ),

        SizedBox(height: Responsive.spacing(context, 50)),

        // Feature Highlights - Optimized Animation
        OptimizedAnimatedWidget(
          opacity: animationState.featuresOpacity,
          slideX: animationState.featuresSlide,
          child: _buildFeatureHighlights(context),
        ),
      ],
    );
  }

  Widget _buildMainHeading(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: Responsive.isTablet(context) || Responsive.isTabletLarge(context) ? [
          TextSpan(
            text: 'Your Smile is Our ',
            style: GoogleFonts.poppins(
              fontSize: Responsive.fontSize(context, 54,
                mobileSmallScale: 0.6,
                mobileLargeScale: 0.65,
                tabletScale: 0.8,
                tabletLargeScale: 0.85,
                desktopScale: 1.0,
              ),
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 0.3,
            ),
          ),
          TextSpan(
            text: 'Priority',
            style: GoogleFonts.poppins(
              fontSize: Responsive.fontSize(context, 50,
                mobileSmallScale: 0.6,
                mobileLargeScale: 0.64,
                tabletScale: 0.8,
                tabletLargeScale: 0.84,
                desktopScale: 1.0,
              ),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ] : [
          TextSpan(
            text: 'Your Smile is Our\n',
            style: GoogleFonts.poppins(
              fontSize: Responsive.fontSize(context, 54,
                mobileSmallScale: 0.6,
                mobileLargeScale: 0.65,
                tabletScale: 0.8,
                tabletLargeScale: 0.85,
                desktopScale: 1.0,
              ),
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 0.3,
            ),
          ),
          TextSpan(
            text: 'Priority',
            style: GoogleFonts.poppins(
              fontSize: Responsive.fontSize(context, 50,
                mobileSmallScale: 0.6,
                mobileLargeScale: 0.64,
                tabletScale: 0.8,
                tabletLargeScale: 0.84,
                desktopScale: 1.0,
              ),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      'Experience exceptional dental care with our team of expert dentists. We provide comprehensive, gentle, and personalized treatment in a modern, comfortable environment.',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: Responsive.fontSize(context, 18,
          mobileSmallScale: 0.85,
          mobileLargeScale: 0.9,
          tabletScale: 0.95,
          tabletLargeScale: 0.98,
          desktopScale: 1.0,
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Wrap(
      spacing: Responsive.spacing(context, 16),
      runSpacing: Responsive.spacing(context, 16),
      children: [
        _buildPrimaryButton(context),
        _buildSecondaryButton(context),
      ],
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x200D6EFD),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(
          Icons.calendar_today,
          size: Responsive.valueWhen(context,
            mobile: 18,
            mobileSmall: 16,
            mobileLarge: 18,
            tablet: 19,
            tabletLarge: 20,
            desktop: 20,
          ),
          color: AppColors.whiteColor,
        ),
        label: Text(
          'Book Appointment',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 16,
              mobileSmallScale: 0.9,
              mobileLargeScale: 0.95,
              tabletScale: 1.0,
              tabletLargeScale: 1.0,
              desktopScale: 1.0,
            ),
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.valueWhen(context,
              mobile: 24,
              mobileSmall: 20,
              mobileLarge: 26,
              tablet: 28,
              tabletLarge: 30,
              desktop: 32,
            ),
            vertical: Responsive.valueWhen(context,
              mobile: 12,
              mobileSmall: 10,
              mobileLarge: 14,
              tablet: 14,
              tabletLarge: 15,
              desktop: 16,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.valueWhen(context,
            mobile: 24,
            mobileSmall: 20,
            mobileLarge: 26,
            tablet: 28,
            tabletLarge: 30,
            desktop: 32,
          ),
          vertical: Responsive.valueWhen(context,
            mobile: 12,
            mobileSmall: 10,
            mobileLarge: 14,
            tablet: 14,
            tabletLarge: 15,
            desktop: 16,
          ),
        ),
        side: const BorderSide(color: AppColors.primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'View Services',
        style: TextStyle(
          fontSize: Responsive.fontSize(context, 16,
            mobileSmallScale: 0.9,
            mobileLargeScale: 0.95,
            tabletScale: 1.0,
            tabletLargeScale: 1.0,
            desktopScale: 1.0,
          ),
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildFeatureHighlights(BuildContext context) {
    return Row(
      children: [
        _buildFeatureItem(
          Icons.shield_outlined,
          'Safe Care',
          'Latest\nprotocols',
          context,
        ),
        SizedBox(width: Responsive.valueWhen(context,
          mobile: 30,
          mobileSmall: 25,
          mobileLarge: 35,
          tablet: 45,
          tabletLarge: 55,
          desktop: 60,
        )),
        _buildFeatureItem(
          Icons.people_outline,
          'Expert Team',
          'Certified\nprofessionals',
          context,
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
      IconData icon,
      String title,
      String subtitle,
      BuildContext context,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(Responsive.valueWhen(context,
            mobile: 10,
            mobileSmall: 8,
            mobileLarge: 11,
            tablet: 11,
            tabletLarge: 12,
            desktop: 12,
          )),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: Responsive.valueWhen(context,
              mobile: 18,
              mobileSmall: 16,
              mobileLarge: 20,
              tablet: 33,
              tabletLarge: 34,
              desktop: 24,
            ),
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 16)),
        Text(
          title,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 18,
              mobileSmallScale: 0.85,
              mobileLargeScale: 0.9,
              tabletScale: 0.95,
              tabletLargeScale: 0.98,
              desktopScale: 1.0,
            ),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2D3748),
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 4)),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14,
              mobileSmallScale: 0.85,
              mobileLargeScale: 0.9,
              tabletScale: 0.95,
              tabletLargeScale: 0.98,
              desktopScale: 1.0,
            ),
            color: const Color(0xFF4A5568),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildRightImage(BuildContext context) {
    final animationState = ref.watch(homeViewModelProvider);

    final imageStack = _buildImageStack(context);

    return OptimizedAnimatedWidget(
      opacity: animationState.imageOpacity,
      slideX: animationState.imageSlide,
      child: imageStack,
    );
  }

  Widget _buildImageStack(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: Responsive.valueWhen(context,
            mobile: 350,
            mobileSmall: 300,
            mobileLarge: 380,
            tablet: 510,
            tabletLarge: 560,
            desktop: 600,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: AppColors.whiteColor,
              child: _imageLoaded
                  ? Image.asset(
                'assets/images/home_section_image.jpg',
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  // Called when image loads successfully
                  if (frame != null && !wasSynchronouslyLoaded) {
                    // Image loaded asynchronously - trigger animations
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _onImageLoaded();
                    });
                  } else if (wasSynchronouslyLoaded) {
                    // Image loaded from cache - trigger animations immediately
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _onImageLoaded();
                    });
                  }
                  return child;
                },
                errorBuilder: (context, error, stackTrace) {
                  // Fallback for missing image - show placeholder but don't trigger animations
                  return Container(
                    color: const Color(0xFFF0F8FF),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            size: 60,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Image not available',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : Image.asset(
                'assets/images/home_section_image.jpg',
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  // Called when image loads successfully
                  if (frame != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _onImageLoaded();
                    });
                  }
                  return child;
                },
                errorBuilder: (context, error, stackTrace) {
                  // Show loading placeholder while trying to load
                  return Container(
                    color: const Color(0xFFF0F8FF),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Loading image...',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // Only show info cards after image loads to prevent layout shift
        if (_imageLoaded) ...[
          Positioned(
            top: Responsive.valueWhen(context,
              mobile: -10,
              mobileSmall: -8,
              mobileLarge: -12,
              tablet: -15,
              tabletLarge: -18,
              desktop: -20,
            ),
            right: Responsive.valueWhen(context,
              mobile: -10,
              mobileSmall: -8,
              mobileLarge: -12,
              tablet: -15,
              tabletLarge: -18,
              desktop: -20,
            ),
            child: _buildInfoCard(
              context,
              '5000+',
              'Happy Patients',
              const Color(0xFF10B981),
              true,
            ),
          ),

          Positioned(
            bottom: Responsive.valueWhen(context,
              mobile: -16,
              mobileSmall: -14,
              mobileLarge: -18,
              tablet: -18,
              tabletLarge: -19,
              desktop: -20,
            ),
            left: Responsive.valueWhen(context,
              mobile: -14,
              mobileSmall: -12,
              mobileLarge: -16,
              tablet: -17,
              tabletLarge: -18,
              desktop: -20,
            ),
            child: _buildInfoCard(
              context,
              '10+',
              'Years Experience',
              AppColors.primaryColor,
              false,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoCard(
      BuildContext context,
      String number,
      String text,
      Color color,
      bool isTopCard,
      ) {
    return Container(
      padding: EdgeInsets.all(Responsive.valueWhen(context,
        mobile: 12,
        mobileSmall: 10,
        mobileLarge: 14,
        tablet: 15,
        tabletLarge: 16,
        desktop: 18,
      )),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 14,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 32,
                mobileSmallScale: 0.75,
                mobileLargeScale: 0.85,
                tabletScale: 0.9,
                tabletLargeScale: 0.95,
                desktopScale: 1.0,
              ),
              fontWeight: FontWeight.bold,
              color: color,
              height: 1,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 4)),
          Text(
            text,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14,
                mobileSmallScale: 0.8,
                mobileLargeScale: 0.9,
                tabletScale: 0.95,
                tabletLargeScale: 0.98,
                desktopScale: 1.0,
              ),
              color: const Color(0xFF4A5568),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}