package Actions;

import Models.DatabaseClass;
import Models.classes.Exams;
import com.opensymphony.xwork2.ActionSupport;

import java.sql.SQLException;
import java.util.ArrayList;

public class PagingAction extends ActionSupport {
    private String action,index;
    private ArrayList<Exams> exams;
    private DatabaseClass db = new DatabaseClass();

    public PagingAction() throws SQLException, ClassNotFoundException {
    }

    public ArrayList<Exams> getExams() {
        return exams;
    }

    public void setExams(ArrayList<Exams> exams) {
        this.exams = exams;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    @Override
    public String execute() throws Exception {
        String returnPage = "home";
        int index;
        if(action == null)
            return returnPage;
        if(this.index == null) {
            index = 1;
        }
        else {
            index = Integer.parseInt(this.index);
        }
        switch (action) {
            case "result":
                exams = db.pagingResult(index);
                returnPage = "result";
                break;
        }
        return returnPage;
    }
}
