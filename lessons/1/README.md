# Lesson 1

## TL;DR

1. Get some image data set.
1. Use it to create a `ImageDataBunch` object.
    * View the data and get familiar with it as a sanity check
      ```python
      data.show_batch(rows=3, figsize=(7,6))
      ```
1. Train a model based on resnet34.
   ```python
   learn = cnn_learner(data, models.resnet34, metrics=error_rate)
   learn.fit_one_cycle(4)
   ```
1. Analyze the results.
    * Look at the error rate.
    * Look at the top losses.
      ```python
      interp = ClassificationInterpretation.from_learner(learn)
      interp.plot_top_losses(9, figsize=(15,11))
      ```
    * Look at the most common error cases.
      ```python
      interp.plot_confusion_matrix(figsize=(12,12), dpi=60)
      interp.most_confused(min_val=2)
      ```
1. Fine tune if you dare...

## Notes

Loss is correlated with confidence. If the model was very confident about an incorrect prodiction then the loss will be high. If the model is not confident about an incorrect prediction then the loss will be much lower.
