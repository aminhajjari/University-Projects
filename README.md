"# University-Projects"




Welcome to the Yazd University Programming Projects repository. This collection features a variety of programming exercises completed during my studies. Each project includes a readme.txt file that provides detailed explanations specific to that exercise. While some exercises are inspired by assignments from other universities, every effort has been made to thoroughly comment on the code for clarity. The final versions presented here are optimized for efficiency and were developed within the project’s time constraints.

Of course, it will be more complete in the following semesters (by taking other courses).


__1-Pattern recognition/Final Project__

__Digit Recognition System__

This project implements a digit recognition system using the MNIST dataset. The system employs the K-Nearest Neighbors (KNN) method for diagnosis and classification. Prior to classification, dimensionality reduction is performed using feature extraction methods.

__Overview__

This project is part of an exercise similar to one from Queen’s University in Canada. The main objectives are:

__Data Implementation: Utilize the MNIST dataset.__

__Classification Method:__ Apply the KNN method for classification.

__Feature Extraction:__ Reduce data dimensions using PCA (Principal Component Analysis) and LDA (Linear Discriminant Analysis).

__Steps__

__1-Data Loading: Load the MNIST dataset.__

__2-Feature Extraction:__

          __PCA__: Reduce dimensions to retain the most significant features.
          __LDA__: Further reduce dimensions while maximizing class separability.

          
__Classification:__ Use the KNN method to classify the digits based on the extracted features.

__Evaluation:__ Assess the performance of the classification model.


__Dependencies__

.Python 3.x
.NumPy
.scikit-learn
.matplotlib
