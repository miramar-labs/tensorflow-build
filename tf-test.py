import tensorflow as tf

print("Tensorflow - Num GPUs Available: ", len(tf.config.experimental.list_physical_devices('GPU')))