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

            getSitesQuery = "{ \n" +
                    "  jcr(workspace: LIVE) {\n" +
                    "   nodeByPath(path: \"/sites/\") {\n" +
                    "     children (typesFilter: {types: [\"jnt:virtualsite\"]}) {\n" +
                    "      nodes{\n" +
                    "        name\n" +
                    "        displayName\n" +
                    "      }\n" +
                    "    }\n" +
                    "   }\n" +
                    " }\n" +
                    "}"
                $http({
                    url: "/modules/graphql",
                    method: "POST",
                    data:JSON.stringify({
                            query: getSitesQuery
                    }
                    ),
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    },
                }).then(function(response) {
                    scope.sitesList = response.data.data.jcr.nodeByPath.children.nodes;
                }, function(error) {
                    console.log(error);
                });
            }



        }]);