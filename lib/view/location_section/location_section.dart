import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationSection extends StatefulWidget {
  const LocationSection({super.key});

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  GoogleMapController? _mapController;
  bool _mapLoaded = false;
  String? _mapError;

  // Clinic location coordinates (replace with your actual clinic coordinates)
  static const LatLng _clinicLocation = LatLng(40.7589, -73.9851); // Example: Times Square, NYC

  // Map markers
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('clinic'),
      position: _clinicLocation,
      infoWindow: InfoWindow(
        title: 'Dental One Clinic',
        snippet: '123 Medical Center Drive, Downtown',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;
    final isMobile = screenWidth <= 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 80 : (isTablet ? 60 : 40),
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF7FAFC),
            Color(0xFFEDF2F7),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Title
          Text(
            'Visit Our Clinic',
            style: TextStyle(
              fontSize: isDesktop ? 42 : (isTablet ? 36 : 28),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D3748),
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isDesktop ? 16 : 12),

          // Subtitle
          Text(
            'Conveniently located in the heart of the city',
            style: TextStyle(
              fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
              color: const Color(0xFF718096),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isDesktop ? 60 : (isTablet ? 50 : 40)),

          // Main Content
          if (isMobile)
            _buildMobileLayout()
          else
            _buildDesktopTabletLayout(isDesktop),
        ],
      ),
    );
  }

  Widget _buildDesktopTabletLayout(bool isDesktop) {
    return _buildMapSection(isDesktop);
  }

  Widget _buildMobileLayout() {
    return _buildMapSection(false);
  }

  Widget _buildClinicInfo(bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 40 : 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Clinic Name
          Text(
            'Dental One Clinic',
            style: TextStyle(
              fontSize: isDesktop ? 28 : 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 24),

          // Address
          _buildInfoItem(
            Icons.location_on,
            'Address',
            '123 Medical Center Drive\nSuite 456, Downtown\nNew York, NY 10001',
            isDesktop,
          ),
          const SizedBox(height: 20),

          // Phone
          _buildInfoItem(
            Icons.phone,
            'Phone',
            '+1 (555) 123-4567',
            isDesktop,
          ),
          const SizedBox(height: 20),

          // Email
          _buildInfoItem(
            Icons.email,
            'Email',
            'info@dentalone.com',
            isDesktop,
          ),
          const SizedBox(height: 20),

          // Hours
          _buildInfoItem(
            Icons.access_time,
            'Hours',
            'Mon - Fri: 8:00 AM - 6:00 PM\nSat: 9:00 AM - 4:00 PM\nSun: Closed',
            isDesktop,
          ),
          const SizedBox(height: 30),

          // Directions Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Add Google Maps integration here
              },
              icon: const Icon(Icons.directions, color: Colors.white),
              label: const Text(
                'Get Directions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3182CE),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(bool isDesktop) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = isDesktop ? 800.0 : (screenWidth > 768 ? 600.0 : double.infinity);

    return Center(
      child: Container(
        width: maxWidth,
        height: isDesktop ? 500 : 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Placeholder for Google Maps
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue[100]!,
                      Colors.blue[50]!,
                    ],
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map,
                        size: 60,
                        color: Color(0xFF3182CE),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Interactive Map',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3182CE),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Google Maps integration\nwould be placed here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF718096),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Map Controls Overlay
              Positioned(
                top: 16,
                right: 16,
                child: Column(
                  children: [
                    _buildMapButton(Icons.add, () {}),
                    const SizedBox(height: 8),
                    _buildMapButton(Icons.remove, () {}),
                    const SizedBox(height: 8),
                    _buildMapButton(Icons.my_location, () {}),
                  ],
                ),
              ),

              // Clinic Marker
              const Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: Center(
                  child: Icon(
                    Icons.location_on,
                    size: 40,
                    color: Color(0xFFE53E3E),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String content, bool isDesktop) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF3182CE).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF3182CE),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isDesktop ? 16 : 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(
                  fontSize: isDesktop ? 14 : 13,
                  color: const Color(0xFF718096),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMapButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: const Color(0xFF2D3748),
        ),
      ),
    );
  }
}