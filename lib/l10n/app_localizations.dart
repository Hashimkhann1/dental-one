import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @dentist.
  ///
  /// In en, this message translates to:
  /// **'Dentist'**
  String get dentist;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @ourExperts.
  ///
  /// In en, this message translates to:
  /// **'Our Experts'**
  String get ourExperts;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @homeHeadingSmile.
  ///
  /// In en, this message translates to:
  /// **'Your Smile is Our'**
  String get homeHeadingSmile;

  /// No description provided for @homeHeadingPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get homeHeadingPriority;

  /// No description provided for @homeParagraph.
  ///
  /// In en, this message translates to:
  /// **'Experience exceptional dental care with our team of expert dentists. We provide comprehensive, gentle, and personalized treatment in a modern, comfortable environment.'**
  String get homeParagraph;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @viewServices.
  ///
  /// In en, this message translates to:
  /// **'View Services'**
  String get viewServices;

  /// No description provided for @safeCare.
  ///
  /// In en, this message translates to:
  /// **'Safe Care'**
  String get safeCare;

  /// No description provided for @latestProtocols.
  ///
  /// In en, this message translates to:
  /// **'Latest\nProtocols'**
  String get latestProtocols;

  /// No description provided for @expertTeam.
  ///
  /// In en, this message translates to:
  /// **'Expert Team'**
  String get expertTeam;

  /// No description provided for @certifiedProfessionals.
  ///
  /// In en, this message translates to:
  /// **'Certified\nProfessionals'**
  String get certifiedProfessionals;

  /// No description provided for @fivek.
  ///
  /// In en, this message translates to:
  /// **'5000+'**
  String get fivek;

  /// No description provided for @happyPatients.
  ///
  /// In en, this message translates to:
  /// **'Happy Patients'**
  String get happyPatients;

  /// No description provided for @thenPlus.
  ///
  /// In en, this message translates to:
  /// **'10+'**
  String get thenPlus;

  /// No description provided for @yearExperience.
  ///
  /// In en, this message translates to:
  /// **'Years of Experience'**
  String get yearExperience;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About DentalCare Clinic'**
  String get aboutTitle;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'For over a decade, DentalCare Clinic has been committed to providing exceptional dental care to our community. We combine advanced technology with a gentle, personalized approach to ensure every patient receives the best possible treatment in a comfortable, welcoming environment.'**
  String get aboutDescription;

  /// No description provided for @featurePatientCareTitle.
  ///
  /// In en, this message translates to:
  /// **'Patient-Centered Care'**
  String get featurePatientCareTitle;

  /// No description provided for @featurePatientCareSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We prioritize your comfort and safety in every treatment decision.'**
  String get featurePatientCareSubtitle;

  /// No description provided for @featureExcellenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Excellence in Dentistry'**
  String get featureExcellenceTitle;

  /// No description provided for @featureExcellenceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Our team maintains the highest standards of professional excellence.'**
  String get featureExcellenceSubtitle;

  /// No description provided for @featureExperiencedTeamTitle.
  ///
  /// In en, this message translates to:
  /// **'Experienced Team'**
  String get featureExperiencedTeamTitle;

  /// No description provided for @featureExperiencedTeamSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Our dentists have decades of combined experience in dental care.'**
  String get featureExperiencedTeamSubtitle;

  /// No description provided for @featureSchedulingTitle.
  ///
  /// In en, this message translates to:
  /// **'Flexible Scheduling'**
  String get featureSchedulingTitle;

  /// No description provided for @featureSchedulingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Convenient hours and easy online booking to fit your busy lifestyle.'**
  String get featureSchedulingSubtitle;

  /// No description provided for @missionTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Mission'**
  String get missionTitle;

  /// No description provided for @missionDescription.
  ///
  /// In en, this message translates to:
  /// **'We believe everyone deserves access to quality dental care. Our mission is to provide comprehensive, compassionate, and affordable dental services while educating our patients about optimal oral health practices.'**
  String get missionDescription;

  /// No description provided for @missionPoint1.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive dental services'**
  String get missionPoint1;

  /// No description provided for @missionPoint2.
  ///
  /// In en, this message translates to:
  /// **'State-of-the-art technology'**
  String get missionPoint2;

  /// No description provided for @missionPoint3.
  ///
  /// In en, this message translates to:
  /// **'Comfortable patient experience'**
  String get missionPoint3;

  /// No description provided for @statYearsOfService.
  ///
  /// In en, this message translates to:
  /// **'Years of Service'**
  String get statYearsOfService;

  /// No description provided for @statHappyPatients.
  ///
  /// In en, this message translates to:
  /// **'Happy Patients'**
  String get statHappyPatients;

  /// No description provided for @statExpertDentists.
  ///
  /// In en, this message translates to:
  /// **'Expert Dentists'**
  String get statExpertDentists;

  /// No description provided for @statEmergencyCare.
  ///
  /// In en, this message translates to:
  /// **'Emergency Care'**
  String get statEmergencyCare;

  /// No description provided for @servicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Dental Services'**
  String get servicesTitle;

  /// No description provided for @servicesDescription.
  ///
  /// In en, this message translates to:
  /// **'We offer a comprehensive range of dental services to meet all your oral health needs. From routine cleanings to advanced procedures, our expert team is here to help you achieve and maintain optimal dental health.'**
  String get servicesDescription;

  /// No description provided for @serviceGeneralTitle.
  ///
  /// In en, this message translates to:
  /// **'General Dentistry'**
  String get serviceGeneralTitle;

  /// No description provided for @serviceGeneralDescription.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive oral care including cleanings, fillings, and preventive treatments.'**
  String get serviceGeneralDescription;

  /// No description provided for @serviceGeneralFeature1.
  ///
  /// In en, this message translates to:
  /// **'Regular Cleanings'**
  String get serviceGeneralFeature1;

  /// No description provided for @serviceGeneralFeature2.
  ///
  /// In en, this message translates to:
  /// **'Cavity Fillings'**
  String get serviceGeneralFeature2;

  /// No description provided for @serviceGeneralFeature3.
  ///
  /// In en, this message translates to:
  /// **'Oral Examinations'**
  String get serviceGeneralFeature3;

  /// No description provided for @serviceGeneralFeature4.
  ///
  /// In en, this message translates to:
  /// **'Fluoride Treatments'**
  String get serviceGeneralFeature4;

  /// No description provided for @serviceCosmeticTitle.
  ///
  /// In en, this message translates to:
  /// **'Cosmetic Dentistry'**
  String get serviceCosmeticTitle;

  /// No description provided for @serviceCosmeticDescription.
  ///
  /// In en, this message translates to:
  /// **'Enhance your smile with our advanced cosmetic dentistry procedures.'**
  String get serviceCosmeticDescription;

  /// No description provided for @serviceCosmeticFeature1.
  ///
  /// In en, this message translates to:
  /// **'Teeth Whitening'**
  String get serviceCosmeticFeature1;

  /// No description provided for @serviceCosmeticFeature2.
  ///
  /// In en, this message translates to:
  /// **'Veneers'**
  String get serviceCosmeticFeature2;

  /// No description provided for @serviceCosmeticFeature3.
  ///
  /// In en, this message translates to:
  /// **'Bonding'**
  String get serviceCosmeticFeature3;

  /// No description provided for @serviceCosmeticFeature4.
  ///
  /// In en, this message translates to:
  /// **'Smile Makeover'**
  String get serviceCosmeticFeature4;

  /// No description provided for @serviceOrthoTitle.
  ///
  /// In en, this message translates to:
  /// **'Orthodontics'**
  String get serviceOrthoTitle;

  /// No description provided for @serviceOrthoDescription.
  ///
  /// In en, this message translates to:
  /// **'Straighten your teeth with traditional braces or modern clear aligners.'**
  String get serviceOrthoDescription;

  /// No description provided for @serviceOrthoFeature1.
  ///
  /// In en, this message translates to:
  /// **'Metal Braces'**
  String get serviceOrthoFeature1;

  /// No description provided for @serviceOrthoFeature2.
  ///
  /// In en, this message translates to:
  /// **'Clear Aligners'**
  String get serviceOrthoFeature2;

  /// No description provided for @serviceOrthoFeature3.
  ///
  /// In en, this message translates to:
  /// **'Retainers'**
  String get serviceOrthoFeature3;

  /// No description provided for @serviceOrthoFeature4.
  ///
  /// In en, this message translates to:
  /// **'Bite Correction'**
  String get serviceOrthoFeature4;

  /// No description provided for @serviceEmergencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency Care'**
  String get serviceEmergencyTitle;

  /// No description provided for @serviceEmergencyDescription.
  ///
  /// In en, this message translates to:
  /// **'Immediate care for urgent and emergency dental situations.'**
  String get serviceEmergencyDescription;

  /// No description provided for @serviceEmergencyFeature1.
  ///
  /// In en, this message translates to:
  /// **'24/7 Availability'**
  String get serviceEmergencyFeature1;

  /// No description provided for @serviceEmergencyFeature2.
  ///
  /// In en, this message translates to:
  /// **'Pain Relief'**
  String get serviceEmergencyFeature2;

  /// No description provided for @serviceEmergencyFeature3.
  ///
  /// In en, this message translates to:
  /// **'Emergency Repairs'**
  String get serviceEmergencyFeature3;

  /// No description provided for @serviceEmergencyFeature4.
  ///
  /// In en, this message translates to:
  /// **'Same-Day Treatment'**
  String get serviceEmergencyFeature4;

  /// No description provided for @serviceSurgeryTitle.
  ///
  /// In en, this message translates to:
  /// **'Oral Surgery'**
  String get serviceSurgeryTitle;

  /// No description provided for @serviceSurgeryDescription.
  ///
  /// In en, this message translates to:
  /// **'Precise surgical procedures performed by specialized dentists with utmost care.'**
  String get serviceSurgeryDescription;

  /// No description provided for @serviceSurgeryFeature1.
  ///
  /// In en, this message translates to:
  /// **'Tooth Extractions'**
  String get serviceSurgeryFeature1;

  /// No description provided for @serviceSurgeryFeature2.
  ///
  /// In en, this message translates to:
  /// **'Wisdom Teeth'**
  String get serviceSurgeryFeature2;

  /// No description provided for @serviceSurgeryFeature3.
  ///
  /// In en, this message translates to:
  /// **'Implant Surgery'**
  String get serviceSurgeryFeature3;

  /// No description provided for @serviceSurgeryFeature4.
  ///
  /// In en, this message translates to:
  /// **'Gum Surgery'**
  String get serviceSurgeryFeature4;

  /// No description provided for @servicePediatricTitle.
  ///
  /// In en, this message translates to:
  /// **'Pediatric Dentistry'**
  String get servicePediatricTitle;

  /// No description provided for @servicePediatricDescription.
  ///
  /// In en, this message translates to:
  /// **'Specialized dental care for children and adolescents.'**
  String get servicePediatricDescription;

  /// No description provided for @servicePediatricFeature1.
  ///
  /// In en, this message translates to:
  /// **'Kid-Friendly Environment'**
  String get servicePediatricFeature1;

  /// No description provided for @servicePediatricFeature2.
  ///
  /// In en, this message translates to:
  /// **'Preventive Care'**
  String get servicePediatricFeature2;

  /// No description provided for @servicePediatricFeature3.
  ///
  /// In en, this message translates to:
  /// **'Sealants'**
  String get servicePediatricFeature3;

  /// No description provided for @servicePediatricFeature4.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get servicePediatricFeature4;

  /// No description provided for @footerTitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t see what you\'re looking for?'**
  String get footerTitle;

  /// No description provided for @footerDescription.
  ///
  /// In en, this message translates to:
  /// **'We offer many additional specialized services. Contact us to discuss your specific needs and we\'ll help you find the right treatment plan.'**
  String get footerDescription;

  /// No description provided for @footerButton.
  ///
  /// In en, this message translates to:
  /// **'Contact Us Today'**
  String get footerButton;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @expertTeamTitle.
  ///
  /// In en, this message translates to:
  /// **'Meet Our Expert Team'**
  String get expertTeamTitle;

  /// No description provided for @expertTeamDescription.
  ///
  /// In en, this message translates to:
  /// **'Our team of experienced professionals is dedicated to providing the highest level of care. Each member brings unique expertise and a shared commitment to your oral health and comfort.'**
  String get expertTeamDescription;

  /// No description provided for @drSarahJohnson.
  ///
  /// In en, this message translates to:
  /// **'Dr. Sarah Johnson'**
  String get drSarahJohnson;

  /// No description provided for @drSarahRole.
  ///
  /// In en, this message translates to:
  /// **'Lead Dentist & Practice Director'**
  String get drSarahRole;

  /// No description provided for @drSarahExperience.
  ///
  /// In en, this message translates to:
  /// **'15+ Years'**
  String get drSarahExperience;

  /// No description provided for @drSarahDescription.
  ///
  /// In en, this message translates to:
  /// **'Dr. Johnson is passionate about creating healthy, beautiful smiles using the latest dental technology.'**
  String get drSarahDescription;

  /// No description provided for @drSarahEducation.
  ///
  /// In en, this message translates to:
  /// **'DDS, Harvard School of Dental Medicine'**
  String get drSarahEducation;

  /// No description provided for @drSarahExpertise1.
  ///
  /// In en, this message translates to:
  /// **'General Dentistry'**
  String get drSarahExpertise1;

  /// No description provided for @drSarahExpertise2.
  ///
  /// In en, this message translates to:
  /// **'Cosmetic Procedures'**
  String get drSarahExpertise2;

  /// No description provided for @drMichaelChen.
  ///
  /// In en, this message translates to:
  /// **'Dr. Michael Chen'**
  String get drMichaelChen;

  /// No description provided for @drMichaelRole.
  ///
  /// In en, this message translates to:
  /// **'Orthodontist & Oral Surgery Specialist'**
  String get drMichaelRole;

  /// No description provided for @drMichaelExperience.
  ///
  /// In en, this message translates to:
  /// **'12+ Years'**
  String get drMichaelExperience;

  /// No description provided for @drMichaelDescription.
  ///
  /// In en, this message translates to:
  /// **'Dr. Chen specializes in orthodontics and oral surgery, combining precision with patient comfort in every procedure.'**
  String get drMichaelDescription;

  /// No description provided for @drMichaelEducation.
  ///
  /// In en, this message translates to:
  /// **'DDS, University of Pennsylvania'**
  String get drMichaelEducation;

  /// No description provided for @drMichaelExpertise1.
  ///
  /// In en, this message translates to:
  /// **'Orthodontics'**
  String get drMichaelExpertise1;

  /// No description provided for @drMichaelExpertise2.
  ///
  /// In en, this message translates to:
  /// **'Oral Surgery'**
  String get drMichaelExpertise2;

  /// No description provided for @drMichaelExpertise3.
  ///
  /// In en, this message translates to:
  /// **'Dental Implants'**
  String get drMichaelExpertise3;

  /// No description provided for @drEmilyRodriguez.
  ///
  /// In en, this message translates to:
  /// **'Dr. Emily Rodriguez'**
  String get drEmilyRodriguez;

  /// No description provided for @drEmilyRole.
  ///
  /// In en, this message translates to:
  /// **'Pediatric Dentist'**
  String get drEmilyRole;

  /// No description provided for @drEmilyExperience.
  ///
  /// In en, this message translates to:
  /// **'8+ Years'**
  String get drEmilyExperience;

  /// No description provided for @drEmilyDescription.
  ///
  /// In en, this message translates to:
  /// **'Dr. Rodriguez provides a fun, comfortable environment for children while delivering exceptional pediatric dental care.'**
  String get drEmilyDescription;

  /// No description provided for @drEmilyEducation.
  ///
  /// In en, this message translates to:
  /// **'DDS, UCLA School of Dentistry'**
  String get drEmilyEducation;

  /// No description provided for @drEmilyExpertise1.
  ///
  /// In en, this message translates to:
  /// **'Pediatric Dentistry'**
  String get drEmilyExpertise1;

  /// No description provided for @drEmilyExpertise2.
  ///
  /// In en, this message translates to:
  /// **'Preventive Care'**
  String get drEmilyExpertise2;

  /// No description provided for @whyChooseTeamTitle.
  ///
  /// In en, this message translates to:
  /// **'Why Choose Our Team?'**
  String get whyChooseTeamTitle;

  /// No description provided for @whyChooseBoardCertifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'Board Certified'**
  String get whyChooseBoardCertifiedTitle;

  /// No description provided for @whyChooseBoardCertifiedDescription.
  ///
  /// In en, this message translates to:
  /// **'All our dentists are board-certified and maintain continuing education.'**
  String get whyChooseBoardCertifiedDescription;

  /// No description provided for @whyChooseTrainingTitle.
  ///
  /// In en, this message translates to:
  /// **'Extensive Training'**
  String get whyChooseTrainingTitle;

  /// No description provided for @whyChooseTrainingDescription.
  ///
  /// In en, this message translates to:
  /// **'Graduates of top dental schools with specialized training.'**
  String get whyChooseTrainingDescription;

  /// No description provided for @whyChooseLocalTitle.
  ///
  /// In en, this message translates to:
  /// **'Local Expertise'**
  String get whyChooseLocalTitle;

  /// No description provided for @whyChooseLocalDescription.
  ///
  /// In en, this message translates to:
  /// **'Deep understanding of community dental health needs.'**
  String get whyChooseLocalDescription;

  /// No description provided for @bookYourAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Your Appointment'**
  String get bookYourAppointment;

  /// No description provided for @bookAppointmentDescription.
  ///
  /// In en, this message translates to:
  /// **'Schedule your dental appointment with our team of experts. We offer flexible scheduling and comprehensive dental services to meet all your oral health needs.'**
  String get bookAppointmentDescription;

  /// No description provided for @scheduleYourVisit.
  ///
  /// In en, this message translates to:
  /// **'Schedule Your Visit'**
  String get scheduleYourVisit;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// No description provided for @pleaseEnterFullName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get pleaseEnterFullName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumber;

  /// No description provided for @pleaseEnterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhoneNumber;

  /// No description provided for @serviceNeeded.
  ///
  /// In en, this message translates to:
  /// **'Service Needed'**
  String get serviceNeeded;

  /// No description provided for @selectService.
  ///
  /// In en, this message translates to:
  /// **'Select a service'**
  String get selectService;

  /// No description provided for @pleaseSelectService.
  ///
  /// In en, this message translates to:
  /// **'Please select a service'**
  String get pleaseSelectService;

  /// No description provided for @serviceGeneralCheckup.
  ///
  /// In en, this message translates to:
  /// **'General Checkup'**
  String get serviceGeneralCheckup;

  /// No description provided for @serviceTeethCleaning.
  ///
  /// In en, this message translates to:
  /// **'Teeth Cleaning'**
  String get serviceTeethCleaning;

  /// No description provided for @serviceCosmeticDentistry.
  ///
  /// In en, this message translates to:
  /// **'Cosmetic Dentistry'**
  String get serviceCosmeticDentistry;

  /// No description provided for @serviceOrthodontics.
  ///
  /// In en, this message translates to:
  /// **'Orthodontics'**
  String get serviceOrthodontics;

  /// No description provided for @serviceOralSurgery.
  ///
  /// In en, this message translates to:
  /// **'Oral Surgery'**
  String get serviceOralSurgery;

  /// No description provided for @serviceEmergencyCare.
  ///
  /// In en, this message translates to:
  /// **'Emergency Care'**
  String get serviceEmergencyCare;

  /// No description provided for @preferredDate.
  ///
  /// In en, this message translates to:
  /// **'Preferred Date'**
  String get preferredDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get selectDate;

  /// No description provided for @pleaseSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Please select a date'**
  String get pleaseSelectDate;

  /// No description provided for @preferredTime.
  ///
  /// In en, this message translates to:
  /// **'Preferred Time'**
  String get preferredTime;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select a time'**
  String get selectTime;

  /// No description provided for @pleaseSelectTime.
  ///
  /// In en, this message translates to:
  /// **'Please select a time'**
  String get pleaseSelectTime;

  /// No description provided for @timeSlot9am.
  ///
  /// In en, this message translates to:
  /// **'9:00 AM'**
  String get timeSlot9am;

  /// No description provided for @timeSlot10am.
  ///
  /// In en, this message translates to:
  /// **'10:00 AM'**
  String get timeSlot10am;

  /// No description provided for @timeSlot11am.
  ///
  /// In en, this message translates to:
  /// **'11:00 AM'**
  String get timeSlot11am;

  /// No description provided for @timeSlot2pm.
  ///
  /// In en, this message translates to:
  /// **'2:00 PM'**
  String get timeSlot2pm;

  /// No description provided for @timeSlot3pm.
  ///
  /// In en, this message translates to:
  /// **'3:00 PM'**
  String get timeSlot3pm;

  /// No description provided for @timeSlot4pm.
  ///
  /// In en, this message translates to:
  /// **'4:00 PM'**
  String get timeSlot4pm;

  /// No description provided for @timeSlot5pm.
  ///
  /// In en, this message translates to:
  /// **'5:00 PM'**
  String get timeSlot5pm;

  /// No description provided for @additionalNotes.
  ///
  /// In en, this message translates to:
  /// **'Additional Notes'**
  String get additionalNotes;

  /// No description provided for @additionalNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Any specific concerns or requests...'**
  String get additionalNotesHint;

  /// No description provided for @requestAppointment.
  ///
  /// In en, this message translates to:
  /// **'Request Appointment'**
  String get requestAppointment;

  /// No description provided for @sendingAppointmentRequest.
  ///
  /// In en, this message translates to:
  /// **'Sending appointment request...'**
  String get sendingAppointmentRequest;

  /// No description provided for @appointmentSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your appointment request has been sent successfully! Our team will contact you soon to confirm.'**
  String get appointmentSuccessMessage;

  /// No description provided for @appointmentFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to send appointment request. Please try again.'**
  String get appointmentFailedMessage;

  /// No description provided for @emailConfigError.
  ///
  /// In en, this message translates to:
  /// **'Email service configuration error. Please contact support.'**
  String get emailConfigError;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection and try again.'**
  String get networkError;

  /// No description provided for @newAppointmentRequestSubject.
  ///
  /// In en, this message translates to:
  /// **'🦷 New Dental Appointment Request'**
  String get newAppointmentRequestSubject;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @contactPhone.
  ///
  /// In en, this message translates to:
  /// **'+1 (555) 123-4567'**
  String get contactPhone;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'info@dentalcare.com'**
  String get contactEmail;

  /// No description provided for @contactAddress.
  ///
  /// In en, this message translates to:
  /// **'123 Dental Street\nHealthy City, HC 12345'**
  String get contactAddress;

  /// No description provided for @officeHours.
  ///
  /// In en, this message translates to:
  /// **'Office Hours'**
  String get officeHours;

  /// No description provided for @mondayFriday.
  ///
  /// In en, this message translates to:
  /// **'Monday - Friday'**
  String get mondayFriday;

  /// No description provided for @mondayFridayHours.
  ///
  /// In en, this message translates to:
  /// **'8:00 AM - 6:00 PM'**
  String get mondayFridayHours;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @saturdayHours.
  ///
  /// In en, this message translates to:
  /// **'9:00 AM - 4:00 PM'**
  String get saturdayHours;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @emergencyCareTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency Care'**
  String get emergencyCareTitle;

  /// No description provided for @emergencyCareDescription.
  ///
  /// In en, this message translates to:
  /// **'We offer 24/7 emergency dental care for urgent situations. Call us immediately in case of dental emergencies.'**
  String get emergencyCareDescription;

  /// No description provided for @emergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Emergency: +1 (555) 999-0000'**
  String get emergencyContact;

  /// No description provided for @visitOurClinic.
  ///
  /// In en, this message translates to:
  /// **'Visit Our Clinic'**
  String get visitOurClinic;

  /// No description provided for @visitClinicDescription.
  ///
  /// In en, this message translates to:
  /// **'Find us easily at our convenient location. We\'re here to serve you with exceptional dental care.'**
  String get visitClinicDescription;

  /// No description provided for @clinicLocation.
  ///
  /// In en, this message translates to:
  /// **'Clinic Location'**
  String get clinicLocation;

  /// No description provided for @getDirections.
  ///
  /// In en, this message translates to:
  /// **'Get Directions'**
  String get getDirections;

  /// No description provided for @callClinic.
  ///
  /// In en, this message translates to:
  /// **'Call Clinic'**
  String get callClinic;

  /// No description provided for @footerDentalCareTitle.
  ///
  /// In en, this message translates to:
  /// **'DentalCare'**
  String get footerDentalCareTitle;

  /// No description provided for @footerDentalCareDescription.
  ///
  /// In en, this message translates to:
  /// **'Providing exceptional dental care with a focus on patient comfort, advanced technology, and personalized treatment plans.'**
  String get footerDentalCareDescription;

  /// No description provided for @footerQuickLinks.
  ///
  /// In en, this message translates to:
  /// **'Quick Links'**
  String get footerQuickLinks;

  /// No description provided for @footerOfficeHours.
  ///
  /// In en, this message translates to:
  /// **'Mon-Fri: 8AM-6PM\nSat: 9AM-3PM\nSun: Emergency Only'**
  String get footerOfficeHours;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 DentalCare Clinic. All rights reserved.'**
  String get footerCopyright;

  /// No description provided for @footerPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get footerPrivacyPolicy;

  /// No description provided for @footerTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get footerTermsOfService;

  /// No description provided for @footerCookiePolicy.
  ///
  /// In en, this message translates to:
  /// **'Cookie Policy'**
  String get footerCookiePolicy;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
