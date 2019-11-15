<%@ page contentType="text/javascript" %>
    <%@ taglib prefix="formfactory" uri="http://www.jahia.org/formfactory/functions" %>
    <%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>

    angular
        .module('formFactory')
        .directive('ffSelectBasic', ['$log', 'ffTemplateResolver', function ($log, ffTemplateResolver) {
            var directive = {
                restrict: 'E',
                require: ['^ffController'],
                templateUrl: function(el, attrs) {
                    return ffTemplateResolver.resolveTemplatePath('${formfactory:addFormFactoryModulePath('/form-factory-definitions/select-basic', renderContext)}', attrs.viewType);
                },
                link: linkFunc
            };

            return directive;

            function linkFunc(scope, el, attr, ctrl) {
                var formController = ctrl[0];
                scope.input.options = angular.fromJson(scope.input.options);
                //set visible property if it hasnt been set yet.
                for (var i in scope.input.options) {
                    if (scope.input.options[i].visible == null) {
                        scope.input.options[i].visible = true;
                    }
                }
                if (!formController.isLiveMode()) {
                    scope.$watch(function() {return scope.input.value; }, function(newValue) {
                        if (newValue instanceof Array) {
                            if (newValue.length > 0) {
                                scope.input.value = newValue[0];
                            }
                            else {
                                scope.input.value = null;
                            }
                        }
                    });
                }
            }
        }]);