#!/bin/bash

# Step 1: Create a new Flutter project for Widgetbook
echo "Creating a new Flutter project for Widgetbook..."
flutter create widgetbook --empty

# Step 2: Rename the project in widgetbook/pubspec.yaml to avoid naming conflicts
echo "Renaming the project in widgetbook/pubspec.yaml..."
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  sed -i '' 's/name: widgetbook/name: widgetbook_workspace/' widgetbook/pubspec.yaml
else
  # Linux
  sed -i 's/name: widgetbook/name: widgetbook_workspace/' widgetbook/pubspec.yaml
fi

# Step 3: Get the app name from the original pubspec.yaml
APP_NAME=$(grep 'name:' pubspec.yaml | head -n 1 | awk '{print $2}')
echo "Using app name from pubspec.yaml: $APP_NAME"

# Step 4: Add dependencies to the widgetbook project
echo "Adding dependencies to widgetbook project..."
cd widgetbook
flutter pub add widgetbook flutter_screenutil widgetbook_annotation dev:widgetbook_generator dev:build_runner

# Add the app dependency to the dependencies section using awk
# Ensure the app name is correctly inserted into the dependencies section in widgetbook/pubspec.yaml
awk "/dependencies:/ {print; print \"  $APP_NAME:\n    path: ../\"; next}1" pubspec.yaml > temp.yaml && mv temp.yaml pubspec.yaml

# Step 5: Create the main.dart file for the Widgetbook app with the updated structure
echo "Creating main.dart in widgetbook/lib..."
cat <<EOL > lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        /* MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
                name: 'Light',
                data: yourCustomLightTheme
            ),
            WidgetbookTheme(
                name: 'Dark',
                data: yourCustomTheme
            ),
          ],
        ),*/
        TextScaleAddon(
          min: 1.0,
          max: 2.0,
        ),
        LocalizationAddon(
          locales: [
            const Locale('en', 'US'),
          ],
          localizationsDelegates: [
            DefaultWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
          ],
        ),
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone13,
            Devices.ios.iPad,
            Devices.ios.iPad12InchesGen4,
            Devices.android.samsungGalaxyNote20,
            Devices.android.mediumPhone
          ],
        ),
        GridAddon(),
        AlignmentAddon(),
        BuilderAddon(
          name: 'SafeArea',
          builder: (_, child) => SafeArea(
            child: child,
          ),
        ),
      ],
      appBuilder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: child,
            );
          },
          child: child,
        );
      },
    );
  }
}
EOL

# Step 6: Run build_runner to generate main.directories.g.dart
echo "Running build_runner to generate main.directories.g.dart..."
dart run build_runner build -d

echo "Widgetbook setup completed successfully!"
