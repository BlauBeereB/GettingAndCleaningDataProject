## Code book for variables in tidy data set produced by script run_analysis.R

# Format

The data set "tidySet" contains one row for each subject and each activity. There are 30 subjects (volunteers) and 6 activities (walking, walking upstairs, walking downstairs, sitting, standing, laying), which results in 180 rows. Each column contains the average over a measurement, and there are 68 measurements, i.e. 68 columns in the data set. The measurements are means and standard deviations of various original sensor signals which are described below.

# Sensor signals

In general, the signals of an accelerometer and a gyroscope of a smartphone that was fixed to a volunteer have been measured.

Here, the components of the label names are described in brief. For an explanation of the actual measurements, please refer to the files "README.txt" and "features_info.txt" that are provided with the original data set.

The label names are combinations of the following elements.

time:
Refers to time domain signals, which were captured at a rate of 50 Hz.

freq:
Refers to frequency domain signals, i.e. after applying a Fast Fourier Transform.

BodyAcc:
Refers to the body acceleration signal.

GravityAcc:
Refers to the gravity acceleration signal.

BodyGyro:
Refers to the body gyroscopic signal.

Jerk:
Refers to Jerk signals that have been derived in time from the body linear acceleration and the angular velocity.

Mag:
Refers to the magnitude of a signal as given by the Euclidian norm.

Mean:
Refers to the mean over the respective signal.

Std:
Refers to the standard deviation of the respective signal.

X, Y, Z:
Refer to the axis in three dimensional space.

# Author and data

The script has been prepared by BlauBeereB in the context of the course project for the Coursera course "Getting and Cleaning Data" provided by Johns Hopkins University in January 2015. Much of the text describing the sensor signals has been taken from the file "features_info.txt" in the original data set.


