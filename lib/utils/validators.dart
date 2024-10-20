class Validators {
  // Validate phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  // Validate OTP (assuming a 6-digit OTP)
  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length != 6 || !RegExp(r'^[0-9]{6}$').hasMatch(value)) {
      return 'Enter a valid 6-digit OTP';
    }
    return null;
  }

  // Validate vehicle registration number
  static String? validateVehicleRegNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vehicle registration number is required';
    }
    // Example pattern for vehicle registration (customize based on locale)
    if (!RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z]{1,2}[0-9]{4}$').hasMatch(value)) {
      return 'Enter a valid vehicle registration number';
    }
    return null;
  }

  // Validate license number
  static String? validateLicenseNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'License number is required';
    }
    // Customize the pattern based on the format of license numbers
    if (!RegExp(r'^[A-Z0-9]{5,15}$').hasMatch(value)) {
      return 'Enter a valid license number';
    }
    return null;
  }

  // Validate owner name (no numbers or special characters, only alphabets and spaces allowed)
  static String? validateOwnerName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Owner name is required';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Owner name should contain only alphabets';
    }
    return null;
  }

  // Validate number of vehicles (should be a positive integer)
  static String? validateNumberOfVehicles(String? value) {
    if (value == null || value.isEmpty) {
      return 'Number of vehicles is required';
    }
    int? vehicles = int.tryParse(value);
    if (vehicles == null || vehicles <= 0) {
      return 'Enter a valid number of vehicles greater than 0';
    }
    return null;
  }

  // Validate email address (optional if your app uses email input)
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Validate membership code (if applicable)
  static String? validateMembershipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Membership code is required';
    }
    if (value.length < 4) {
      return 'Membership code must be at least 4 characters';
    }
    return null;
  }
}
