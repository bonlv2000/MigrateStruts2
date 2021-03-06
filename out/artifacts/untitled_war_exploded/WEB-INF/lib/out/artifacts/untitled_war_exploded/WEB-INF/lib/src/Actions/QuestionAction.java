package Actions;

import Models.classes.Courses;
import Models.classes.Questions;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import Models.DatabaseClass;

import java.sql.SQLException;

public class QuestionAction extends ActionSupport {
    private String action,coursename,question,opt1,opt2,opt3,opt4,correct,qid,index,query="";

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

    public String getOpt1() {
        return opt1;
    }

    public void setOpt1(String opt1) {
        this.opt1 = opt1;
    }

    public String getQid() {
        return qid;
    }

    public void setQid(String qid) {
        this.qid = qid;
    }

    private DatabaseClass db = new DatabaseClass();

    public QuestionAction() throws SQLException, ClassNotFoundException {
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getCoursename() {
        return coursename;
    }

    public void setCoursename(String coursename) {
        this.coursename = coursename;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getOp1() {
        return opt1;
    }

    public void setOp1(String op1) {
        this.opt1 = op1;
    }

    public String getOpt2() {
        return opt2;
    }

    public void setOpt2(String opt2) {
        this.opt2 = opt2;
    }

    public String getOpt3() {
        return opt3;
    }

    public void setOpt3(String opt3) {
        this.opt3 = opt3;
    }

    public String getOpt4() {
        return opt4;
    }

    public void setOpt4(String opt4) {
        this.opt4 = opt4;
    }

    public String getCorrect() {
        return correct;
    }

    public void setCorrect(String correct) {
        this.correct = correct;
    }

    @Override
    public String execute() throws Exception {
        String questionPage = "";
        if(action == null)
            return "badRequest";
        switch (action) {
            case "add":
                this.index = db.totalQuestionByCourseCode(coursename,"")+"";
                add();
                questionPage = "questionPage";
                break;
            case "updateGet":
                if(ActionContext.getContext().getSession().get("index")!=null) {
                    this.index = ActionContext.getContext().getSession().get("index").toString();
                }
                if(ActionContext.getContext().getSession().get("query")!=null) {
                    this.query = ActionContext.getContext().getSession().get("query").toString();
                }
                updateGet();
                questionPage = "updatePage";
                break;
            case "update":
                this.index = ActionContext.getContext().getSession().get("index").toString();
                coursename = ActionContext.getContext().getSession().get("courseName").toString();
                this.query = ActionContext.getContext().getSession().get("query").toString();
                update();
                questionPage = "updatePage";
                break;
            case "deleteGet":
                if(ActionContext.getContext().getSession().get("query")!=null) {
                    this.query = ActionContext.getContext().getSession().get("query").toString();
                }
                if(ActionContext.getContext().getSession().get("index")!=null) {
                    this.index = ActionContext.getContext().getSession().get("index").toString();
                }
                deleteGet();
                questionPage = "deletePage";
                break;
            case "delete":
                delete();
                coursename = ActionContext.getContext().getSession().get("courseName").toString();
                this.query = ActionContext.getContext().getSession().get("query").toString();
                int indexTemp = Integer.parseInt(ActionContext.getContext().getSession().get("index").toString());
                int totalPage = db.totalQuestionByCourseCode(coursename,this.query);
                if(indexTemp>totalPage) {
                    indexTemp--;
                    this.index = indexTemp+"";
                    ActionContext.getContext().getSession().put("index",indexTemp);
                }
                else {
                    this.index = indexTemp+"";
                }
                questionPage = "deletePage";
                break;
        }
        return questionPage;
    }


    private void add() {
        db.addQuestion(coursename, question, opt1, opt2,opt3,
                opt4, correct);
    }

    private void update() {
        int fqid = Integer.parseInt(this.qid);
        db.updateQuestions(fqid,question,opt1,opt2,opt3,opt4,correct);
        ActionContext.getContext().getSession().remove("isUpdate");
        ActionContext.getContext().getSession().remove("questionUpdate");
    }

    private void updateGet() {
        Questions questions = db.getQuestionIdDetails(qid);
        ActionContext.getContext().getSession().put("isUpdate",1);
        ActionContext.getContext().getSession().put("questionUpdate",questions);
    }

    private void delete() {
        int fqid = Integer.parseInt(this.qid);
        db.delQuestion(fqid);
        ActionContext.getContext().getSession().remove("isDelete");
        ActionContext.getContext().getSession().remove("questionDelete");
    }

    private void deleteGet() {
        Questions questions = db.getQuestionIdDetails(qid);
        ActionContext.getContext().getSession().put("isDelete",1);
        ActionContext.getContext().getSession().put("questionDelete",questions);
    }
}
