# 🏨 Hotel Reservation Cancellation Prediction

This project predicts whether a hotel reservation will be canceled based on several input features such as lead time, room type, number of nights, special requests, and more. It is designed using MLOps principles and is deployed on Google Cloud Run.

## 📌 Project Overview

This machine learning pipeline takes customer and booking details like:

- Lead time
- Number of special requests
- Average price per room
- Arrival date and month
- Market segment type
- Weekday and weekend nights
- Meal plan and reserved room type

...and predicts whether the customer will cancel the reservation.

## 🚀 Tech Stack

- **Language:** Python  
- **Libraries:** LightGBM, Pandas, NumPy, Scikit-learn, Flask  
- **MLOps Tools:** Docker, Google Cloud Run, Google Container Registry, Jenkins  
- **Environment Management:** Virtualenv  
- **CI/CD:** Jenkins pipeline with automated build and deploy

## ⚙️ Pipeline Components

- 🔄 **Data Ingestion & Preprocessing**  
- 🧹 **Feature Engineering and Cleaning**  
- 📦 **Model Training using LightGBM**  
- 🔍 **Custom Logging and Exception Handling**  
- 🚀 **Deployment to Google Cloud Run**

## 💻 How to Run Locally

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Snehallaldas/ML-OPS-PROJECT-1.git
   cd ML-OPS-PROJECT-1
2. **Create Virtual Environment**
```bash
   python -m venv venv
   source venv/bin/activate   # For Windows: venv\Scripts\activate
```
3. **Installing Dependencies**
```bash
   pip install -e .
```
4. Run the Application
```bash
   python application.py
