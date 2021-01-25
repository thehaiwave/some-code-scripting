# some-code-scripting
I'll be putting my scripts here, since I always seem to lose them.

## Scripts
- **separate_indicators.sh**

This thing is used to break down a GeoJSON file into smaller files related to each other.
In my case, smaller files with GeoJSON objects whose `codigo_act`
property was the same, because 70M files are not fun. The script relies heavily (mostly) on [jq](https://github.com/stedolan/jq), which allows you to
reshape and move JSONs around very easily. 

I don't know if the script is efficient, to be honest. Probably not, but it does go through a 187,281 line file in about 30 seconds. Good enough for me.

Original file:
```yaml
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [
          -100.37162845,
          25.69593791
        ]
      },
      "properties": {
        "codigo_act": "236211",
      }
    },
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [
          -100.33016604,
          25.67235888
        ]
      },
      "properties": {
        "codigo_act": "118210",
      }
    }
  ]
}
```


Separated files:
```yaml
// File 1
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [
          -100.37162845,
          25.69593791
        ]
      },
      "properties": {
        "codigo_act": "236211",
      }
    }
  ]
}
    
// File 2
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [
          -100.33016604,
          25.67235888
        ]
      },
      "properties": {
        "codigo_act": "118210",
      }
    }
  ]
}
```
