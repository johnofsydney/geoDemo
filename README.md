# geo_coding and geoLocation in Rails / Javascript
This to be read in conjunction with [github.com/johnofsydney/geoDemo](https://github.com/johnofsydney/geoDemo)

## Scaffold Rails
I’ve made a simple rails app with
```
rails new geo_demo
rails generate scaffold Station address:text
rails generate migration AddLatitudeAndLongitudeToStation latitude:float longitude:float
```

So, Station is the model, which has fields address, latitude and longitude

## rails gem
Rails has a nice gem to do all the hard work of geoCoding n stuff.
Information here: [GitHub - alexreisner/geocoder: Complete Ruby geocoding solution.](https://github.com/alexreisner/geocoder) and http://www.rubygeocoder.com

It does lot’s of sophisticated stuff, but all we’re going to use is it’s ability to turn a street address into a latitude and longitude.

Install the gem
`gem 'geocoder'`
 And `bundle`


## Rails code
This code in the Station model:
```
class Station < ApplicationRecord

  geocoded_by :address
  after_validation :geocode

end
```

That’s it - now every record that is added or updated will have a latitude and longitude.

This will not geocode data that’s already in your database, no doubt this is possible; for this and other advanced features - read the documentation.


## Getting Rails data into JavaScript
First thing to tackle is that data from rails needs one available in javascript. There’d two ways I know how to deal with this.

#### Pass the ruby variables into the html data tag thusly:

```
 <%= content_tag :div, id: "map", data: {places: @stations} do %>
 <% end %>
```

This makes a div tag, which has an /*attribute*/ `data-places` and inside this attribute is the contents of the ruby variable `@stations`

In this case @stations is an array, which I will make available in JS using : `let placeList = $('#map').data('places')`

#### Alternative which works inside a `<script></script>` tag

```
<script>
let places = <%== @stations.to_json %>;
…..
```


## Maps and Markers
Google has loads of cool ways to do maps. Start here:
[Google Maps Javascript API](https://developers.google.com/maps/documentation/javascript/adding-a-google-map)

#### In a nutshell
Add this API call to your page. Really I don’t know the pros and cons of where to put it…
`    <script async defer src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY_GOES_HERE&callback=initMap">  </script>`

This is the bit then draws the map and the markers which correspond to the records in the Stations  table. (All this inside a `<script></script>` tag
```
    let map;
    function initMap() {
      map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: state.lat, lng: state.lng},
        zoom: 15
      });

      let placeList = $('#map').data('places')

      for (var i = 0; i < placeList.length; i++) {
        console.log( placeList[i] )
        marker = new google.maps.Marker ({
          position: {lat: placeList[i].latitude, lng: placeList[i].longitude},
          map: map,
          label: placeList[i].address
        })
      }
    }
```

NOTE that the map will be drawn in the element with Id “map”
The map will fill the element, which therefore must have it’s dimensions specified in CSS:
```
#map {
  height: 90vh;
  width: 80%;
  margin: 0 auto;
  border: red solid 2px;
}
```


## Finding where we currently are in the world
There’s a function built into the browser which we can call and get the current location of the device. (Apparently it can be really slow…)

You can test this with:
```
navigator.geolocation.getCurrentPosition( function(results) {
	console.log(results)
} )
```

And I’ll use this in my example to centre the map. We could place another marker too, but whatevs I canna be bothered.
I’ll use the code from above to find the current position, set the state to these results, and then redraw the map with the new centre.

```
    navigator.geolocation.getCurrentPosition( function(results)
      {
        console.log(results.coords.latitude, results.coords.longitude)
        state = {lat: results.coords.latitude, lng: results.coords.longitude}
        initMap()
      })
```



https://github.com/johnofsydney/geoDemo
