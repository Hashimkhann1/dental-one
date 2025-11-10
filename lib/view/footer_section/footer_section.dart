import 'package:dental_one/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Add this in pubspec.yaml

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      color: const Color(0xFF2D3748), // Dark background
      child: Column(
        children: [
          // ✅ Main footer content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 768;

                if (isMobile) {
                  // Mobile layout
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDentalCareSection(l10n),
                      const SizedBox(height: 32),
                      _buildSocialMediaSection(), // ✅ Add here
                      const SizedBox(height: 32),
                      _buildQuickLinksSection(l10n),
                      const SizedBox(height: 32),
                      _buildServicesSection(l10n),
                      const SizedBox(height: 32),
                      _buildContactInfoSection(l10n),
                    ],
                  );
                } else {
                  // Desktop layout
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
                      const SizedBox(width: 48),
                      Expanded(flex: 2, child: _buildSocialMediaSection()), // ✅ Add here
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

          // ✅ Bottom copyright section
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

  // --------------------------------------------------------------------------
  // 🔹 Footer sections
  // --------------------------------------------------------------------------

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

  // --------------------------------------------------------------------------
  // 🔹 New Social Media Section
  // --------------------------------------------------------------------------

  Widget _buildSocialMediaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Follow Us",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildSocialIcon(
              icon: FontAwesomeIcons.whatsapp,
              color: Colors.green,
              onTap: () => _launchURL('https://wa.me/923235200735'),
            ),
            _buildSocialIcon(
              icon: FontAwesomeIcons.instagram,
              color: Colors.pinkAccent,
              onTap: () => _launchURL('https://www.instagram.com/hashimkhan5806/'),
            ),
            _buildSocialIcon(
              icon: FontAwesomeIcons.facebookF,
              color: Colors.blueAccent,
              onTap: () => _launchURL('https://www.facebook.com/profile.php?id=100011393307548'),
            ),
            _buildSocialIcon(
              icon: FontAwesomeIcons.linkedinIn,
              color: Colors.blue,
              onTap: () => _launchURL('https://www.linkedin.com/in/themuhammad-hashim/'),
            ),
            _buildSocialIcon(
              icon: FontAwesomeIcons.tiktok,
              color: Colors.white,
              onTap: () => _launchURL('https://www.tiktok.com/@uuhmk?_r=1&_t=ZS-9107VllYgsP'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(50),
        ),
        child: FaIcon(icon, color: color, size: 22),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 🔹 Helper Widgets
  // --------------------------------------------------------------------------

  Widget _buildLinkItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {},
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
        Icon(icon, color: Colors.grey[400], size: 20),
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
      onTap: () {},
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
