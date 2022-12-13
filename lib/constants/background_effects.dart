class BackgroundEffects {
  static const loginPageSensitivity = 10;
  static const homePageSensitivity = 10;
  static const profilePageSensitivity = 10;
  static const chatPageSensitivity = 5;
  static const maxSensitivity = 10;
  static const animationDuration = 250;

  static const blurLight = 5.0;
  static const blurMedium = 10.0;
  static const blurHeavy = 30.0;

  static double accelerometerF(double value, int sensitivity) =>
      -maxSensitivity * sensitivity + value * sensitivity;
  static double accelerometerR(double value, int sensitivity) =>
      -maxSensitivity * sensitivity - value * sensitivity;
}

