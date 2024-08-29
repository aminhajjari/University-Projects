

import cv2
import numpy as np

# Load the Football sequence frame (frame 75)
frame_path = "football_qcif.yuv"
frame_width, frame_height = 176, 144  # QCIF resolution

# Read the raw YUV data
with open(frame_path, "rb") as yuv_file:
    yuv_data = yuv_file.read()

# Extract Y, U, V components
Y_size = frame_width * frame_height
U_size = frame_width * frame_height // 4
V_size = frame_width * frame_height // 4

Y = np.frombuffer(yuv_data[:Y_size], dtype=np.uint8).reshape((frame_height, frame_width))
U = np.frombuffer(yuv_data[Y_size : Y_size + U_size], dtype=np.uint8).reshape((frame_height // 2, frame_width // 2))
V = np.frombuffer(yuv_data[Y_size + U_size : Y_size + U_size + V_size], dtype=np.uint8).reshape((frame_height // 2, frame_width // 2))

# Expand U and V to match Y dimensions
U = cv2.resize(U, (frame_width, frame_height), interpolation=cv2.INTER_LINEAR)
V = cv2.resize(V, (frame_width, frame_height), interpolation=cv2.INTER_LINEAR)

# Stack Y, Cb, and Cr channels
ycbcr_frame = cv2.merge([Y, U, V])

# Save the YCbCr frame as a PNG image file
cv2.imwrite("ycbcr_frame.jpg", ycbcr_frame)

print("YCbCr frame saved successfully.")
