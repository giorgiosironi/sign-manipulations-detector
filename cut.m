function result = cut(image, keypoints)
keypoints = uint16(keypoints);
x_min = min(keypoints(1, :))
y_min = min(keypoints(2, :))
x_max = max(keypoints(1, :))
y_max = max(keypoints(2, :))
result = image(x_min:x_max, y_min:y_max);
