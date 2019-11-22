<%@ page contentType="text/javascript" %>
    <%@ taglib prefix="formfactory" uri="http://www.jahia.org/formfactory/functions" %>
    <%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
    <%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>

    angular
        .module('formFactory')
        .directive('ffSelectPage', ['$log','$http', 'ffTemplateResolver', function ($log,$http, ffTemplateResolver) {
            var directive = {
                restrict: 'E',
                require: ['^ffController'],
                templateUrl: function(el, attrs) {
                    return ffTemplateResolver.resolveTemplatePath('${formfactory:addFormFactoryModulePath('/form-factory-definitions/select-page', renderContext)}', attrs.viewType);
                },
                link: linkFunc
            };

            return directive;

            function linkFunc(scope, el, attr, ctrl) {
                var site_key;
                var formController = ctrl[0];
                if(formController.getPreviousStepInputValue('select_site')){
                    site_key = formController.getPreviousStepInputValue('select_site').value.name;
                    getPages(scope,site_key);
                }else{
                    scope.$watch(function() {
                        return formController.getCurrentStepInput('select_site').value;
                    }, function(a, b) {
                        //Updated checkbox status when input.value is changed from key value directive
                        site = formController.getCurrentStepInput('select_site').value;
                        if (site!=null && site.name!=null && site.name.length>1){
                            getPages(scope,site.name);
                        }
                    });
                }
            }

            function getPages(scope,sitekey){
                $http({
                    url: "<c:url value='${url.base}${currentNode.path}'/>.getPages.do",
                    method: "POST",
                    params: {'site_key': sitekey },
                    headers: {'Content-Type': 'application/json'}
                }).then(function(response) {
                    scope.pageList = response.data.data;
                }, function(error) {
                    console.log(error);
                });
            }

        }]);