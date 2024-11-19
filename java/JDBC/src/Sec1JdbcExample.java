import java.sql.*;

public class Sec1JdbcExample {
    public static void main(String[] args) throws SQLException {
        Connection cnx = DriverManager.getConnection(
                "jdbc:mysql://localhost/course",
                "root",
                "secret"
        );
        cnx.setAutoCommit(false);

        PreparedStatement ps = cnx.prepareStatement("select * from instructor where dept_name = ?");
        ps.setString(1, "Comp. Sci.");

        ResultSet rs = ps.executeQuery();

        while(rs.next()) {
            System.out.println(rs.getString("name"));
        }




    }
}
