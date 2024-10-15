# Elastic Blob
Stretchable and rotatable blob interaction using gestures. 
Elastic animation that makes the widget bounce back smoothly.

![Elastic Blob Demo](demo.gif)

## Usage
``` dart
        ElasticBlob(
          radius: blobRadius,
          underBlobWidget: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.onSurface,
            size: blobRadius,
          ),
          aboveBlobWidget: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.onPrimary,
            size: blobRadius,
          ),
          duration: const Duration(milliseconds: 350),
        );
```