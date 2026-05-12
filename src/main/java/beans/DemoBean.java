package beans;

import java.io.Serializable;

public class DemoBean implements Serializable {
    private String scopeName;
    private String value;
    private int counter;

    public DemoBean() {
    }

    public DemoBean(String scopeName, String value, int counter) {
        this.scopeName = scopeName;
        this.value = value;
        this.counter = counter;
    }

    public String getScopeName() {
        return scopeName;
    }

    public void setScopeName(String scopeName) {
        this.scopeName = scopeName;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public int getCounter() {
        return counter;
    }

    public void setCounter(int counter) {
        this.counter = counter;
    }
}
