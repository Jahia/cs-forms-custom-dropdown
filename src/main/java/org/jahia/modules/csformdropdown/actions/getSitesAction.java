package org.jahia.modules.csformdropdown.actions;

import org.apache.velocity.tools.generic.DateTool;
import org.jahia.api.Constants;
import org.jahia.bin.Action;
import org.jahia.bin.ActionResult;
import org.jahia.bin.Jahia;
import org.jahia.bin.Render;
import org.jahia.params.ProcessingContext;
import org.jahia.registries.ServicesRegistry;
import org.jahia.services.content.JCRContentUtils;
import org.jahia.services.content.JCRNodeIteratorWrapper;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.mail.MailService;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.URLResolver;
import org.jahia.services.usermanager.JahiaUser;
import org.jahia.services.usermanager.JahiaUserManagerService;
import org.jahia.settings.SettingsBean;
import org.jahia.utils.Url;
import org.json.JSONObject;
import org.slf4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

public class getSitesAction extends Action {
    private transient static Logger logger = org.slf4j.LoggerFactory.getLogger(getSitesAction.class);

    @Override
    public ActionResult doExecute(HttpServletRequest req, RenderContext renderContext, Resource resource, JCRSessionWrapper session, Map<String, List<String>> parameters, URLResolver urlResolver) throws Exception {
        String jsonData = "{\"data\":[";
        JCRSessionWrapper jcrSessionWrapper = resource.getNode().getSession();
        JCRNodeWrapper sitesNode = jcrSessionWrapper.getNode("/sites/");
        JCRNodeIteratorWrapper nodes = sitesNode.getNodes();
        while (nodes.hasNext()) {
            JCRNodeWrapper site = (JCRNodeWrapper) nodes.next();
            jsonData += "  {\n"
                    + "      \"site_name\": \"" + site.getDisplayableName() + "\",\n"
                    + "      \"site_key\": \"" + site.getName() + "\"\n"
                    + "    }";
            if (nodes.hasNext()) {
                jsonData += ",\n";
            }
        }
        jsonData += "]}";
        // Remove any existing REDIRECT_TO parameter to be sure to go to node.getPath
        final JSONObject object = new JSONObject(jsonData);
        return new ActionResult(HttpServletResponse.SC_OK, null, object);
    }
}