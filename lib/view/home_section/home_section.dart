import 'package:dental_one/l10n/app_localizations.dart';
import 'package:dental_one/res/app_colors/app_colors.dart';
import 'package:dental_one/res/responsive/responsive.dart';
import 'package:dental_one/view/all_sections/all_sections.dart';
import 'package:dental_one/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSection extends ConsumerStatefulWidget {
  const HomeSection({super.key,this.bookAppointmentOnPressed,this.servicesOnPressed});
  final void Function()? bookAppointmentOnPressed;
  final void Function()? servicesOnPressed;

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
    });
  }

  @override
  void dispose() {
    final viewModel = ref.read(homeViewModelProvider.notifier);
    viewModel.disposeControllers();
    super.dispose();
  }

  void _onImageLoaded() {
    if (!_imageLoaded) {
      setState(() {
        _imageLoaded = true;
      });

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
    // Calculate optimal height based on device type
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - appBarHeight - statusBarHeight;

    return Container(
      width: double.infinity,
      // Use flexible height constraints instead of fixed height
      constraints: BoxConstraints(
        minHeight: Responsive.valueWhen(context,
          mobile: availableHeight * 0.85,
          mobileSmall: availableHeight * 0.8,
          mobileLarge: availableHeight * 0.9,
          tablet: availableHeight * 0.85,
          tabletLarge: availableHeight * 0.9,
          desktop: availableHeight * 0.9,
        ),
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF7FAFC),
      ),
      child: _buildResponsiveLayout(context),
    );
  }

  Widget _buildResponsiveLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.valueWhen(context,
          mobile: 20,
          mobileSmall: 16,
          mobileLarge: 24,
          tablet: 40,
          tabletLarge: 60,
          desktop: MediaQuery.of(context).size.width < 1378 ? MediaQuery.of(context).size.width * 0.03 : MediaQuery.of(context).size.width * 0.08,
        ),
        vertical: Responsive.valueWhen(context,
          mobile: 20,
          mobileSmall: 16,
          mobileLarge: 24,
          tablet: 20,
          tabletLarge: 24,
          desktop: 40,
        ),
      ),
      child: Responsive.isDesktop(context)
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: _buildLeftContent(context),
          ),
          SizedBox(width: Responsive.valueWhen(context,
            tablet: 40,
            tabletLarge: 60,
            desktop: 80,
            mobile: 20,
          )),
          Expanded(
            flex: 6,
            child: _buildRightImage(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildRightImage(context),
        SizedBox(height: Responsive.spacing(context, 40)),
        _buildLeftContent(context),
        // Add some bottom spacing for mobile
        SizedBox(height: Responsive.spacing(context, 40)),
      ],
    );
  }

  Widget _buildLeftContent(BuildContext context) {
    final animationState = ref.watch(homeViewModelProvider);

    return Column(
      crossAxisAlignment: Responsive.isDesktop(context)
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        // Main Heading
        OptimizedAnimatedWidget(
          opacity: animationState.headingOpacity,
          slideX: animationState.headingSlide,
          child: _buildMainHeading(context),
        ),

        SizedBox(height: Responsive.spacing(context, 16)),

        // Description
        OptimizedAnimatedWidget(
          opacity: animationState.descriptionOpacity,
          slideX: animationState.descriptionSlide,
          child: _buildDescription(context),
        ),

        SizedBox(height: Responsive.spacing(context, 30)),

        // Buttons
        OptimizedAnimatedWidget(
          opacity: animationState.buttonsOpacity,
          slideX: animationState.buttonsSlide,
          child: _buildButtons(context),
        ),

        SizedBox(height: Responsive.spacing(context, 50)),

        // Feature Highlights
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
      textAlign: Responsive.isDesktop(context)
          ? TextAlign.left
          : TextAlign.center,
      text: TextSpan(
        children: Responsive.isTablet(context) || Responsive.isTabletLarge(context) ? [
          TextSpan(
            text: AppLocalizations.of(context)!.homeHeadingSmile.toString(),
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
              height: 1.2,
            ),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.homeHeadingPriority.toString(),
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
            text: '${AppLocalizations.of(context)!.homeHeadingSmile.toString()}\n',
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
              height: 1.2,
            ),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.homeHeadingPriority.toString(),
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
        AppLocalizations.of(context)!.homeParagraph.toString(),
      textAlign: Responsive.isDesktop(context)
          ? TextAlign.left
          : TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: Responsive.fontSize(context, 18,
          mobileSmallScale: 0.85,
          mobileLargeScale: 0.9,
          tabletScale: 0.95,
          tabletLargeScale: 0.98,
          desktopScale: 1.0,
        ),
        color: const Color(0xFF4A5568),
        height: 1.6,
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Wrap(
      alignment: Responsive.isDesktop(context)
          ? WrapAlignment.start
          : WrapAlignment.center,
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
        onPressed: widget.bookAppointmentOnPressed,
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
          AppLocalizations.of(context)!.bookAppointment.toString(),
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
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.servicesOnPressed,
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
        AppLocalizations.of(context)!.services.toString(),
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
      mainAxisAlignment: Responsive.isDesktop(context)
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        _buildFeatureItem(
          Icons.shield_outlined,
          AppLocalizations.of(context)!.safeCare.toString(),
          AppLocalizations.of(context)!.latestProtocols.toString(),
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
          AppLocalizations.of(context)!.expertTeam.toString(),
          AppLocalizations.of(context)!.certifiedProfessionals.toString(),
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
      crossAxisAlignment: Responsive.isDesktop(context)
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
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
              tablet: 22,
              tabletLarge: 24,
              desktop: 24,
            ),
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 12)),
        Text(
          title,
          textAlign: Responsive.isDesktop(context)
              ? TextAlign.left
              : TextAlign.center,
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
          textAlign: Responsive.isDesktop(context)
              ? TextAlign.left
              : TextAlign.center,
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

    return OptimizedAnimatedWidget(
      opacity: animationState.imageOpacity,
      slideX: animationState.imageSlide,
      child: _buildImageStack(context),
    );
  }

  Widget _buildImageStack(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: Responsive.valueWhen(context,
            mobile: 300,
            mobileSmall: 280,
            mobileLarge: 320,
            tablet: 450,
            tabletLarge: 500,
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
            child: Image.asset(
              'assets/images/home_section_image.jpg',
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (frame != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _onImageLoaded();
                  });
                }
                return child;
              },
              errorBuilder: (context, error, stackTrace) {
                // Trigger animations even if image fails to load
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _onImageLoaded();
                });
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
            ),
          ),
        ),

        // Info cards - only show after image loads to prevent layout shift
        if (_imageLoaded) ...[
          Positioned(
            top: Responsive.valueWhen(context,
              mobile: -8,
              mobileSmall: -6,
              mobileLarge: -10,
              tablet: -12,
              tabletLarge: -15,
              desktop: -20,
            ),
            right: Responsive.valueWhen(context,
              mobile: -8,
              mobileSmall: -6,
              mobileLarge: -10,
              tablet: -12,
              tabletLarge: -15,
              desktop: -20,
            ),
            child: _buildInfoCard(
              context,
              AppLocalizations.of(context)!.fivek,
              AppLocalizations.of(context)!.happyPatients,
              const Color(0xFF10B981),
            ),
          ),

          Positioned(
            bottom: Responsive.valueWhen(context,
              mobile: -12,
              mobileSmall: -10,
              mobileLarge: -14,
              tablet: -15,
              tabletLarge: -17,
              desktop: -20,
            ),
            left: Responsive.valueWhen(context,
              mobile: -10,
              mobileSmall: -8,
              mobileLarge: -12,
              tablet: -12,
              tabletLarge: -15,
              desktop: -20,
            ),
            child: _buildInfoCard(
              context,
              AppLocalizations.of(context)!.thenPlus,
              AppLocalizations.of(context)!.yearExperience,
              AppColors.primaryColor,
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
      ) {
    return Container(
      padding: EdgeInsets.all(Responsive.valueWhen(context,
        mobile: 10,
        mobileSmall: 8,
        mobileLarge: 12,
        tablet: 14,
        tabletLarge: 16,
        desktop: 18,
      )),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 2),
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
              fontSize: Responsive.fontSize(context, 28,
                mobileSmallScale: 0.75,
                mobileLargeScale: 0.85,
                tabletScale: 0.9,
                tabletLargeScale: 0.95,
                desktopScale: 1.0,
              ),
              fontWeight: FontWeight.bold,
              color: color,
              height: 1.1,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 4)),
          Text(
            text,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 13,
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

// Optimized Animation Widget
class OptimizedAnimatedWidget extends StatelessWidget {
  final double opacity;
  final double slideX;
  final Widget child;

  const OptimizedAnimatedWidget({
    super.key,
    required this.opacity,
    required this.slideX,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutQuart,
      child: Transform.translate(
        offset: Offset(slideX, 0),
        child: child,
      ),
    );
  }
}