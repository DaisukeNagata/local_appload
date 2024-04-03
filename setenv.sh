#!/bin/bash
# Give execution permission to setenv.sh
# chmod +x setenv.sh source ./setenv.sh to apply the environment variables
# Use 'make export-ipa upload-to-deploygate-ios build-aab upload-to-deploygate-android' command to execute tasks
# Setting environment variables
PROJECT_NAME="Runner"
SCHEME="Runner"
OUTPUT_DIR="$(HOME)/Library/Developer/Xcode/Archives"

# Get the current date and time in Year-Month-Day_HourMinuteSecond format
ARCHIVE_DATETIME=$(date +%Y-%m-%d_%H%M%S)

# Define the archive name by appending the current date and time to the project name
ARCHIVE_NAME="${PROJECT_NAME}_${ARCHIVE_DATETIME}"

# Export environment variables
# Set API_Key to your DeployGate API key found in your DeployGate profile
# Set USERNAME...
cat <<EOF > .env
PROJECT_NAME=Runner
SCHEME=Runner
OUTPUT_DIR=$(HOME)/Library/Developer/Xcode/Archives
ARCHIVE_PATH=$(HOME)/Library/Developer/Xcode/Archives/${ARCHIVE_NAME}.xcarchive
EXPORT_PLIST=./data/ExportOptions.plist
IPA_PATH=./data/local_appload.ipa
API_Key=API_KEY
DEPLOY_GATE=https://deploygate.com/api/users/USERNAME/apps
EOF

# The lines below are added to check if the script works correctly
# They output several of the defined variables to verify the script is functioning as expected
echo "PROJECT_NAME: $PROJECT_NAME"
echo "SCHEME: $SCHEME"
echo "OUTPUT_DIR: $OUTPUT_DIR"
echo "ARCHIVE_DATETIME: $ARCHIVE_DATETIME"
echo "ARCHIVE_NAME: $ARCHIVE_NAME"
echo "ARCHIVE_PATH: $ARCHIVE_PATH"