# Labeeb: Sign Language Translator

## Introduction
Labeeb is a Sign Language Translator project aims to bridge communication barriers by developing a mobile application that can translate sign language gestures into text in real-time. Leveraging the power of machine learning and mobile technology, this project provides a practical solution for individuals with hearing impairments to communicate more effectively.

## Implementation Details
The project involves several key components and processes:

### Tools and Technologies
- **Flutter**: A versatile framework for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Camera Package**: Utilized to access the device's camera and capture live video streams.
- **Teachable Machine**: Google's platform for training machine learning models with minimal coding, ideal for our gesture recognition model.
- **Tflite**: Framework for deploying machine learning models on mobile and embedded devices, essential for integrating the trained model into the Flutter application.

### Model Training
Training the machine learning model involved selecting an appropriate dataset of sign language gestures and utilizing Google's Teachable Machine platform for model training. Due to resource constraints, a smaller dataset was chosen for initial training, with future plans to expand it for improved accuracy.

### Application Development
The Flutter framework facilitated the development of the mobile application, providing a robust foundation for building user interfaces and handling camera input. The application captures live video streams from the device's camera, processes them using the Tflite framework, and displays the recognized sign language gestures as text on the screen in real-time.

## Challenges and Future Improvements
### Challenges Faced
- **Version Compatibility**: Ensuring compatibility between different versions of TensorFlow and Tflite packages for seamless model integration.
- **Resource Limitations**: Addressing resource constraints during model training and deployment for optimal performance on mobile devices.

### Future Improvements
- **Dataset Expansion**: Increasing the size and diversity of the dataset to enhance the model's accuracy and recognize a broader range of sign language gestures.
- **Feature Enhancements**: Implementing additional features such as real-time translation into spoken or written language to improve accessibility.
- **Performance Optimization**: Optimizing the application's performance for resource-constrained devices, ensuring smooth operation across various mobile platforms.
