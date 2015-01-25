## Code book for variables in tidy data set produced by script run_analysis.R

# Format of the tidy data set

The data set "tidySet" contains one row for each subject and each activity. There are 30 subjects (volunteers) and 6 activities (walking, walking upstairs, walking downstairs, sitting, standing, laying), which results in 180 rows. There are 2 columns for the activity and the subject plus 66 columns for the average measurements, i.e. 68 columns in the data set. The actual measurements are means and standard deviations of various original sensor signals which are described below. Their averages per activity and subject are taken and saved in the tidy data set.

# Sensor signals

In general, the signals of an accelerometer (that measures proper acceleration or g-force) and a gyroscope (that measures orientation) of a smartphone that was fixed to a volunteer have been measured. Note that the accelerometer signal contains body motion and gravitational components.

The tidy data set here, in particular, contains averages (i.e. means) of various means and standard deviations. Note that this average is NOT mentioned in the labels explained below to avoid making them even longer.

Here, the components of the label names are described in brief. For an explanation of the actual measurements, please refer to the files "README.txt" and "features_info.txt" that are provided with the original data set.

The label names are combinations of the following elements.

time:
Refers to time domain signals, which were captured at a rate of 50 Hz.

freq:
Refers to frequency domain signals, i.e. after applying a Fast Fourier Transform.

BodyAcc:
Refers to the body acceleration signal measured in gravity units g and then normalized (making it unitless).

GravityAcc:
Refers to the gravity acceleration signal measured in gravity units g and then normalized (making it unitless).

BodyGyro:
Refers to the body gyroscopic signal measured in radians per second and then normalized (making it unitless).

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

Note: Due to the normalization, i.e. division by the mean value, the measurements are unitless.

# Author and data

The script has been prepared by BlauBeereB in the context of the course project for the Coursera course "Getting and Cleaning Data" provided by Johns Hopkins University in January 2015. Much of the text describing the sensor signals has been taken from the documentation in the original data set.


