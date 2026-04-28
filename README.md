# Freecycle Corner

Freecycle Corner is a modern, Flutter-based mobile application designed to promote a circular economy by allowing students and community members to give away items they no longer need, and find items they do need, completely free of charge or for a small price.

## 🎥 Video Demonstration

<vedio src = "freecycle_demo.mp4" width="100%"></vedio>

## ✨ What the App Does

- **User Authentication:** Secure sign-up and login functionality for users, ensuring accountability.
- **Item Listing:** Users can easily post items they wish to give away, complete with details like item condition, category, pickup location, and a photo.
- **Real-time Feed:** Browse a live, searchable feed of all available items in the community.
- **Item Management:** Users have full control over their own listings, with the ability to edit details or delete items once they are claimed.
- **Cart System:** A built-in cart feature allows users to keep track of items they are interested in claiming from others.
- **Owner Contact Integration:** Users can view the owner's contact details (Name, Email, Phone Number) directly on the item page to arrange a pickup.

## 🛠️ Technical Stack

This project was built entirely using modern mobile development technologies and cloud infrastructure:

- **Frontend Framework:** [Flutter](https://flutter.dev/) (Dart)
- **Backend & Database:** [Firebase Cloud Firestore](https://firebase.google.com/docs/firestore) - NoSQL document database used for storing user profiles and real-time item listings.
- **Authentication:** [Firebase Authentication](https://firebase.google.com/docs/auth) - Handling secure Email & Password sign-in.
- **UI/UX:** Built with Material 3 design principles, featuring a custom color palette, glassmorphism elements, and modern typography using the `google_fonts` package (Poppins).
- **Media Handling:** Integrates `image_picker` for selecting item photos from the device gallery.
- **State Management:** Utilizes native Flutter state management alongside `StreamBuilder` for reactive, real-time database updates.
