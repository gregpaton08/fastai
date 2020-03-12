# Lesson 1 Homework

* Run the [Jupyter Notebook](https://github.com/fastai/course-v3/blob/master/nbs/dl1/lesson1-pets.ipynb) from class.
* Create your own [image set](https://forums.fast.ai/t/tips-for-building-large-image-datasets/26688).
* Create your own classifier using the Jupyter notebook and the image set you created.

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

Organize the data ["Imagenet-style"](https://docs.fast.ai/vision.data.html#ImageDataBunch.from_folder)
```
path/
    train/
        no/
        yes/
    valid/
        no/
        yes/
```

Then tar it up
```bash
cd /Users/gpaton/Google\ Drive/fastai/datasets/is_it_murphy/
tar --exclude=".*" -cvzf is_it_murphy.tgz imagenet-style
```

## Creating and Connecting to a GCP Instance

Preemption was taking down my instance every few minutes, so I opted for the budget instance and removed the `--preemptible` flag. Will need to monitor costs to see how bad it is.

Once connected via ssh runs these commands to update the repo.

```bash
cd tutorials/fastai/course-v3
git checkout .
git pull
```

You should also update the fastai library.

```bash
sudo conda install -y -c fastai fastai
```

Then you can access the jupyter notebook in a web browser.

[http://localhost:8080/tree/tutorials/fastai/course-v3/nbs/dl1](http://localhost:8080/tree/tutorials/fastai/course-v3/nbs/dl1)
