import 'package:ImageSpeak/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:ImageSpeak/core/app_export.dart';
import '../../widgets/custom_image_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 16.h,
            top: 94.v,
            right: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFourteen(context),
              Container(
                width: 302.h,
                margin: EdgeInsets.only(
                  left: 12.h,
                  right: 46.h,
                ),
                child: Text(
                  "With Image Speak, users can translate their photos into words in any language they want and pronounce them in real-time",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.bodyLargeBebasNeue.copyWith(
                    height: 1.38,
                  ),
                ),
              ),
              SizedBox(height: 61.v),
              CustomOutlinedButton(
                width: 79.h,
                text: "Start",
                margin: EdgeInsets.only(right: 25.h),
                onPressed: () {
                  onTapStart(context);
                },
                alignment: Alignment.centerRight,
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFourteen(BuildContext context) {
    return SizedBox(
      height: 374.v,
      width: 354.h,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          CustomImageView(
            imagePath: 'assets/images/img_image_1.png',
            height: 355.v,
            width: 354.h,
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 12.h),
              child: Text(
                "Let your image talk",
                style: theme.textTheme.headlineMedium,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the cameraScreen when the action is triggered.
  onTapStart(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.cameraScreen);
  }
}
