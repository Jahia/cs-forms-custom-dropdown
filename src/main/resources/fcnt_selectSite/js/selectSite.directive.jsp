<%@ page contentType="text/javascript" %>
<%@ taglib prefix="formfactory" uri="http://www.jahia.org/formfactory/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>

    angular
        .module('formFactory')
        .directive('ffSelectSite', ['$log','$http', 'ffTemplateResolver', function ($log,$http, ffTemplateResolver) {
            var directive = {
                restrict: 'E',
                require: ['^ffController'],
                templateUrl: function(el, attrs) {
                    return ffTemplateResolver.resolveTemplatePath('${formfactory:addFormFactoryModulePath('/form-factory-definitions/select-site', renderContext)}', attrs.viewType);
                },
                link: linkFunc
            };

            return directive;


            function linkFunc(scope, el, attr, ctrl) {

                $http({
                    url: "<c:url value='${url.base}${currentNode.path}'/>.getSites.do",
                    method: "POST",
                    headers: {'Content-Type': 'application/json'}
                }).then(function(response) {
                    scope.sitesList = response.data.data;
                }, function(error) {
                    console.log(error);
                });
            }
        }]);