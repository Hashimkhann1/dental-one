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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 1024;
          final isTablet = constraints.maxWidth > 768;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.86,
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 200 : (isTablet ? 40 : 20),
                    vertical: Responsive.isMobile(context) ? 28 : 0,
                  ),
                  child: isTablet
                      ? _buildDesktopLayout(context, isDesktop)
                      : _buildMobileLayout(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDesktop) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _buildLeftContent(context, isDesktop),
        ),
        SizedBox(width: isDesktop ? 80 : 40),
        Expanded(
          flex: 6,
          child: _buildRightImage(context, isDesktop),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildRightImage(context, false),
        const SizedBox(height: 68),
        _buildLeftContent(context, false),
      ],
    );
  }

  Widget _buildLeftContent(BuildContext context, bool isDesktop) {
    final animationState = ref.watch(homeViewModelProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Heading - Optimized Animation
        OptimizedAnimatedWidget(
          opacity: animationState.headingOpacity,
          slideX: animationState.headingSlide,
          child: _buildMainHeading(context, isDesktop),
        ),

        const SizedBox(height: 16),

        // Description - Optimized Animation
        OptimizedAnimatedWidget(
          opacity: animationState.descriptionOpacity,
          slideX: animationState.descriptionSlide,
          child: _buildDescription(context, isDesktop),
        ),

        const SizedBox(height: 30),

        // Buttons - Optimized Animation
        OptimizedAnimatedWidget(
          opacity: animationState.buttonsOpacity,
          slideX: animationState.buttonsSlide,
          child: _buildButtons(),
        ),

        const SizedBox(height: 50),

        // Feature Highlights - Optimized Animation
        OptimizedAnimatedWidget(
          opacity: animationState.featuresOpacity,
          slideX: animationState.featuresSlide,
          child: _buildFeatureHighlights(isDesktop),
        ),
      ],
    );
  }

  Widget _buildMainHeading(BuildContext context, bool isDesktop) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Your Smile is Our\n',
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 54 : 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 0.3,
            ),
          ),
          TextSpan(
            text: 'Priority',
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 50 : 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context, bool isDesktop) {
    return Text(
      'Experience exceptional dental care with our team of expert dentists. We provide comprehensive, gentle, and personalized treatment in a modern, comfortable environment.',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: isDesktop ? 18 : 16,
      ),
    );
  }

  Widget _buildButtons() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildPrimaryButton(),
        _buildSecondaryButton(),
      ],
    );
  }

  Widget _buildPrimaryButton() {
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
        icon: const Icon(Icons.calendar_today, size: 20, color: AppColors.whiteColor),
        label: const Text(
          'Book Appointment',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        side: const BorderSide(color: AppColors.primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'View Services',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildFeatureHighlights(bool isDesktop) {
    return Row(
      children: [
        _buildFeatureItem(
          Icons.shield_outlined,
          'Safe Care',
          'Latest\nprotocols',
          isDesktop,
        ),
        SizedBox(width: isDesktop ? 60 : 40),
        _buildFeatureItem(
          Icons.people_outline,
          'Expert Team',
          'Certified\nprofessionals',
          isDesktop,
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
      IconData icon,
      String title,
      String subtitle,
      bool isDesktop,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: isDesktop ? 24 : 20,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: isDesktop ? 18 : 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: isDesktop ? 14 : 12,
            color: const Color(0xFF4A5568),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildRightImage(BuildContext context, bool isDesktop) {
    final animationState = ref.watch(homeViewModelProvider);

    final imageStack = _buildImageStack(context, isDesktop);

    return OptimizedAnimatedWidget(
      opacity: animationState.imageOpacity,
      slideX: animationState.imageSlide,
      child: imageStack,
    );
  }

  Widget _buildImageStack(BuildContext context, bool isDesktop) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: isDesktop ? 600 : 400,
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
            top: Responsive.isMobile(context) ? -10 : -20,
            right: Responsive.isMobile(context) ? -10 : -20,
            child: _buildInfoCard(
              context,
              '5000+',
              'Happy Patients',
              const Color(0xFF10B981),
              true,
            ),
          ),

          Positioned(
            bottom: -20,
            left: Responsive.isMobile(context) ? -14 : -20,
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
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 12 : 18),
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
              fontSize: Responsive.isMobile(context) ? 26 : 32,
              fontWeight: FontWeight.bold,
              color: color,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: Responsive.isMobile(context) ? 12 : 14,
              color: const Color(0xFF4A5568),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}