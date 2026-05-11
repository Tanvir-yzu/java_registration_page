package beans;

import java.io.Serializable;

public class Person implements Serializable {
    private int id;
    private String name;
    private String pwd;
    private String gender;

    public Person() {
    }

    public Person(int id, String name, String pwd, String gender) {
        this.id = id;
        this.name = name;
        this.pwd = pwd;
        this.gender = gender;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "Person[id=" + id + ", name=" + name + ", pwd=" + pwd + ", gender=" + gender + "]";
    }
}
