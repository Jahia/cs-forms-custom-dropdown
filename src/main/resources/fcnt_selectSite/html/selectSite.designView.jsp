<div class="row">
    <div class="col-md-12">
        <div class="row" ng-if="!inTranslateMode">
            <div class="col-md-12 well">
                <label class="control-label">
                    <span message-key="ff.label.changeInputFieldName"></span>
                </label>
                <input type="text"
                       class="form-control"
                       ng-model="input.name"
                       ff-name-uniqueness-check
                       ff-logics-syncronizer/>
                <span class="help-block hide">
                    <span message-key="angular.ffFormBuilderDirective.message.duplicateInputName"></span>
                </span>
            </div>
            <div class="clearfix"></div>
        </div>
        <br/>
        <label>
            <span message-key="ff.label.changeLabel"></span>
        </label>
        <input type="text" class="form-control" ng-model="input.label"/>
        <br/>
        <label>
            <span message-key="ff.label.changePlaceholder"></span>
        </label>
        <input type="text" class="form-control" ng-model="input.placeholder"/>
        <br/>
        <label>
            <span message-key="ff.label.changeHelpText"></span>
        </label>
        <input type="text" class="form-control" ng-model="input.helptext"/>
        <br/>
        <div class="row" ng-if="!inTranslateMode">
            <div class="col-md-12">
                <label>
                    <span message-key="ff.label.changeInputSize"></span>
                </label>
                <select class="form-control" ng-model="input.inputsize">
                    <option value="input-lg" message-key="ff.label.large"></option>
                    <option value="input-md" message-key="ff.label.medium"></option>
                    <option value="input-sm" message-key="ff.label.small"></option>
                </select>
            </div>
        </div>
        <br/>
        <ff-key-value-maker ng-if="input.options" input="input"
                            property="options"
                            in-translate-mode="inTranslateMode"
                            enable-csv="true">
        </ff-key-value-maker>
    </div>
</div>