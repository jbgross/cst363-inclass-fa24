import java.util.ArrayList;
import java.util.Objects;

public class TypeFun extends Object {
    public static void main(String[] args) {
//        Object o = 5;
//        System.out.println(o);
////        Integer i = (Integer) o;
//        if((int) o == 5) {
//            System.out.println("samesies");
//        }
        Student s1 = new Student(5, "Darius");
        Student s2 = new Student(6, "Matthias");
        System.out.println(s1);
        System.out.println(s2);
        System.out.println(s1.equals(s1));
        System.out.println(s2.equals(s1));

        ArrayList<Student> studentList = new ArrayList<>();
        studentList.add(s1);
        studentList.add(s2);
        System.out.println(studentList);

        System.out.println("regular for loop");
        for(int i = 0; i < studentList.size(); i++) {
            Student s = studentList.get(i);
            System.out.println(s);
        }

        System.out.println("\nenhanced for loop");
        for(Student s : studentList) {
            System.out.println(s);
        }

        System.out.println("\ncontains");
        System.out.println(studentList.contains(s1));
        System.out.println(studentList.contains(new Student(7, "hello")));
        System.out.println(studentList.contains(new Student(6, "hello")));
    }
}

class Student {

    private int id;
    private String name;

    public Student(int id, String name) {
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
        if (!(o instanceof Student student)) return false;
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
