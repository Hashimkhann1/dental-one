import 'package:dental_one/l10n/app_localizations.dart';
import 'package:dental_one/res/app_colors/app_colors.dart';
import 'package:dental_one/res/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

/// Alternative Google Maps implementation using iframe
/// This approach works better for Flutter Web and doesn't require API key for basic embedding
class LocationSection extends StatefulWidget {
  const LocationSection({super.key});

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  // Replace with your actual clinic coordinates
  final String _latitude = '37.7749';
  final String _longitude = '-122.4194';
  final String _clinicName = 'DentalCare Clinic';

  @override
  void initState() {
    super.initState();
    _registerIframeView();
  }

  void _registerIframeView() {
    // Register the view factory for the iframe
    ui_web.platformViewRegistry.registerViewFactory(
      'google-maps-iframe',
          (int viewId) {
        // Create the Google Maps embed URL
        final String embedUrl =
            'https://www.google.com/maps/embed/v1/place?key=YOUR_API_KEY_HERE&q=$_latitude,$_longitude&zoom=15';

        // Alternative: Use search query instead (doesn't require API key but less precise)
        final String embedUrlNoKey =
            'https://maps.google.com/maps?q=$_latitude,$_longitude&output=embed&z=15';

        final html.IFrameElement iframe = html.IFrameElement()
          ..src = embedUrlNoKey // Use embedUrlNoKey for no API key, or embedUrl with API key
          ..style.border = 'none'
          ..style.height = '100%'
          ..style.width = '100%'
          ..allowFullscreen = true;

        return iframe;
      },
    );
  }

  void _openInGoogleMaps() {
    final url = 'https://www.google.com/maps/search/?api=1&query=$_latitude,$_longitude';
    html.window.open(url, '_blank');
  }

  void _callClinic() {
    html.window.open('tel:+15551234567', '_self');
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(context),
        vertical: Responsive.isMobile(context) ? 60 : 80,
      ),
      child: Column(
        children: [
          // Header Section
          _buildHeaderSection(context, localizations),

          SizedBox(height: Responsive.isMobile(context) ? 40 : 60),

          // Map and Info Section
          Responsive.isDesktop(context)
              ? _buildDesktopLayout(context, localizations)
              : _buildMobileLayout(context, localizations),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, AppLocalizations localizations) {
    return Column(
      children: [
        Text(
          localizations.visitOurClinic,
          style: GoogleFonts.poppins(
            fontSize: Responsive.isMobile(context)
                ? 32
                : (Responsive.isTablet(context) ? 36 : 40),
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Text(
            localizations.visitClinicDescription,
            style: GoogleFonts.inter(
              fontSize: Responsive.isMobile(context) ? 16 : 18,
              color: AppColors.textSecondaryColor,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AppLocalizations localizations) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side - Map
          Expanded(
            child: _buildMapContainer(context),
          ),

          const SizedBox(width: 40),

        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, AppLocalizations localizations) {
    return Column(
      children: [
        _buildMapContainer(context),
      ],
    );
  }

  Widget _buildMapContainer(BuildContext context) {
    return Container(
      height: Responsive.isMobile(context) ? 300 : 480,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: HtmlElementView(
        viewType: 'google-maps-iframe',
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context, AppLocalizations localizations) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.contactInformation,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 24),

          // Address
          _buildInfoItem(
            context,
            Icons.location_on_outlined,
            localizations.address,
            localizations.contactAddress,
          ),
          const SizedBox(height: 20),

          // Phone
          _buildInfoItem(
            context,
            Icons.phone_outlined,
            localizations.phone,
            localizations.contactPhone,
          ),
          const SizedBox(height: 20),

          // Email
          _buildInfoItem(
            context,
            Icons.email_outlined,
            localizations.email,
            localizations.contactEmail,
          ),
          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _openInGoogleMaps,
                  icon: const Icon(Icons.directions),
                  label: Text(localizations.getDirections),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _callClinic,
                  icon: const Icon(Icons.call),
                  label: Text(localizations.callClinic),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: BorderSide(color: AppColors.primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Office Hours
          Text(
            localizations.officeHours,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),

          _buildOfficeHoursItem(
            context,
            localizations.mondayFriday,
            localizations.mondayFridayHours,
          ),
          const SizedBox(height: 8),
          _buildOfficeHoursItem(
            context,
            localizations.saturday,
            localizations.saturdayHours,
          ),
          const SizedBox(height: 8),
          _buildOfficeHoursItem(
            context,
            localizations.sunday,
            localizations.closed,
            isClosed: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
      BuildContext context,
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.textPrimaryColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOfficeHoursItem(
      BuildContext context,
      String day,
      String hours, {
        bool isClosed = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.textPrimaryColor,
            ),
          ),
          Text(
            hours,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isClosed ? Colors.red : AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  double _getHorizontalPadding(BuildContext context) {
    if (Responsive.isMobile(context)) return 20;
    if (Responsive.isTablet(context)) return 40;
    return 100;
  }
}