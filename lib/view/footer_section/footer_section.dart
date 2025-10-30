import 'package:dental_one/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                      _buildDentalCareSection(l10n),
                      const SizedBox(height: 32),
                      _buildQuickLinksSection(l10n),
                      const SizedBox(height: 32),
                      _buildServicesSection(l10n),
                      const SizedBox(height: 32),
                      _buildContactInfoSection(l10n),
                    ],
                  );
                } else {
                  // Desktop layout - four columns
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 3, child: _buildDentalCareSection(l10n)),
                      const SizedBox(width: 48),
                      Expanded(flex: 2, child: _buildQuickLinksSection(l10n)),
                      const SizedBox(width: 48),
                      Expanded(flex: 2, child: _buildServicesSection(l10n)),
                      const SizedBox(width: 48),
                      Expanded(flex: 3, child: _buildContactInfoSection(l10n)),
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
                        l10n.footerCopyright,
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
                          _buildFooterLink(l10n.footerPrivacyPolicy),
                          _buildFooterLink(l10n.footerTermsOfService),
                          _buildFooterLink(l10n.footerCookiePolicy),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.footerCopyright,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          _buildFooterLink(l10n.footerPrivacyPolicy),
                          const SizedBox(width: 24),
                          _buildFooterLink(l10n.footerTermsOfService),
                          const SizedBox(width: 24),
                          _buildFooterLink(l10n.footerCookiePolicy),
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

  Widget _buildDentalCareSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.footerDentalCareTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.footerDentalCareDescription,
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinksSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.footerQuickLinks,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildLinkItem(l10n.home),
        _buildLinkItem(l10n.aboutUs),
        _buildLinkItem(l10n.services),
        _buildLinkItem(l10n.ourExperts),
      ],
    );
  }

  Widget _buildServicesSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.services,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildLinkItem(l10n.serviceGeneralTitle),
        _buildLinkItem(l10n.serviceCosmeticTitle),
        _buildLinkItem(l10n.serviceOrthoTitle),
        _buildLinkItem(l10n.serviceEmergencyTitle),
        _buildLinkItem(l10n.serviceSurgeryTitle),
        _buildLinkItem(l10n.servicePediatricTitle),
      ],
    );
  }

  Widget _buildContactInfoSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.contactInformation,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactItem(Icons.phone, l10n.contactPhone),
        const SizedBox(height: 12),
        _buildContactItem(Icons.email, l10n.contactEmail),
        const SizedBox(height: 12),
        _buildContactItem(Icons.location_on, l10n.contactAddress),
        const SizedBox(height: 12),
        _buildContactItem(Icons.access_time, l10n.footerOfficeHours),
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