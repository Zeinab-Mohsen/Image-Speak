import 'package:flutter/material.dart';
import 'package:ImageSpeak/core/utils/size_utils.dart';
import 'package:ImageSpeak/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeBebasNeue =>
      theme.textTheme.bodyLarge!.bebasNeue.copyWith(
        fontSize: 16.fSize,
      );
  // Title text style
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumBlack900_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.4),
      );
  static get titleMediumGray900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray900.withOpacity(0.4),
      );
}

extension on TextStyle {
  TextStyle get beVietnam {
    return copyWith(
      fontFamily: 'Be Vietnam',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get sFProText {
    return copyWith(
      fontFamily: 'SF Pro Text',
    );
  }

  TextStyle get bebasNeue {
    return copyWith(
      fontFamily: 'Bebas Neue',
    );
  }
}
