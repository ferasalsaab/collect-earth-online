angular.module("admin", []).controller("AdminController", ["$http", function AdminController($http) {
    this.projectList = [];
    this.currentProjectId = "0";
    this.currentProject = null;
    this.projectName = "";
    this.projectDescription = "";
    this.numPlots = "";
    this.plotRadius = "";
    this.sampleType = "random";
    this.samplesPerPlot = "";
    this.sampleResolution = "";
    this.lonMin = "";
    this.latMin = "";
    this.lonMax = "";
    this.latMax = "";
    this.currentImagery = "DigitalGlobeRecentImagery+Streets";
    this.sampleValues = [];
    this.valueName = "";
    this.valueColor = "#000000";
    this.valueImage = "";

    this.initializeMap = function () {
        // Initialize the base map and enable the dragbox interaction
        map_utils.digital_globe_base_map({div_name: "new-project-map",
                                          center_coords: [102.0, 17.0],
                                          zoom_level: 5});
        map_utils.enable_dragbox_draw();
        map_utils.set_bbox_coords = function () {
            var latmax = document.getElementById("lat-max");
            var lonmax = document.getElementById("lon-max");
            var latmin = document.getElementById("lat-min");
            var lonmin = document.getElementById("lon-min");
            latmax.value = map_utils.current_bbox.maxlat;
            lonmax.value = map_utils.current_bbox.maxlon;
            latmin.value = map_utils.current_bbox.minlat;
            lonmin.value = map_utils.current_bbox.minlon;
        };
    };

    // FIXME: Replace with an AJAX request
    this.getProjectList = function () {
        // $http.get("get-all-projects")
        //     .then(function successCallback(response) {
        //         return response.data;
        //     }, function errorCallback(response) {
        //         console.log(response);
        //         alert("Error retrieving the project list. See the console for more information.");
        //         return [];
        //     });
        return ceo_sample_data.project_list;
    };

    this.getProjectById = function (projectId) {
        return this.projectList.find(
            function (project) {
                return project.id == projectId;
            }
        );
    };

    // FIXME: Replace with an AJAX request
    this.getPlotData = function (projectId) {
        return ceo_sample_data.plot_data[projectId];
    };

    this.setCurrentProject = function () {
        var project = this.getProjectById(parseInt(this.currentProjectId));
        this.currentProject = project;

        if (project) {
            var plotData = this.getPlotData(project.id);
            this.projectName = project.name;
            this.projectDescription = project.description;
            this.numPlots = plotData.length;
            this.plotRadius = plotData[0].plot.radius;
            if (project.sample_resolution) {
                this.sampleType = "gridded";
                document.getElementById("gridded-sample-type").checked = true;
                utils.enable_element("samples-per-plot");
                utils.enable_element("sample-resolution");
            } else {
                this.sampleType = "random";
                document.getElementById("random-sample-type").checked = true;
                utils.enable_element("samples-per-plot");
                utils.disable_element("sample-resolution");
            }
            this.samplesPerPlot = plotData[0].samples.length;
            this.sampleResolution = project.sample_resolution || "";
            var boundaryExtent = map_utils.polygon_extent(project.boundary);
            this.lonMin = boundaryExtent[0];
            this.latMin = boundaryExtent[1];
            this.lonMax = boundaryExtent[2];
            this.latMax = boundaryExtent[3];
            this.currentImagery = project.imagery;
            map_utils.set_current_imagery(this.currentImagery);
            map_utils.disable_dragbox_draw();
            map_utils.draw_polygon(project.boundary);
            this.sampleValues = project.sample_values;
        } else {
            this.projectName = "";
            this.projectDescription = "";
            this.numPlots = "";
            this.plotRadius = "";
            this.sampleType = "random";
            document.getElementById("random-sample-type").checked = true;
            utils.enable_element("samples-per-plot");
            utils.disable_element("sample-resolution");
            this.samplesPerPlot = "";
            this.sampleResolution = "";
            this.lonMin = "";
            this.latMin = "";
            this.lonMax = "";
            this.latMax = "";
            this.currentImagery = "DigitalGlobeRecentImagery+Streets";
            map_utils.set_current_imagery(this.currentImagery);
            map_utils.enable_dragbox_draw();
            map_utils.map_ref.removeLayer(map_utils.current_boundary);
            map_utils.current_boundary = null;
            map_utils.zoom_and_recenter_map(102.0, 17.0, 5);
            this.sampleValues = [];
        }
    };

    this.exportCurrentPlotData = function () {
        var project_id = parseInt(this.currentProjectId);
        if (project_id != 0) {
            $http.post("dump-project-aggregate-data",
                       {project_id: project_id})
                .then(function successCallback(response) {
                    window.open(response.data);
                }, function errorCallback(response) {
                    console.log(response);
                    alert("Error downloading data for this project. See the console for more information.");
                });
        }
    };

    // FIXME: Needs to be translated correctly from admin.cljs
    this.deleteCurrentProject = function () {
        $http.get("archive-project").
            then (function() {
                alert("Project \"" + this.projectName + "\" has been deleted." + "\n");
                this.currentProjectId = "0";
                this.getProjectList();
            }, function(response) {
                console.log(response.status);
            });
    };

    this.submitForm = function ($event) {
        if (this.currentProjectId != "0") {
            if (confirm("Do you REALLY want to delete this project?!")) {
                this.deleteCurrentProject();
            }
        } else {
            $event.currentTarget.value = "Processing...please wait...";
            document.getElementById("spinner").style.visibility = "visible";
            document.getElementById("project-management-form").submit();
        }
    };

    this.setSampleType = function (sampleType) {
        if (sampleType == "random") {
            utils.enable_element("samples-per-plot");
            utils.disable_element("sample-resolution");
        } else {
            utils.disable_element("samples-per-plot");
            utils.enable_element("sample-resolution");
        }
    };

    this.setCurrentImagery = function () {
        map_utils.set_current_imagery(this.currentImagery);
    };

    this.removeSampleValueRow = function (sampleValueName) {
        this.sampleValues = this.sampleValues.filter(
            function (sampleValue) {
                return sampleValue.name != sampleValueName;
            }
        );
    };

    this.addSampleValueRow = function () {
        var name = this.valueName;
        var color = this.valueColor;
        var image = this.valueImage;

        if (name != "") {
            this.sampleValues.push({name: name, color: color, image: image});
            this.valueName = "";
            this.valueColor = "#000000";
            this.valueImage = "";
        } else {
            alert("A sample value must possess both a name and a color.");
        }
    };

}]);
