$(document).ready(function(){

  // populate the dropdown
    $.getJSON('stations.json', function(data) {       
        var stations = data["Stations"];
        stationsDropDown = "";
        $.each(stations, function(key, value){
            stationsDropDown += "<option value='" + value.Code + "'>" + value.Name + "</option>";
        $("#startStationsDropDown").html(stationsDropDown);
        $("#endStationsDropDown").html(stationsDropDown);
        });
    });
 

    // When you click submit
    $("#submitStations").click(function(event){
        event.preventDefault();
        var start = $("#startStationsDropDown").val();
        var end = $("#endStationsDropDown").val();

        $.ajax({
            url: "https://api.wmata.com/Rail.svc/json/jSrcStationToDstStationInfo?FromStationCode=" + start + "&ToStationCode=" + end + "&api_key=kfgpmgvfgacx98de9q3xazww",
            type: 'GET',     
        })
        .done(function(data) {
            console.log(data);

            var estimatedTime = 0;

            $.each(data, function(key,value){
                estimatedTime = value[0].RailTime;
                $("#estimate").append("Your estimated travel time is " + estimatedTime + "minutes. You could watch one of the following videos:");
      
            });


/// trying to put output here
console.log(estimatedTime);
    if (estimatedTime < 5 ){
            var youtubeUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=10&videoDuration=short&key=AIzaSyDj034n3wLrHilm7NnAskQOFoMVdmhtG8w";
        } else if (estimatedTime >= 5 && (estimatedTime < 20)){
            var youtubeUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=10&videoDuration=medium&key=AIzaSyDj034n3wLrHilm7NnAskQOFoMVdmhtG8w";
        } else if (estimatedTime >= 20){
             var youtubeUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=10&videoDuration=long&key=AIzaSyDj034n3wLrHilm7NnAskQOFoMVdmhtG8w";           
        }
    console.log(youtubeUrl);

        $.ajax({

            url: youtubeUrl,
            type: 'GET',             
        })

        .done(function(data) {

            var videoLinks = "<ul>";

            resultItems = data.items;
            console.log(resultItems);

            for (var i = 0; i < resultItems.length; i++){
                console.log(resultItems[i].id.videoId);
                videoLinks += "<li><a href='https://www.youtube.com/watch?v=" + resultItems[i].id.videoId + "' target='new'>"+ resultItems[i].snippet.title + "</a></li>";
                videoLinks += "<img src='" + resultItems[i].snippet.thumbnails.medium['url'] + "'></img>";
            }    
            
            videoLinks += "</ul>";

        $("#recommendedVideos").html(videoLinks);

        })

        .fail(function() {
            alert("error");
        });

// output




        })
        .fail(function() {
            alert("error");
        });


        // different conditions based on different times prompt different queries from YouTube
        

});
});

// id https://www.youtube.com/watch?v=ISBOwJYDTbI
