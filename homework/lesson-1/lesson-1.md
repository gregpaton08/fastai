# Lesson 1 Homework

* Run the [Jupyter Notebook](https://github.com/fastai/course-v3/blob/master/nbs/dl1/lesson1-pets.ipynb) from class.
* Create your own [image set](https://forums.fast.ai/t/tips-for-building-large-image-datasets/26688).
* Create your own classifier using the Jupyter notebook and the image set you created.

## Notes

## Creating Your Own Data Set

After a lot of searching and trial-and-error I used [this image scraper script](https://github.com/ultralytics/google-images-download) to pull images from Bing.

Here is the command I used.

```python
python3 bing_scraper.py --limit 1000 --download --chromedriver ../google-images-download/chromedriver --url 'https://www.bing.com/images/search?q=saint%20bernard'
```

Took a while, and didn't get the full 1000 images, but good enough!

```
Unfortunately all 368 could not be downloaded because some images were not downloadable. 631 is all we got for this search filter!
Done with 35 errors in 447.9s. All images saved to /Users/gpaton/code/ultralytics-google-images-download/images
```

