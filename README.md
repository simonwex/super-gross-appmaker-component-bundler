Super Gross Bundler!
====================


The bootstrap script creates the thumbnail directory and all component directories. This also ends up being the list of directories to bundle. Gross, right?

```bash
./bootstrap.sh
```

After that's been run, we can run `process.sh`. This downloads the latest components and creates a single html file by cat'n the result between index.html.1 and index.html.2. Gross, right?

The thumbnails are then copied to a hardcoded `~/projects/mozilla-appmaker/appmaker/public/bundles/components/` and the resulting html is copied to `~/projects/mozilla-appmaker/appmaker/public/bundles/components/mozilla-appmaker.html`. Gross, right?

## Before you start

Be sure to install `vulcanize`, which will concat Polymer elements.
```
npm install -g vulcanize
```

## A note about assets
As gross as this process is, it's also very considerate if you follow some simple rules. If components have assets required to run (images, other js files, etc.), __just make sure they're in a subdirectory inside the component's directory__. The vulcanization process will correct urls used in component.html, and Super Gross Bundler (SGB) will `cp -R` subdirectories so that they're accessible from the bundled html file.