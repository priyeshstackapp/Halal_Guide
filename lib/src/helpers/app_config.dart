import 'package:flutter/material.dart';

import '../repository/settings_repository.dart' as settingRepo;

class App {
  BuildContext _context;
  double _height;
  double _width;
  double _heightPadding;
  double _widthPadding;

  App(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height - ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding = _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
//    int.parse(settingRepo.setting.mainColor.replaceAll("#", "0xFF"));
    return _widthPadding * v;
  }

  static Map<String, dynamic> cardMapData = {};


  //Stripe payment key
  static String publicKey() {
    // return "Bearer pk_test_51GtFPIGadoDyDn9h84SFcu3EvDvuVOSV24cEO2GR2gaTufZOid8T6M4MrsilsXZaNnZayc9RuyD8RpVOJfqRz1ng00HMGiRGIb";
    return "Bearer pk_test_51I2Va0FWDFJAlIu6aS3Wb0r1q1LAEeRYHi86B3YH0dBG685AeMBegonROIn4pkegMH1j7XbX9QXQ2Vdvea64k41Y006FSV7Jsx";
  }

  static String secretKey() {
    // return "Bearer sk_test_51GtFPIGadoDyDn9hosyt1CFS8bqqblI3VhPXlrL9odQ2EqSrddzOpkfAikuODq7pV8DiT5wki1MDzMaFozqcNS3k00nIoMjPSg";
    return "Bearer sk_test_51I2Va0FWDFJAlIu6oHYtovX6vG1GlrfCIA0gLvgmtgBgBCJi1duoZmcO5oXIrJTUlP8mfc6BhXdfFtTpEvCrASaH001Wi6qEts";
  }

  //facebook post key : -

  static String userAccessToken() {
    return "EAAP32ZAZBpSyUBAF4x5ZBk9bmEN3yGeLh62MXCUCCM6ZA4YI9mm0xbH2SrZCZCRuVaqQ4zvZA58p06oV62f3xPHcmJf5E8h97Q4fJa6IDXnnRCT9e04s7JeGJ6e9PMRgx6q1rTfI5C0ASyhINRW6O111OHZClHsuIXyZBVZABHW9BuvjNIYiCOMv5F";
    // return "EAAGnZBvByjtUBAMgNdcGYXFH2amVEihEty6dZCJFxXrpQ7kvidvZCFzhQkxhAptoEq2KDfEj0cXWAmAq6fZAvSvznbwTmt10e0YD0FOrMTi6SS1jGGLu2jnp3smwbjBlpBTG1gozKRhlQmBZAxQDIAEVJsNvPpjSVZCfbtaDGoH91ASV2kAFtk";
  }

  static String pageAccessToken() {
    return "EAAP32ZAZBpSyUBAELgUQEaCV06bihlL5kaThmONVxcspYkDB9HnsEjGkwkPxZAP8RL7LH7lC55GzBIk0NumS7DqCAU72HXo3aFkjTDDowxfVi9oaYZCY0uvxuL5wwrvNTebEXjBp60W3mIDWNTyxoOUZCk6iupGFPFxtFiLnCnizbmFBiJgbApeHyYDYq8jgZD";
    // return "EAAGnZBvByjtUBALGcr3KCueZCML02TVT2QZAHwsq5xAQZBzrIbJJnAGen32jctki3z12jz5hgeBYFTHnZCHqGL8uwhVYhkXohsactQonRwc46HaUyC29n4EGbuQxJOU0vIwyFrEUX0TJdo1W6soB1utoS0zu6zh7t25qxsALqGHl1fttJZA0LwigJrtbHoyfIZD";
  }

  static String userId() {
    return "540950906805060";
    // return "105274734884308";
  }

  static String pageId() {
    return "352657749159512";
    // return "102004228553987";
  }

}

class Colors {
  Color mainColor(double opacity) {
    try {
      return Color(int.parse(settingRepo.setting.value.mainColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color secondColor(double opacity) {
    try {
      return Color(int.parse(settingRepo.setting.value.secondColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color accentColor(double opacity) {
    try {
      return Color(int.parse(settingRepo.setting.value.accentColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color mainDarkColor(double opacity) {
    try {
      return Color(int.parse(settingRepo.setting.value.mainDarkColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color secondDarkColor(double opacity) {
    try {
      return Color(int.parse(settingRepo.setting.value.secondDarkColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color accentDarkColor(double opacity) {
    try {
      return Color(int.parse(settingRepo.setting.value.accentDarkColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color scaffoldColor(double opacity) {
    // TODO test if brightness is dark or not
    try {
      return Color(int.parse(settingRepo.setting.value.scaffoldColor.replaceAll("#", "0xFF"))).withOpacity(opacity);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }
}
