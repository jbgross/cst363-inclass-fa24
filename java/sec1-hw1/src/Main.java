public class Main {
    public static void main(String[] args) {
//        System.out.println("Hello world!");
        Instructor i1 = new Instructor(12345, "Carlos", "CS", 200000);
        Instructor i2 = new Instructor(12346, "Daniel", "CS", 250000);
        Instructor i3 = new Instructor(12346, "Dnaeil", "CS", 250000);
//        System.out.println(i1);
//        System.out.println(i2);
//        System.out.println(i1.equals(i2));
//        System.out.println(i1.equals(i1));
//        System.out.println(i1 == i1);
//        System.out.println(i2.equals(i3));
//        System.out.println(i2 == i3);

        Table t1 = new Table();
        System.out.println(t1);
        t1.insert(i1);
        t1.insert(i2);
        System.out.println(t1.insert(i3));
        System.out.println(t1);
        // remove 12345
//        System.out.println(t1.delete(12345));
//        System.out.println(t1.delete(12345));
        System.out.println(t1);
        System.out.println(t1.lookup(12346));
        System.out.println(t1.lookup(12345));
        t1.insert(new Instructor(12347, "Daniel", "CS", 200000));
        System.out.println("testing eval()");
        System.out.println(t1.eval("Name", "Carlos"));
        System.out.println(t1.eval("Name", "Daniel"));
        System.out.println("testing eval() with salary");
        System.out.println(t1.eval("Salary", 300000));
        System.out.println(t1.eval("Salary", 200000));

    }
}