import 'package:cloud_functions/cloud_functions.dart';
import 'package:dental_one/l10n/app_localizations.dart';
import 'package:dental_one/res/app_colors/app_colors.dart';
import 'package:dental_one/res/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookNowSection extends StatefulWidget {
  const BookNowSection({super.key});

  @override
  State<BookNowSection> createState() => _BookNowSectionState();
}

class _BookNowSectionState extends State<BookNowSection> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedService;
  DateTime? _selectedDate;
  String? _selectedTime;

  List<String> _getServices(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.serviceGeneralCheckup,
      l10n.serviceTeethCleaning,
      l10n.serviceCosmeticDentistry,
      l10n.serviceOrthodontics,
      l10n.serviceOralSurgery,
      l10n.serviceEmergencyCare,
    ];
  }

  List<String> _getTimeSlots(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.timeSlot9am,
      l10n.timeSlot10am,
      l10n.timeSlot11am,
      l10n.timeSlot2pm,
      l10n.timeSlot3pm,
      l10n.timeSlot4pm,
      l10n.timeSlot5pm,
    ];
  }

  Future<void> _submitForm() async {
    final l10n = AppLocalizations.of(context)!;

    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.pleaseSelectDate))
        );
        return;
      }

      if (_selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.pleaseSelectTime))
        );
        return;
      }

      try {
        // Show loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.sendingAppointmentRequest),
            duration: const Duration(seconds: 2),
          ),
        );

        // Call Firebase Function
        final HttpsCallable callable = FirebaseFunctions.instance
            .httpsCallable('sendMail');

        final result = await callable.call({
          "subject": "${l10n.newAppointmentRequestSubject} - ${_fullNameController.text}",
          "text": """
New Appointment Request

Patient Details:
• Full Name: ${_fullNameController.text}
• Email: ${_emailController.text}
• Phone: ${_phoneController.text}

Appointment Details:
• Service: $_selectedService
• Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}
• Time: $_selectedTime

Additional Notes:
${_notesController.text.isEmpty ? "None" : _notesController.text}

Please contact the patient to confirm this appointment.
        """,
        });

        // Success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.appointmentSuccessMessage),
            backgroundColor: AppColors.emergencyGreenColor,
            duration: const Duration(seconds: 4),
          ),
        );

        // Reset form after success
        _formKey.currentState!.reset();
        setState(() {
          _selectedService = null;
          _selectedDate = null;
          _selectedTime = null;
        });
        _fullNameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _notesController.clear();

      } catch (e) {
        // Error handling
        String errorMessage = l10n.appointmentFailedMessage;

        if (e.toString().contains('unauthenticated')) {
          errorMessage = l10n.emailConfigError;
        } else if (e.toString().contains('unavailable')) {
          errorMessage = l10n.networkError;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );

        print("Error details: $e"); // For debugging
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.lightBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(context),
        vertical: Responsive.isMobile(context) ? 60 : 80,
      ),
      child: Column(
        children: [
          // Header Section
          _buildHeaderSection(context),

          SizedBox(height: Responsive.isMobile(context) ? 40 : 60),

          // Main Content
          Responsive.isDesktop(context)
              ? _buildDesktopLayout(context)
              : _buildMobileLayout(context),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          l10n.bookYourAppointment,
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
            l10n.bookAppointmentDescription,
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

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.62,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side - Form
          Expanded(flex: 2, child: _buildBookingForm(context)),

          const SizedBox(width: 40),

          // Right Side - Contact Info
          Expanded(flex: 2, child: _buildContactInfo(context)),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildBookingForm(context),
        const SizedBox(height: 40),
        _buildContactInfo(context),
      ],
    );
  }

  Widget _buildBookingForm(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 24 : 44,
        vertical: Responsive.isMobile(context) ? 20 : 24,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.scheduleYourVisit,
              style: GoogleFonts.poppins(
                fontSize: Responsive.isMobile(context) ? 22 : 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),

            const SizedBox(height: 24),

            // Full Name Field
            _buildTextField(
              controller: _fullNameController,
              label: l10n.fullName,
              hint: l10n.enterFullName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.pleaseEnterFullName;
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Email Field
            _buildTextField(
              controller: _emailController,
              label: l10n.emailAddress,
              hint: l10n.enterEmail,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.pleaseEnterEmail;
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return l10n.pleaseEnterValidEmail;
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Phone Field
            _buildTextField(
              controller: _phoneController,
              label: l10n.phoneNumber,
              hint: l10n.enterPhoneNumber,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.pleaseEnterPhoneNumber;
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Service Dropdown
            _buildDropdownField(
              label: l10n.serviceNeeded,
              value: _selectedService,
              items: _getServices(context),
              hint: l10n.selectService,
              onChanged: (value) => setState(() => _selectedService = value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.pleaseSelectService;
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                // Date Picker
                Expanded(child: _buildDateField(context)),

                const SizedBox(width: 16),

                // Time Dropdown
                Expanded(
                  child: _buildDropdownField(
                    label: l10n.preferredTime,
                    value: _selectedTime,
                    items: _getTimeSlots(context),
                    hint: l10n.selectTime,
                    onChanged: (value) => setState(() => _selectedTime = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.pleaseSelectTime;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Notes Field
            _buildTextField(
              controller: _notesController,
              label: l10n.additionalNotes,
              hint: l10n.additionalNotesHint,
              maxLines: 2,
              validator: null,
            ),

            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(
                  Icons.calendar_today,
                  color: AppColors.whiteColor,
                ),
                label: Text(
                  l10n.requestAppointment,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      children: [
        // Contact Information Card
        _buildContactCard(context),

        const SizedBox(height: 24),

        // Office Hours Card
        _buildOfficeHoursCard(context),

        const SizedBox(height: 24),

        // Emergency Care Card
        _buildEmergencyCareCard(context),
      ],
    );
  }

  Widget _buildContactCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.contactInformation,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),

          const SizedBox(height: 20),

          _buildContactItem(
            Icons.phone_outlined,
            l10n.phone,
            l10n.contactPhone,
          ),

          const SizedBox(height: 16),

          _buildContactItem(
            Icons.email_outlined,
            l10n.email,
            l10n.contactEmail,
          ),

          const SizedBox(height: 16),

          _buildContactItem(
            Icons.location_on_outlined,
            l10n.address,
            l10n.contactAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildOfficeHoursCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.officeHours,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),

          const SizedBox(height: 20),

          _buildOfficeHourItem(l10n.mondayFriday, l10n.mondayFridayHours),
          const SizedBox(height: 12),
          _buildOfficeHourItem(l10n.saturday, l10n.saturdayHours),
          const SizedBox(height: 12),
          _buildOfficeHourItem(l10n.sunday, l10n.closed),
        ],
      ),
    );
  }

  Widget _buildEmergencyCareCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.lightGreenColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.emergencyGreenColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_hospital_outlined,
                color: AppColors.emergencyGreenColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.emergencyCareTitle,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.emergencyGreenColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            l10n.emergencyCareDescription,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textPrimaryColor,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.emergencyGreenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              l10n.emergencyContact,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: AppColors.textSecondaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required String hint,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: AppColors.textSecondaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.preferredDate,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                      : l10n.selectDate,
                  style: GoogleFonts.inter(
                    color: _selectedDate != null
                        ? AppColors.textPrimaryColor
                        : AppColors.textSecondaryColor,
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.textSecondaryColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 20),
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
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOfficeHourItem(String day, String hours) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textPrimaryColor,
          ),
        ),
        Text(
          hours,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: AppColors.primaryColor),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  double _getHorizontalPadding(BuildContext context) {
    if (Responsive.isMobile(context)) return 20;
    if (Responsive.isTablet(context)) return 40;
    return 180;
  }
}