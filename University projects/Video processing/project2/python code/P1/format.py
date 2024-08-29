

import cv2

# Read the original image
original_image = cv2.imread("combined_yuv_frame.jpg")

# Convert the original image to YUV and YCbCr color spaces
yuv_image = cv2.cvtColor(original_image, cv2.COLOR_BGR2YUV)
ycbcr_image = cv2.cvtColor(original_image, cv2.COLOR_BGR2YCrCb)

# Perform 4:2:2 color sampling by subsampling chrominance horizontally
yuv_422 = yuv_image.copy()
yuv_422[:, 1::2, 1:] = yuv_422[:, ::2, 1:]

ycbcr_422 = ycbcr_image.copy()
ycbcr_422[:, 1::2, 1:] = ycbcr_422[:, ::2, 1:]

# Perform 4:1:1 color sampling by subsampling chrominance horizontally and vertically
yuv_411 = yuv_image.copy()
yuv_411[:, ::2, 1:] = yuv_411[:, ::2, 1::2]

ycbcr_411 = ycbcr_image.copy()
ycbcr_411[:, ::2, 1:] = ycbcr_411[:, ::2, 1::2]

# Perform 4:2:0 color sampling by subsampling chrominance horizontally and vertically
yuv_420 = yuv_image.copy()
yuv_420[1::2, :, 1:] = yuv_420[::2, :, 1:]

ycbcr_420 = ycbcr_image.copy()
ycbcr_420[1::2, :, 1:] = ycbcr_420[::2, :, 1:]

# Display or save the subsampled images
cv2.imshow("YUV 4:2:2", cv2.cvtColor(yuv_422, cv2.COLOR_YUV2BGR))
cv2.imshow("YCbCr 4:2:2", cv2.cvtColor(ycbcr_422, cv2.COLOR_YCrCb2BGR))

# Display or save the subsampled images
cv2.imshow("YUV 4:1:1", cv2.cvtColor(yuv_411, cv2.COLOR_YUV2BGR))
cv2.imshow("YCbCr 4:1:1", cv2.cvtColor(ycbcr_411, cv2.COLOR_YCrCb2BGR))

# Display or save the subsampled images
cv2.imshow("YUV 4:2:0", cv2.cvtColor(yuv_420, cv2.COLOR_YUV2BGR))
cv2.imshow("YCbCr 4:2:0", cv2.cvtColor(ycbcr_420, cv2.COLOR_YCrCb2BGR))



# Save the subsampled images
cv2.imwrite("yuv_4:2:2.jpg", cv2.cvtColor(yuv_422, cv2.COLOR_YUV2BGR))
cv2.imwrite("ycbcr_4:2:2.jpg", cv2.cvtColor(ycbcr_422, cv2.COLOR_YCrCb2BGR))

cv2.imwrite("yuv_4:1:1.jpg", cv2.cvtColor(yuv_411, cv2.COLOR_YUV2BGR))
cv2.imwrite("ycbcr_4:1:1.jpg", cv2.cvtColor(ycbcr_411, cv2.COLOR_YCrCb2BGR))

cv2.imwrite("yuv_4:2:0.jpg", cv2.cvtColor(yuv_420, cv2.COLOR_YUV2BGR))
cv2.imwrite("ycbcr_4:2:0.jpg", cv2.cvtColor(ycbcr_420, cv2.COLOR_YCrCb2BGR))

print("Images saved successfully.")

cv2.waitKey(0)
cv2.destroyAllWindows()
