package sec2;

import java.util.ArrayList;
import java.util.Objects;

public class TypeFun2 {
    public static void main(String[] args) {
//        Integer z = 5;
//        int x = 5;
//        Object a = 5;
//        if((int) a == x) {
//            System.out.println("samesies");
//        } else {
//            System.out.println("differentsies");
//        }
        Student2 s1 = new Student2(5, "Jim Beam");
        Student2 s2 = new Student2(6, "Jack Sparrow");
        System.out.println(s1);
        System.out.println(s2);
        System.out.println(s1.equals(s1));
        System.out.println(s1.equals(s2));

        System.out.println();
        ArrayList<Student2> studentList = new ArrayList<>();
        studentList.add(s1);
        studentList.add(s2);
        System.out.println(studentList);

        // simple for loop
        System.out.println("\nfor loop");
        for(int i = 0; i < studentList.size(); i++) {
            Student2 s = studentList.get(i);
            System.out.println(s);
        }

        System.out.println("\nenhanced for loop");
        for(Student2 s : studentList) {
            System.out.println(s);
        }

        System.out.println(studentList.contains(s1));
        System.out.println(studentList.contains(new Student2(7, "Bob Fern")));
        System.out.println(studentList.contains(new Student2(6, "Bob Fern")));
    }
}

class Student2 {
    private int id;
    private String name;

    public Student2(int id, String name) {
        this.id = id;
        this.name = name;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Student2 student)) return false;
        return getId() == student.getId();
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}