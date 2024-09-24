public class Main {
    public static void main(String[] args) {
        Instructor i1 = new Instructor(12345, "John", "CS", 200000);
        Instructor i2 = new Instructor(12346, "Hani", "CS", 250000);
        System.out.println(i1);
        System.out.println(i2);
        Table cs = new Table();
        System.out.println("Testing insert");
        cs.insert(i1);
        cs.insert(i2);
        System.out.println(cs.insert(i1));
        System.out.println(cs.insert(new
                Instructor(12345, "Jhon", "CS", 200000)));
        System.out.println(cs);

        System.out.println("Testing delete");
//        System.out.println(cs.delete(12346));
        System.out.println(cs.delete(12347));
        System.out.println(cs);

        System.out.println("Testing lookup");
        System.out.println(cs.lookup(12345));
        System.out.println(cs.lookup(12347));

        System.out.println("Testing eval");
        System.out.println(cs.eval("ID", 12345));
        System.out.println(cs.eval("ID", 12347));

        System.out.println("testing eval with department name");
        System.out.println(cs.eval("Dept_Name", "CS"));
        System.out.println(cs.eval("Dept_Name", "CD"));

    }
}