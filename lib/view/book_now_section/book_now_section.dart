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

  final List<String> _services = [
    'General Checkup',
    'Teeth Cleaning',
    'Cosmetic Dentistry',
    'Orthodontics',
    'Oral Surgery',
    'Emergency Care',
  ];

  final List<String> _timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

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
    return Column(
      children: [
        Text(
          'Book Your Appointment',
          style: GoogleFonts.poppins(
            fontSize: Responsive.isMobile(context) ? 32 : (Responsive.isTablet(context) ? 36 : 40),
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryColor,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),

        Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Text(
            'Schedule your dental appointment with our expert team. We offer flexible scheduling and comprehensive dental services to meet all your oral health needs.',
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
          Expanded(
            flex: 2,
            child: _buildBookingForm(context),
          ),

          const SizedBox(width: 40),

          // Right Side - Contact Info
          Expanded(
            flex: 2,
            child: _buildContactInfo(context),
          ),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 24 : 44 ,vertical: Responsive.isMobile(context) ? 20 : 24),
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
              'Schedule Your Visit',
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
              label: 'Full Name',
              hint: 'Enter your full name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Email Field
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'Enter your email address',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Phone Field
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              hint: 'Enter your phone number',
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Service Dropdown
            _buildDropdownField(
              label: 'Service Needed',
              value: _selectedService,
              items: _services,
              hint: 'Select a service',
              onChanged: (value) => setState(() => _selectedService = value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a service';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                // Date Picker
                Expanded(
                  child: _buildDateField(context),
                ),

                const SizedBox(width: 16),

                // Time Dropdown
                Expanded(
                  child: _buildDropdownField(
                    label: 'Preferred Time',
                    value: _selectedTime,
                    items: _timeSlots,
                    hint: 'Select time',
                    onChanged: (value) => setState(() => _selectedTime = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select time';
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
              label: 'Additional Notes',
              hint: 'Any specific concerns or requests...',
              maxLines: 2,
              validator: null,
            ),

            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.calendar_today, color: AppColors.whiteColor),
                label: Text(
                  'Request Appointment',
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
        _buildContactCard(),

        const SizedBox(height: 24),

        // Office Hours Card
        _buildOfficeHoursCard(),

        const SizedBox(height: 24),

        // Emergency Care Card
        _buildEmergencyCareCard(),
      ],
    );
  }

  Widget _buildContactCard() {
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
            'Contact Information',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),

          const SizedBox(height: 20),

          _buildContactItem(
            Icons.phone_outlined,
            'Phone',
            '+1 (555) 123-4567',
          ),

          const SizedBox(height: 16),

          _buildContactItem(
            Icons.email_outlined,
            'Email',
            'info@dentalcare.com',
          ),

          const SizedBox(height: 16),

          _buildContactItem(
            Icons.location_on_outlined,
            'Address',
            '123 Dental Street\nHealthy City, HC 12345',
          ),
        ],
      ),
    );
  }

  Widget _buildOfficeHoursCard() {
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
            'Office Hours',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),

          const SizedBox(height: 20),

          _buildOfficeHourItem('Monday - Friday', '8:00 AM - 6:00 PM'),
          const SizedBox(height: 12),
          _buildOfficeHourItem('Saturday', '9:00 AM - 4:00 PM'),
          const SizedBox(height: 12),
          _buildOfficeHourItem('Sunday', 'Closed'),
        ],
      ),
    );
  }

  Widget _buildEmergencyCareCard() {
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
              Icon(
                Icons.local_hospital_outlined,
                color: AppColors.emergencyGreenColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Emergency Care',
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
            'We provide 24/7 emergency dental care for urgent situations. Call us immediately for dental emergencies.',
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
              'Emergency: +1 (555) 999-0000',
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
            hintStyle: GoogleFonts.inter(
              color: AppColors.textSecondaryColor,
            ),
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
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: AppColors.textSecondaryColor,
            ),
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
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred Date',
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
                      : 'Select date',
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
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: 20,
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
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.primaryColor,
            ),
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date')),
        );
        return;
      }

      // Handle form submission here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment request submitted successfully!'),
          backgroundColor: AppColors.emergencyGreenColor,
        ),
      );

      // Reset form
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
    }
  }

  double _getHorizontalPadding(BuildContext context) {
    if (Responsive.isMobile(context)) return 20;
    if (Responsive.isTablet(context)) return 40;
    return 180;
  }
}