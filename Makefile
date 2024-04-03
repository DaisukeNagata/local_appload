.PHONY: help setup build clean generate watch build-ios archive-ios export-ipa upload-to-appstore ios all build-aab upload-aab deploy-android load-env

include .env
export

help:
	@echo "Usage: "
	@echo "make [command]"
	@echo "Commands:"
	@echo "  setup - install dependencies and prepare project"
	@echo "  clean - clean the build directories"
	@echo "  watch - watch changes and build auto-generated files for Riverpod, Freezed"
	@echo "  ios - build, archive, export, and upload iOS app to App Store"
	@echo "  deploy-android - build and upload Android App Bundle to Google Play Store"

setup:
	flutter pub get

clean:
	@echo "Cleaning build directories..."
	flutter clean

build-ios:
	flutter build ios --release

build-aab:
	flutter build appbundle --release

archive-ios: build-ios
	@echo "Archiving the iOS app..."
	xcodebuild archive -scheme ${SCHEME} -workspace ./ios/Runner.xcworkspace -archivePath ${ARCHIVE_PATH}

export-ipa: archive-ios
	xcodebuild -exportArchive -archivePath ${ARCHIVE_PATH} -exportOptionsPlist "${EXPORT_PLIST}" -exportPath "./data"

upload-to-deploygate-ios: export-ipa
	@echo "Uploading .ipa to DeployGate..."
	curl -F "file=@${IPA_PATH}" -F "token=${API_Key}" ${DEPLOY_GATE}
	@echo "Uploading .ipa to DeployGate SUCCEEDED"

upload-to-deploygate-android: build-aab
	@echo "Uploading .aab to DeployGate..."
	curl -F "file=@./build/app/outputs/bundle/release/app-release.aab" -F "token=${API_Key}" ${DEPLOY_GATE}
	@echo "Uploading .aab to DeployGate SUCCEEDED"
