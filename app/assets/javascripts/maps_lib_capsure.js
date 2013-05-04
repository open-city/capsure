var MapsLib = MapsLib || {};
var MapsLib = {

  fusionTableId: "1fYRn1iHFY65w6QAEzBoPnw-SHtwvgWO2zeyCrkU",
  googleApiKey:  "AIzaSyA3FQFrNr5W2OEVmuENqhb2MBB2JabdaOY",

  getDistrict: function(){
    geocoder = new google.maps.Geocoder();
    var address = $("#address").val();
    
    if(address.toLowerCase().indexOf("chicago") == -1)
      address += ", Chicago";

    geocoder.geocode({ address: address }, function(results, status){
      if(status == google.maps.GeocoderStatus.OK){
        var whereClause = "geometry not equal to '' AND ST_INTERSECTS(geometry, CIRCLE(LATLNG" + results[0].geometry.location.toString() + ",1))";
        MapsLib.query("name", whereClause, "MapsLib.redirectToEvent");
      }
      else {
        alert("Sorry, we couldn't find your address: " + status);
      }
    });
  },

  redirectToEvent: function(json) {
    MapsLib.handleError(json);

    if (json["rows"] != null) {
      var discrict_num = json["rows"][0];
      window.location = "/calendar/" + discrict_num + "/next";
    }
    else {
      alert("Sorry, we couldn't find your discrict")
    }
  },

  query: function(selectColumns, whereClause, callback) {
    var queryStr = [];
    queryStr.push("SELECT " + selectColumns);
    queryStr.push(" FROM " + MapsLib.fusionTableId);
    queryStr.push(" WHERE " + whereClause);

    var sql = encodeURIComponent(queryStr.join(" "));
    $.ajax({url: "https://www.googleapis.com/fusiontables/v1/query?sql="+sql+"&callback="+callback+"&key="+MapsLib.googleApiKey, dataType: "jsonp"});
  },

  handleError: function(json) {
    if (json["error"] != undefined) {
      var error = json["error"]["errors"]
      console.log("Error in Fusion Table call!");
      for (var row in error) {
        console.log(" Domain: " + error[row]["domain"]);
        console.log(" Reason: " + error[row]["reason"]);
        console.log(" Message: " + error[row]["message"]);
      }
    }
  }
}
