# Flutter App: Text Recognizer and Text Summarizer using 'google_ml_kit'

This Flutter application demonstrates the use of Google’s ML Kit to implement two essential functionalities: text recognition and text summarization. The app is designed with simplicity and efficiency in mind, offering a seamless user experience across two main screens:

# Text Recognizer (Screen 1):
- Users can upload images either from the camera or the gallery, based on their preference.
- The app uses google_ml_kit to extract text from the selected images with high accuracy.
- Extracted text is then displayed to the user within the app.
  
https://github.com/user-attachments/assets/b7e7c5b5-cc87-4192-9d3c-55119297c4f9

# Text Summarizer (Screen 2):
- Users can manually copy and paste text into an input field within the app.
- The app provides high-accuracy text recognition and extraction using google_ml_kit.
- After inputting or obtaining text, users can summarize it using the Gemini API.

https://github.com/user-attachments/assets/e48fec2a-ed19-4927-8ea6-f5a2335d37b2

# Technologies Used:
- Flutter: The app is developed using Flutter, ensuring a cross-platform, high-performance experience.
- google_ml_kit: Leveraging Google’s ML Kit to handle the complex tasks of text recognition and text summarization.

# Dependencies Used:
- google_ml_kit: ^0.18.0
  - This package provides a collection of tools from Google’s ML Kit to enable on-device machine learning capabilities. In this project, it's used for high-accuracy text recognition, allowing the app to extract text from input fields or images.

- image_picker: ^1.1.2
  - The image_picker package allows users to capture images using the device's camera or select images from the gallery. In this app, it's used to support image-based text recognition (if needed).

- animated_text_kit: ^4.2.2
  - This package offers a variety of animated text effects, enhancing the user interface by making text display more dynamic and engaging. It could be used to animate text summaries or other content in the app.

- flutter_spinkit: ^5.2.1
  - flutter_spinkit provides a collection of loading indicators (spinners) that can be customized to match the app's theme. It’s useful for displaying a loading animation while the app processes text recognition or summary generation.

# Project Structure:
- Screen 1: Implements the Text Recognizer functionality.
- Screen 2: Implements the Text Summarizer functionality.

This project serves as a practical example for developers looking to integrate Google’s ML Kit into their Flutter applications, especially for tasks involving text processing.
