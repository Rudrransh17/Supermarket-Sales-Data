# Supermarket Sales Data Visualizer

Supermarket Sales Data Visualizer is a Flutter app that allows users to visualize sales data from a supermarket using pie charts and bar charts. The app fetches data from a MongoDB Atlas cluster, which stores the dataset provided by Kaggle. 

## Dataset
The dataset used in this app is sourced from Kaggle and can be found at the following link: [Supermarket Sales Dataset](https://www.kaggle.com/datasets/aungpyaeap/supermarket-sales). It contains information about sales transactions in a supermarket, including customer details, product information, sales dates, and quantities.

## Features
1. **Authentication:** The app provides a login/register screen for users. The authentication backend is handled by the app services of MongoDB Atlas, utilizing email and password authentication.

2. **Home Screen:** Upon successful authentication, users are redirected to the home screen. The home screen displays a pie chart and a bar chart representing the sales data.

3. **Pie Chart:** The pie chart visualizes the sales data based on selected categories and data values. Users can choose different categories and data values from the side panel to plot on the chart. The data for the chart is fetched from the server using HTTP APIs with appropriate headers and bodies.

4. **Bar Chart:** Similar to the pie chart, the bar chart displays the sales data based on selected categories and data values. Users can customize the chart by selecting different categories and data values from the side panel. The data for the bar chart is also requested from the server using HTTP APIs.

5. **Side Panel:** The app features a side panel that allows users to choose the categories and data values they want to visualize on both the pie chart and the bar chart. This panel provides flexibility and customization options for the charts.

## Technologies Used
The Supermarket Sales Data Visualizer app utilizes the following technologies:

- Flutter: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- MongoDB Atlas: A cloud-based, fully managed database service for MongoDB.
- HTTP APIs: The app communicates with the server to fetch data using HTTP APIs.
- Dart: The programming language used for developing the Flutter app.

## Installation
To run the Supermarket Sales Data Visualizer app locally, follow these steps:

1. Clone the repository to your local machine: `git clone https://github.com/your-repo.git`
2. Install Flutter by following the official [Flutter installation guide](https://flutter.dev/docs/get-started/install).
3. Set up your MongoDB Atlas cluster and obtain the necessary connection credentials.
4. Update the app's configuration with your MongoDB Atlas connection details.
5. Run the app using the Flutter development tools.

## Future Enhancements
The Supermarket Sales Data Visualizer app can be further enhanced with the following features:

- Additional chart types: Expand the visualization options by adding more chart types, such as line charts or scatter plots, to provide different perspectives on the sales data.
- Data filtering: Implement filters to allow users to refine the displayed data based on specific criteria, such as date ranges, customer segments, or product categories.
- User management: Enhance the authentication system to include features like password reset, profile management, and role-based access control.
- Real-time updates: Implement real-time data updates using technologies like websockets to provide live visualization of sales data as new transactions occur.

## Contributions
Contributions to the Supermarket Sales Data Visualizer app are welcome. If you find any bugs, have suggestions for improvements, or want to add new features, feel free to open an issue or submit a pull request on the GitHub repository.
