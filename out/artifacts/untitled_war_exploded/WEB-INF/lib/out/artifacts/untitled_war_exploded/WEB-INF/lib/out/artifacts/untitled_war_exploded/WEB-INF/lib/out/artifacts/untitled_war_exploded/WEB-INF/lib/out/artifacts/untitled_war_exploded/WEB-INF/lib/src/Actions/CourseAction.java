package Actions;

import Models.classes.Courses;
import Models.classes.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import Models.DatabaseClass;

import java.sql.SQLException;

public class CourseAction extends ActionSupport {
    private String action,coursename, totalmarks, time,courseCode,index,query;

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public DatabaseClass getDb() {
        return db;
    }

    public void setDb(DatabaseClass db) {
        this.db = db;
    }

    public String getCoursename() {
        return coursename;
    }

    public void setCoursename(String coursename) {
        this.coursename = coursename;
    }

    public String getTotalmarks() {
        return totalmarks;
    }

    public void setTotalmarks(String totalmarks) {
        this.totalmarks = totalmarks;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    DatabaseClass db = new DatabaseClass();


    public CourseAction() throws SQLException, ClassNotFoundException {
    }


    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    @Override
    public String execute() throws Exception {
        String returnAction = "";
        if(action==null) {
            return "coursePage";
        }

        switch (action) {
            case "add":
                add();
                returnAction = "coursePage";
                break;
            case "updateGet":
                if(ActionContext.getContext().getSession().get("index")!=null) {
                    this.index = ActionContext.getContext().getSession().get("index").toString();
                }
                if(ActionContext.getContext().getSession().get("query")!=null) {
                    this.query = ActionContext.getContext().getSession().get("query").toString();
                }
                updateGet();
                returnAction = "updatePage";
                break;
            case "update":
                this.index = ActionContext.getContext().getSession().get("index").toString();
                this.query = ActionContext.getContext().getSession().get("query").toString();
                update();
                returnAction = "updatePage";
                break;
            case "deleteGet":
                if(ActionContext.getContext().getSession().get("query")!=null) {
                    this.query = ActionContext.getContext().getSession().get("query").toString();
                }
                if(ActionContext.getContext().getSession().get("index")!=null) {
                    this.index = ActionContext.getContext().getSession().get("index").toString();
                }
                deleteGet();
                returnAction = "deletePage";
                break;
            case "delete":
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
                delete();
                returnAction = "deletePage";
                break;
        }

        return returnAction;
    }

    private void add() {
        db.addNewCourse(coursename,Integer.parseInt(totalmarks),
                time,courseCode);
    }



    private void update() {
        String fCourseID = this.courseCode;
        db.updateCourse(fCourseID,coursename,Integer.parseInt(totalmarks),time);
        ActionContext.getContext().getSession().remove("isUpdate");
        ActionContext.getContext().getSession().remove("courseUpdate");
    }

    private void updateGet() {
        Courses courses = db.getCourseIdDetails(courseCode);
        ActionContext.getContext().getSession().put("isUpdate",1);
        ActionContext.getContext().getSession().put("courseUpdate",courses);
    }

    private void delete() {
        String fCourseID = this.courseCode;
        db.delCourse(fCourseID);
        ActionContext.getContext().getSession().remove("isDelete");
        ActionContext.getContext().getSession().remove("courseDelete");
    }

    private void deleteGet() {
        Courses courses = db.getCourseIdDetails(courseCode);
        ActionContext.getContext().getSession().put("isDelete",1);
        ActionContext.getContext().getSession().put("courseDelete",courses);
    }
}
