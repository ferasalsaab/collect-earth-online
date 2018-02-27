<#include "header.ftl">
<#include "start-content.ftl">
<script src="${root}/js/jquery-3.1.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="${root}/js/js.cookie.js"></script>
<script type="text/javascript" src="${root}/js/geo-dash-widget-editor.js"></script>
<div id="geodash" ng-app="geodash" ng-controller="GeodashWidgetEditorController as geodash" ng-init="geodash.initialize('${root}')">
    <div id="geohead">
        <img id="ceo-site-logo" src="/img/ceo-logo1.png" style=" position: relative; top: 1px; left: 10px; height: 40px; padding: 4px;">
            <div id="login-info">
                    <#if username??>
                        <#if navlink == "Logout">
                             <span>${username}</span> <a class="active-link" href="${root}/logout">Logout</a>
                        <#else>
                            <span>${username}</span> <a href="${root}/logout">Logout</a>
                        </#if>
                    <#else>
                        <#if navlink == "Login" || navlink == "Register">
                            <a class="active-link" href="${root}/login">Login/Register</a>
                        <#else>
                            <a ng-href="${root}/login{{geodash.querystring}}&returnurl=geo-dash">Login/Register</a>
                        </#if>
                    </#if>
                </div>
            </div>
        <div class="container-fluid widgetEditor">
            <div class="row">
                <div id="dashHolder" class="dashHolder widgetEditor">
                    <div>

                        <h1 class="page-header">Current Layout </h1>
                    </div>
                </div>
            </div>
        </div>
        <div id="dialog-form" title="Create new widget" style="display:none;">
            <p class="validateTips">All form fields are required.</p>

            <form name="form" id="form">
                    <fieldset>
                     <div class="form-group">
                            <label for="widgetTypeSelect">Type</label>
                            <select name="widgetTypeSelect" class="form-control" id="widgetTypeSelect" ng-model="geodash.masterWidgetTypeSelected"  ng-change="geodash.updateWidgetTypeSelected(geodash.masterWidgetTypeSelected)"
                                                        data-ng-options="masterWidgetType as masterWidgetType.name for masterWidgetType in geodash.masterWidgetTypes">
                            <option value="">Please select type</option>
                            </select>
                             <div id="widgetIndices" ng-show="geodash.indices">

                                <label for="widgetIndicesSelect">Type</label>
                                <select name="widgetIndicesSelect" class="form-control" id="widgetIndicesSelect" ng-model="geodash.widgetIndicesSelected"  ng-change="geodash.updateWidgetIndicesSelected(geodash.widgetIndicesSelected)"
                                data-ng-options="widgetIndex as widgetIndex.name for widgetIndex in geodash.widgetIndices">
                                    <option value="">Please select type</option>
                                </select>
                             </div>
                        </div>

                       <!-- <select  name="mainType" class="form-control" id="mainType" ng-model="geodash.mainwidgetTypeSelected" ng-change="geodash.updatemainwidgetType(geodash.mainwidgetTypeSelected)"
                             data-ng-options="mainWidgetType as mainWidgetType.name for mainWidgetType in geodash.mainWidgetTypes" >
                        </select>-->
                        <div id="cookedWidget" ng-show="geodash.cooked">
                            <div id="cookedNDVIImage" ng-show="geodash.cookedImage">
                                <div class="form-group">
                                    <label for="cookedImageTitle">Title</label>
                                    <input type="text" name="cookedImageTitle" id="cookedImageTitle" value="" class="form-control">
                                </div>
                                 <label>Select Image Date Range you would like</label>
                                 <div class="input-group input-daterange" id="range_new_cooked">

                                    <input type="text" class="form-control" value="" id="sDate_new_cooked">
                                    <div class="input-group-addon">to</div>
                                    <input type="text" class="form-control" value="" id="eDate_new_cooked">
                                </div>
                                <div class="form-group" style="display:none;">
                                    <label for="cookedImageColumns">Columns</label>
                                    <input type="text" name="cookedImageColumns" id="cookedImageColumns" value="" class="form-control">
                                </div>
                            </div>
                            <div id="cookedNDVIGraph" ng-show="geodash.cookedGraph">

                                <div class="form-group">
                                    <label for="cookedGraphTitle">Title</label>
                                    <input type="text" name="cookedGraphTitle" id="cookedGraphTitle" value="" class="form-control">
                                </div>
                                <label>Select Graph Date Range you would like</label>
                                 <div class="input-group input-daterange" id="range_new_cooked_graph">

                                    <input type="text" class="form-control" value="" id="sDate_new_cooked_graph">
                                    <div class="input-group-addon">to</div>
                                    <input type="text" class="form-control" value="" id="eDate_new_cooked_graph">
                                </div>

                                <div class="form-group" style="display:none;">
                                    <label for="cookedGraphColumns">Columns</label>
                                    <input type="text" name="cookedGraphColumns" id="cookedGraphColumns" value="" class="form-control">
                                </div>

                            </div>
                            <div id="statsform" ng-show="geodash.cookedStats">
                                <div class="form-group">
                                    <label for="stattitle">Title</label>
                                    <input type="text" name="stattitle" id="stattitle" value="" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="statcolumns" style="display:none;">Columns</label>
                                    <input type="text" name="statcolumns" id="statcolumns" value="" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div id="customBuildWidget" ng-show="geodash.custom">

                            <div id="mainform">
                                <div class="form-group">
                                    <label for="title">Title</label>
                                    <input type="text" name="title" id="title" value="" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="collection">Image Collection</label>
                                    <input type="text" name="collection" id="iCollection" value="" class="form-control">
                                </div>
                                <div class="form-group">
                                    <div class="input-group input-daterange" id="range_new">
                                        <input type="text" class="form-control" value="" id="sDate_new">
                                        <div class="input-group-addon">to</div>
                                        <input type="text" class="form-control" value="" id="eDate_new">
                                    </div>
                                    <div class="form-group">
                                        <label for="bands">Bands:(optional)</label>
                                        <input type="text" name="bands" id="bands" value="" class="form-control">
                                    </div>
                                    <div class="form-group" style="display:none;">
                                        <label for="columns">Columns</label>
                                        <input type="text" name="columns" id="columns" value="" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <!-- Allow form submission with keyboard without duplicating the dialog button -->
                                        <input type="submit" tabindex="-1" style="position: absolute; top: -1000px" class="btn btn-primary">
                                    </div>
                                </div>
                            </div>

                        </div>
                    </fieldset>
                </form>
        </div>
        <div class="container-fluid widgetEditor">
                    <div class="row">
                        <div id="updateDashHolder" class="dashHolder widgetEditor">
                            <div>
                                <div style="width:calc(100% - 200px); float:left;" >
                                 <h1 class="page-header">New Layout</h1>
                                 </div>
                                 <div style="width:100px; float:right; ">
                                     <h1><input class="button update-widgets" name="update-widgets" value="Update" type="submit" onclick="gmodcdash.updateWidgets()"></h1>
                                  </div>
                                 <div style="width:100px; float:right; ">
                                    <h1><input class="button update-widgets" name="create-widgets" value="Create" type="submit" onclick="gmodcdash.createWidgetDialog()"></h1>
                                  </div>

                            </div>
                            <br style="clear:both;">
                            <div class="row placeholders" id="replacementContainer">
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:1 /span 3; grid-row: 1; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:4 /span 3; grid-row: 1; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:7 /span 3; grid-row: 1; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:10 /span 3; grid-row: 1; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>

                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:1 /span 3; grid-row: 2; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:4 /span 3; grid-row: 2; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:7 /span 3; grid-row: 2; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:10 /span 3; grid-row: 2; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>

                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:1 /span 3; grid-row: 3; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:4 /span 3; grid-row: 3; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:7 /span 3; grid-row: 3; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:10 /span 3; grid-row: 3; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>

                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:1 /span 3; grid-row: 4; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:4 /span 3; grid-row: 4; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:7 /span 3; grid-row: 4; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:10 /span 3; grid-row: 4; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>

                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:1 /span 3; grid-row: 5; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:4 /span 3; grid-row: 5; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:7 /span 3; grid-row: 5; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:10 /span 3; grid-row: 5; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>

                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:1 /span 3; grid-row: 6; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:4 /span 3; grid-row: 6; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:7 /span 3; grid-row: 6; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:10 /span 3; grid-row: 6; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>

                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:1 /span 3; grid-row: 7; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:4 /span 3; grid-row: 7; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:7 /span 3; grid-row: 7; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                                <div class="placeholder columnSpan3 rowSpan1" style="grid-column:10 /span 3; grid-row: 7; background-color:blue;" onclick="gmodcdash.togglePlacementSelection(this)"></div>
                            </div>
                            <div class="placeholder" style="display:none; grid-column:1 /span 3; grid-row: 1; " id="addholder"></div>
                        </div>
                    </div>
                </div>
    </div>

</div>

<#include "end-content.ftl">
<#include "footer.ftl">