#!/bin/bash

# Overview
# This script automates the integration of Widgetbook into your Flutter project by generating Widgetbook
# use-cases for all widgets in the project’s `lib` directory. It scans the source directory for widgets
# (both StatelessWidget and StatefulWidget), and for each widget it creates a corresponding use-case
# in the Widgetbook project.
#
# The script:
# 1. Sets up a Widgetbook project in a `widgetbook` directory.
# 2. Scans the source code in the `lib` directory of your app for all widgets.
# 3. For each widget, it generates a use-case that wraps the widget and allows it to be viewed in the Widgetbook.
# 4. All generated use-cases are saved in the `widgetbook/lib` directory, replicating the structure
#    of the source project, and using the same widget class names.
# 5. Finally, it runs `build_runner` to generate the necessary `main.directories.g.dart` file for the Widgetbook.
#
# To use this script:
# 1. Place it in the root directory of your Flutter project (same level as `lib`, `pubspec.yaml`, etc.).
# 2. Run the script from the root directory of the project by executing `bash widgetbook_setup.sh`.


# Define source and destination directories
SOURCE_DIR="lib"  # The source directory in the root folder
DEST_DIR="widgetbook/lib"  # The destination directory for Widgetbook stories

echo "Set up Widgetbook in your procject"

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
awk "/dependencies:/ {print; print \"  $APP_NAME:\n    path: ../\"; next}1" pubspec.yaml > temp.yaml && mv temp.yaml pubspec.yaml

# Step 5: Create the main.dart file for the Widgetbook app with the updated structure
echo "Creating main.dart in widgetbook/lib..."
mkdir -p lib
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

# Step 6: Generate stories for widgets
echo "Generating Widgetbook stories for relevant widgets..."

# Function to check if the file contains a widget class that extends StatelessWidget or StatefulWidget
is_widget_file() {
    local file=$1
    if grep -qE "class [A-Za-z0-9_]+ extends (Stateless|Stateful)Widget" "$file"; then
        return 0 # True: It's a widget
    else
        return 1 # False: It's not a widget
    fi
}

# Extract widget class name
extract_widget_name() {
    local file=$1
    # Extract class name that extends StatelessWidget or StatefulWidget
    grep -m 1 -E "class [A-Za-z0-9_]+ extends (Stateless|Stateful)Widget" "$file" | sed -E 's/class ([A-Za-z0-9_]+) extends.*/\1/'
}

# Return to the root directory
cd ..

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 1
fi

# Create destination directory
mkdir -p "$DEST_DIR"

# Debug output
echo "Searching for widget files in '$SOURCE_DIR'..."
find "$SOURCE_DIR" -type f -name "*.dart" | wc -l | xargs echo "Found files:"

# Iterate through all Dart files in the source directory
find "$SOURCE_DIR" -type f -name "*.dart" | while read -r file; do
    echo "Checking file: $file"

    # Check if the file contains a widget (extends StatelessWidget or StatefulWidget)
    if is_widget_file "$file"; then
        # Extract the relative path from the source directory
        relative_path="${file#"$SOURCE_DIR"/}"

        # Extract the widget class name
        widget_name=$(extract_widget_name "$file")

        if [ -z "$widget_name" ]; then
            echo "Warning: Could not extract widget name from $file. Skipping..."
            continue
        fi

        echo "Found widget: $widget_name in $file"

        # Create the destination file path in the widgetbook/lib/src directory
        dest_file="$DEST_DIR/$relative_path"

        # Create the necessary directories in widgetbook if they don't exist
        echo "Creating directory: $(dirname "$dest_file")"
        mkdir -p "$(dirname "$dest_file")"

        # Dynamically create the import path
        import_path="package:$APP_NAME/$relative_path"

        # Write the new file with the Widgetbook UseCase wrapper
        cat <<EOL > "$dest_file"
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import '$import_path';

@widgetbook.UseCase(name: 'Default', type: $widget_name)
Widget build${widget_name}UseCase(BuildContext context) {
  return $widget_name();
}
EOL

        echo "Generated story for: $dest_file"
    else
        echo "Not a widget file, skipping."
    fi
done

# Go back to widgetbook directory to run build_runner
cd widgetbook

# Step 7: Run build_runner to generate main.directories.g.dart
echo "Running build_runner to generate main.directories.g.dart..."
flutter pub get
dart run build_runner build --delete-conflicting-outputs

echo "Widgetbook setup completed successfully! Use 'flutter run' in the 'widgetbook' directory to start Widgetbook."
echo "NOTE: The code generated by the script should always be revised and corrected where needed."