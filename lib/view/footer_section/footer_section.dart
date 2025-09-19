import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF2D3748), // Dark blue-gray background
      child: Column(
        children: [
          // Main footer content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 768;

                if (isMobile) {
                  // Mobile layout - stacked vertically
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDentalCareSection(),
                      const SizedBox(height: 32),
                      _buildQuickLinksSection(),
                      const SizedBox(height: 32),
                      _buildServicesSection(),
                      const SizedBox(height: 32),
                      _buildContactInfoSection(),
                    ],
                  );
                } else {
                  // Desktop layout - four columns
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 3, child: _buildDentalCareSection()),
                      const SizedBox(width: 48),
                      Expanded(flex: 2, child: _buildQuickLinksSection()),
                      const SizedBox(width: 48),
                      Expanded(flex: 2, child: _buildServicesSection()),
                      const SizedBox(width: 48),
                      Expanded(flex: 3, child: _buildContactInfoSection()),
                    ],
                  );
                }
              },
            ),
          ),

          // Divider line
          Container(
            height: 1,
            color: const Color(0xFF4A5568),
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
          ),

          // Bottom copyright section
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 600;

                if (isMobile) {
                  return Column(
                    children: [
                      Text(
                        '© 2025 DentalCare Clinic. All rights reserved.',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 24,
                        children: [
                          _buildFooterLink('Privacy Policy'),
                          _buildFooterLink('Terms of Service'),
                          _buildFooterLink('Cookie Policy'),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '© 2025 DentalCare Clinic. All rights reserved.',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          _buildFooterLink('Privacy Policy'),
                          const SizedBox(width: 24),
                          _buildFooterLink('Terms of Service'),
                          const SizedBox(width: 24),
                          _buildFooterLink('Cookie Policy'),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDentalCareSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DentalCare',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Providing exceptional dental care with a focus on patient comfort, advanced technology, and personalized treatment plans.',
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Links',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildLinkItem('Home'),
        _buildLinkItem('About Us'),
        _buildLinkItem('Services'),
        _buildLinkItem('Our Experts'),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Services',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildLinkItem('General Dentistry'),
        _buildLinkItem('Cosmetic Dentistry'),
        _buildLinkItem('Orthodontics'),
        _buildLinkItem('Emergency Care'),
        _buildLinkItem('Oral Surgery'),
        _buildLinkItem('Pediatric Dentistry'),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Info',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactItem(Icons.phone, '(555) 123-4567'),
        const SizedBox(height: 12),
        _buildContactItem(Icons.email, 'info@dentalcareclinic.com'),
        const SizedBox(height: 12),
        _buildContactItem(Icons.location_on, '123 Healthcare Drive\nMedical District, CA 90210'),
        const SizedBox(height: 12),
        _buildContactItem(Icons.access_time, 'Mon-Fri: 8AM-6PM\nSat: 9AM-3PM\nSun: Emergency Only'),
      ],
    );
  }

  Widget _buildLinkItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          // Handle link tap
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.grey[400],
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 16,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return InkWell(
      onTap: () {
        // Handle footer link tap
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
        ),
      ),
    );
  }
}
