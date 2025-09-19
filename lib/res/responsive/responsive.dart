import 'package:flutter/material.dart';

class Responsive {
  // Enhanced breakpoint definitions
  static const double _mobileSmallBreakpoint = 480;
  static const double _mobileBreakpoint = 750;
  static const double _tabletBreakpoint = 1100;
  static const double _tabletLargeBreakpoint = 1100;


  /// Original methods - unchanged for backward compatibility
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < _mobileBreakpoint;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < _tabletBreakpoint && MediaQuery.of(context).size.width >= _mobileBreakpoint;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= _tabletBreakpoint;

  /// New enhanced methods
  static bool isMobileSmall(BuildContext context) => MediaQuery.of(context).size.width < _mobileSmallBreakpoint;
  static bool isMobileLarge(BuildContext context) => MediaQuery.of(context).size.width >= _mobileSmallBreakpoint && MediaQuery.of(context).size.width < _mobileBreakpoint;
  static bool isTabletLarge(BuildContext context) => MediaQuery.of(context).size.width >= _tabletBreakpoint && MediaQuery.of(context).size.width < _tabletLargeBreakpoint;


  /// Helper method to get specific device category
  static DeviceSize getDeviceSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < _mobileSmallBreakpoint) {
      return DeviceSize.mobileSmall;
    } else if (width < _mobileBreakpoint) {
      return DeviceSize.mobileLarge;
    } else if (width < _tabletBreakpoint) {
      return DeviceSize.tablet;
    } else {
      return DeviceSize.desktop;
    }
  }

  /// Convenient value selector based on device size
  static T valueWhen<T>(
      BuildContext context, {
        required T mobile,
        T? mobileSmall,
        T? mobileLarge,
        T? tablet,
        T? tabletLarge,
        T? desktop,
      }) {
    final deviceSize = getDeviceSize(context);

    switch (deviceSize) {
      case DeviceSize.mobileSmall:
        return mobileSmall ?? mobile;
      case DeviceSize.mobileLarge:
        return mobileLarge ?? mobile;
      case DeviceSize.tablet:
        return tablet ?? mobile;
      case DeviceSize.tabletLarge:
        return tabletLarge ?? tablet ?? mobile;
      case DeviceSize.desktop:
        return desktop ?? tabletLarge ?? tablet ?? mobile;
    }
  }

  /// Responsive font size helper
  static double fontSize(
      BuildContext context,
      double baseFontSize, {
        double? mobileSmallScale,
        double? mobileLargeScale,
        double? tabletScale,
        double? tabletLargeScale,
        double? desktopScale,
      }) {
    final deviceSize = getDeviceSize(context);

    switch (deviceSize) {
      case DeviceSize.mobileSmall:
        return baseFontSize * (mobileSmallScale ?? 0.9);
      case DeviceSize.mobileLarge:
        return baseFontSize * (mobileLargeScale ?? 1.0);
      case DeviceSize.tablet:
        return baseFontSize * (tabletScale ?? 1.1);
      case DeviceSize.tabletLarge:
        return baseFontSize * (tabletLargeScale ?? 1.15);
      case DeviceSize.desktop:
        return baseFontSize * (desktopScale ?? 1.2);
    }
  }

  /// Responsive spacing helper
  static double spacing(
      BuildContext context,
      double baseSpacing, {
        double? mobileSmallMultiplier,
        double? mobileLargeMultiplier,
        double? tabletMultiplier,
        double? tabletLargeMultiplier,
        double? desktopMultiplier,
      }) {
    final deviceSize = getDeviceSize(context);

    switch (deviceSize) {
      case DeviceSize.mobileSmall:
        return baseSpacing * (mobileSmallMultiplier ?? 0.8);
      case DeviceSize.mobileLarge:
        return baseSpacing * (mobileLargeMultiplier ?? 1.0);
      case DeviceSize.tablet:
        return baseSpacing * (tabletMultiplier ?? 1.2);
      case DeviceSize.tabletLarge:
        return baseSpacing * (tabletLargeMultiplier ?? 1.3);
      case DeviceSize.desktop:
        return baseSpacing * (desktopMultiplier ?? 1.4);
    }
  }
}

/// Device size enumeration
enum DeviceSize {
  mobileSmall,  // < 480px
  mobileLarge,  // 480px - 750px
  tablet,       // 750px - 1024px (Standard tablets)
  tabletLarge,  // 1024px - 1100px (iPad Pro, large tablets)
  desktop,      // >= 1100px
}

/// Extension for cleaner syntax
extension ResponsiveContext on BuildContext {
  bool get isMobile => Responsive.isMobile(this);
  bool get isMobileSmall => Responsive.isMobileSmall(this);
  bool get isMobileLarge => Responsive.isMobileLarge(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isTabletLarge => Responsive.isTabletLarge(this);
  bool get isDesktop => Responsive.isDesktop(this);
  DeviceSize get deviceSize => Responsive.getDeviceSize(this);
}