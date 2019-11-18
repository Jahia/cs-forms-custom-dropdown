package org.jahia.modules.csformdropdown.actions;

import org.jahia.bin.Action;
import org.jahia.bin.ActionResult;
import org.jahia.services.content.JCRNodeIteratorWrapper;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.URLResolver;
import org.json.JSONObject;
import org.slf4j.Logger;

import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class getPagesAction extends Action {
    private transient static Logger logger = org.slf4j.LoggerFactory.getLogger(getPagesAction.class);

    @Override
    public ActionResult doExecute(HttpServletRequest req, RenderContext renderContext, Resource resource, JCRSessionWrapper session, Map<String, List<String>> parameters, URLResolver urlResolver) throws Exception {
        final String site_key = parameters.get("site_key").get(0);

        String jsonData = "{\"data\":[";


        String query = "SELECT * FROM [jnt:page] AS result WHERE ISDESCENDANTNODE(result, '/sites/" + site_key + "')";

        QueryManager qm = session.getWorkspace().getQueryManager();
        Query q = qm.createQuery(query, Query.JCR_SQL2);
        QueryResult result = q.execute();
        NodeIterator nodeIterator = result.getNodes();

        while (nodeIterator.hasNext()) {
            JCRNodeWrapper node = (JCRNodeWrapper)nodeIterator.nextNode();
            jsonData += "  {\n"
                    + "      \"page_name\": \"" + node.getDisplayableName() + "\",\n"
                    + "      \"page_key\": \"" + node.getName() + "\"\n"
                    + "    }";
            if (nodeIterator.hasNext()) {
                jsonData += ",\n";
            }
        }
        jsonData += "]}";

        // Remove any existing REDIRECT_TO parameter to be sure to go to node.getPath
        final JSONObject object = new JSONObject(jsonData);
        return new ActionResult(HttpServletResponse.SC_OK, null, object);
    }

}