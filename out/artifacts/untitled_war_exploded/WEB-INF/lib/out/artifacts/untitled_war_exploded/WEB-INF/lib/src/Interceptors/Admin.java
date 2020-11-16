package Interceptors;

import Models.classes.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.opensymphony.xwork2.interceptor.Interceptor;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.RolesInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Admin extends RolesInterceptor {

    public Admin() {
        super();
    }

    @Override
    public void setAllowedRoles(String roles) {
        super.setAllowedRoles(roles);
    }

    @Override
    public void setDisallowedRoles(String roles) {
        super.setDisallowedRoles(roles);
    }

    @Override
    public String intercept(ActionInvocation invocation) throws Exception {
        HttpServletRequest request = ServletActionContext.getRequest();
        if(request.isUserInRole("admin")) {
            return 
        }
    }

    @Override
    protected List<String> stringToList(String val) {
        return super.stringToList(val);
    }

    @Override
    protected boolean isAllowed(HttpServletRequest request, Object action) {
        return super.isAllowed(request, action);
    }

    @Override
    protected String handleRejection(ActionInvocation invocation, HttpServletResponse response) throws Exception {
        return super.handleRejection(invocation, response);
    }

    @Override
    protected boolean areRolesValid(List<String> roles) {
        return super.areRolesValid(roles);
    }
}
