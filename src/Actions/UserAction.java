package Actions;

import Models.DatabaseClass;
import Models.EncryptPassword;
import Models.MailConfig;
import Models.classes.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Random;

public class UserAction extends ActionSupport {
    private String action="",userId="",firstName="",lastName="",email="",password="",userName="",query="";
    private DatabaseClass db = new DatabaseClass();
    private String index;

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public UserAction() throws SQLException, ClassNotFoundException {
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public void validate() {
        if(action==null)
            return;
        if(action.equals("register")) {
            try {
                if(db.isGmailExist(email)) {
                    addFieldError("email","Email has already exist, must be unique!");
                }
                    if(db.getAllUsers().stream().anyMatch(s ->s.getUserName().equals(userName))) {
                        addFieldError("userName","Username has already exist, must be unique!");
                    }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }else if(action.equals("update")) {
            if(db.getAllUsers().stream().anyMatch(s -> !s.getUserName().equals(userName)
                    && s.getEmail().equals(email))) {
                addFieldError("emailValidation","Email has already exist, must be unique!");
                ActionContext.getContext().getSession().put("isUpdate",1);
            }
        }
    }

    @Override
    public String execute() throws Exception {
        String result = "";
        if(action==null)
            return "badRequest";
        switch (action) {
            case "resetGet":
                ActionContext.getContext().getSession().put("email",email);
                result = "resetPage";
                break;
            case "updateGet":
                if(ActionContext.getContext().getSession().get("index")!=null) {
                    this.index = ActionContext.getContext().getSession().get("index").toString();
                }
                if(ActionContext.getContext().getSession().get("query")!=null) {
                    this.query = ActionContext.getContext().getSession().get("query").toString();
                }
                updateGet();
                result = "updatePage";
                break;
            case "deleteGet":
                if(ActionContext.getContext().getSession().get("query")!=null) {
                    this.query = ActionContext.getContext().getSession().get("query").toString();
                }
                if(ActionContext.getContext().getSession().get("index")!=null) {
                    this.index = ActionContext.getContext().getSession().get("index").toString();
                }
                deleteGet();
                result = "DeletePage";
                break;
            case "sendMailReset":
                sendMailReset();
                result = "redirectToReset";
                break;
            case "update":
                if(ActionContext.getContext().getSession().get("query")!=null) {
                    this.query = ActionContext.getContext().getSession().get("query").toString();
                }
                if(ActionContext.getContext().getSession().get("index")!=null) {
                    this.index = ActionContext.getContext().getSession().get("index").toString();
                }
                ActionContext.getContext().getSession().remove("isUpdate");
                update();
                result = "updatePage";
                break;
            case "addFromAdmin":
                if(ActionContext.getContext().getSession().get("query")!=null) {
                    this.query = ActionContext.getContext().getSession().get("query").toString();
                }
                if(ActionContext.getContext().getSession().get("index")!=null) {
                    this.index = ActionContext.getContext().getSession().get("index").toString();
                    int indexTemp = Integer.parseInt(this.index);
                    if(db.totalPageAccount(query)%3==0) {
                        indexTemp++;
                    }
                    this.index = indexTemp+"";
                }
                try {
                    register();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                result = "accountPage";
                break;
            case "delete":
                delete();
                this.query = ActionContext.getContext().getSession().get("query").toString();
                int indexTemp = Integer.parseInt(ActionContext.getContext().getSession().get("index").toString());
                int totalPage = db.totalPageAccount(this.query);
                if(indexTemp>totalPage) {
                    indexTemp--;
                    this.index = indexTemp+"";
                    ActionContext.getContext().getSession().put("index",indexTemp);
                }
                else {
                    this.index = indexTemp+"";
                }
                result="DeletePage";
                break;
            case "register":
                try {
                    result = register();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                break;
        }
        return result;
    }

    private String register() throws SQLException {

        String pass= EncryptPassword.generateHash(password);
        try {
            db.addNewStudent(firstName,lastName,userName,email,pass);
        }
        catch (Exception e) {
            return "failed";
        }

        return "success";
    }

    private void update() {
        int userId = Integer.parseInt(this.userId);
        db.updateStudent(userId,firstName,lastName,email,password);
        ActionContext.getContext().getSession().remove("isUpdate");
        ActionContext.getContext().getSession().remove("userUpdate");
    }

    private void updateGet() {
        User user = db.getUserDetails(userId);
        ActionContext.getContext().getSession().put("isUpdate",1);
        ActionContext.getContext().getSession().put("userUpdate",user);
    }

    private void delete() {
        int userId = Integer.parseInt(this.userId);
        db.delUser(userId);
        ActionContext.getContext().getSession().remove("isDelete");
        ActionContext.getContext().getSession().remove("userDelete");
    }

    private void deleteGet() {
        User user = db.getUserDetails(userId);
        ActionContext.getContext().getSession().put("isDelete",1);
        ActionContext.getContext().getSession().put("userDelete",user);
    }

    private void sendMailReset() {
        int code = new Random().nextInt(9999);
        ActionContext.getContext().getSession().put("code",code);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.getSession().setMaxInactiveInterval(120);
        String content = "Code to reset password: "+code;
        MailConfig.sendMail(content,email);
    }
}
