<!-- Select Page-->
<div class="form-group"
     ng-class="{'has-error': form[input.name].$invalid&&form[input.name].$dirty}"
     ng-show="resolveLogic()">
    <label class="col-sm-2 control-label">
        {{input.label}}<span ng-if="isRequired()" ng-show="asteriskResolver()"><sup>&nbsp;<i class="fa fa-asterisk fa-sm"></i></sup></span>
    </label>

    <div class="col-sm-10">
        <select type="select-basic"
                class="form-control {{input.inputsize}}"
                ng-model-options="{allowInvalid:true}"
                name="{{input.name}}"
                ng-model="input.value"
                ng-required="isRequired()"
                ng-disabled="readOnly"
                ng-options="page as page.page_name for page in pageList track by page.page_key"
                ng-disabled="readOnly"
                ff-validations
                ff-logic
                ff-focus-tracker="{{input.name}}">
            <option ng-if="input.value == '' || input.value === null" value="">{{input.placeholder}}</option>

        </select>
        <span class="help-block"
              ng-show="input.helptext != undefined">
            {{input.helptext}}
        </span>
        <span class="help-block"
              ng-repeat="(validationName, validation) in input.validations"
              ng-show="showErrorMessage(validationName)">
            {{validation.message}}
        </span>
    </div>
    <div class="clearfix"/>
</div>