var geocoder = null;
google.load('visualization', '1');

$("#address").on("keydown", function(e){
  if(e.keyCode == 13){
    searchAddress();
  }
});

function searchAddress(){
  // alert( $("#address").val() );
  var address = $("#address").val();
  if(!geocoder){
    geocoder = new google.maps.Geocoder();
    if(address.toLowerCase().indexOf("chicago") == -1){
      address += ", Chicago, IL";
    }
    geocoder.geocode({ address: address }, function(results, status){
      if(status == google.maps.GeocoderStatus.OK){
        var fusion_table_id = "1fYRn1iHFY65w6QAEzBoPnw-SHtwvgWO2zeyCrkU";
        var sql = "SELECT name FROM " + fusion_table_id + " WHERE geometry not equal to ''";
        sql += " AND ST_INTERSECTS(geometry, CIRCLE(LATLNG" + results[0].geometry.location.toString() + ",1))";
        var ftcall = new google.visualization.Query('http://www.google.com/fusiontables/gvizdata?tq=' + encodeURIComponent(sql));
        ftcall.send(function(result){
          //console.log( result.getDataTable().getValue(0,0) );
          var precinct_num = result.getDataTable().getValue(0,0);
          window.location = "/calendar/" + precinct_num + "/next";
        });
      }
    });
  }
}
