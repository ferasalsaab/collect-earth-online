<#include "header.ftl">

<script type="text/javascript" src="/js/admin.js"></script>

<div id="admin">
    <h1>Project Management</h1>
    <div ng-controller="ctlAdmin"  ng-attr-id="{{ formID }}">
        <form method="post" action="/admin" id="project-management-form">
            <div id="project-selection">
                <label>Currently Viewing:</label>
		<select name="project-selector" size="1" id="project-selector" ng-model="selProj" ng-change="update()">
                    <option ng-repeat="project in projects" value="{{ project.id }}">{{ project.name }}</option>
                </select>
            </div>
            <input name="download-plot-data" value="Download Data" id="download-plot-data" class="button" style="visibility: hidden;" type="button">
            <input name="create-project" value="Create and launch this project" id="create-project" class="button" type="button">
            <fieldset id="project-info">
                <legend>Project Info</legend>
                <label>Name</label>
                <input name="project-name" autocomplete="off" id="project-name" type="text">
                <label>Description</label>
                <textarea name="project-description" id="project-description">
                </textarea>
            </fieldset>
            <fieldset id="plot-info">
                <legend>Plot Info</legend>
                <label>Number of plots</label>
                <input name="plots" autocomplete="off" min="0" step="1" id="plots" type="number">
                <label>Plot radius (m)</label>
                <input name="buffer-radius" autocomplete="off" min="0.0" step="any" id="radius" type="number">
            </fieldset>
            <fieldset id="sample-info">
                <legend>Sample Info</legend>
                <label>Sample type</label>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <input name="sample-type" id="random-sample-type" value="random" checked="" type="radio">
                            </td>
                            <td>
                                <label>Random</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input name="sample-type" id="gridded-sample-type" value="gridded" type="radio">
                            </td>
                            <td>
                                <label>Gridded</label>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <label>Samples per plot</label>
                <input name="samples-per-plot" autocomplete="off" min="0" step="1" id="samples-per-plot" type="number">
                <label>Sample resolution (m)</label>
                <input name="sample-resolution" autocomplete="off" min="0.0" step="any" disabled="" id="sample-resolution" type="number">
            </fieldset>
            <fieldset id="bounding-box">
                <legend>Define Bounding Box</legend>
                <label>Hold CTRL and click-and-drag a bounding box on the map</label>
                <input name="boundary-lat-max" value="" placeholder="North" autocomplete="off" min="-90.0" max="90.0" step="any" id="lat-max" type="number">
                <input name="boundary-lon-min" value="" placeholder="West" autocomplete="off" min="-180.0" max="180.0" step="any" id="lon-min" type="number">
                <input name="boundary-lon-max" value="" placeholder="East" autocomplete="off" min="-180.0" max="180.0" step="any" id="lon-max" type="number">
                <input name="boundary-lat-min" value="" placeholder="South" autocomplete="off" min="-90.0" max="90.0" step="any" id="lat-min" type="number">
            </fieldset>
            <div id="map-and-imagery">
                <div id="new-project-map"></div>
                <label>Basemap imagery: </label>
                <select name="imagery-selector" size="1" id="imagery-selector">
                    <option value="DigitalGlobeRecentImagery">DigitalGlobe: Recent Imagery</option>
                    <option value="DigitalGlobeRecentImagery+Streets">DigitalGlobe: Recent Imagery+Streets</option>
                    <option value="BingAerial">Bing Maps: Aerial</option>
                    <option value="BingAerialWithLabels">Bing Maps: Aerial with Labels</option>
                </select>
            </div>
            <fieldset id="sample-value-info">
                <legend>Sample Values</legend>
                <table>
                    <thead>
                        <tr>
                            <th>
                            </th>
                            <th>Name</th>
                            <th>Color</th>
                            <th>Reference Image</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <input name="value-name" autocomplete="off" id="value-name" type="text">
                            </td>
                            <td>
                                <input name="value-color" id="value-color" type="color">
                            </td>
                            <td>
                                <input name="value-image" accept="image/*" id="value-image" type="file">
                            </td>
                        </tr>
                    </tbody>
                </table>
                <input name="add-sample-value" value="Add sample value" id="add-sample-value" class="button" type="button">
                <input name="sample-values" value="[]" type="hidden">
            </fieldset>
            <div id="spinner"></div>
        </form>
    </div>
</div>
<#include "footer.ftl">
