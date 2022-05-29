<%@ page contentType="text/html" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <title>Assignment 2</title>
    <style>
        .w3-container {
            background-color: blueviolet;
            width: 40%;
            border-radius: 25px;
            margin: auto;
            margin-top: 140px;
            padding: 10px;
        }

        .agecheck {
            color: white;
            margin-left: 140px;
            visibility: hidden;
        }

        .drop {
            margin-left: 140px;

        }
    </style>
</head>

<body style="background-color: black;">
    <div class="w3-container">
        <div id="inputbox" style="margin-left: 140px;">
            <input placeholder="age" type="number" id="age" onchange="check();">
        </div>
        <h4 class="agecheck" id="dis_error">Your not eligible to Vote</h4>
        <div id="eligible" style="display: none;">
            <form onsubmit="finish();">
                <label style="margin-left: 100px;">Select the party you want to Vote For</label>
                <div class="drop">
                    <select name="party" style="width: 206px;">
                        <option selected disabled>Select</option>
                        <option value="AIADMK">AIADMK</option>
                        <option value="DMK">DMK</option>
                        <option value="MNM">MNM</option>
                        <option value="BJP">BJP</option>
                    </select>
                </div><br>
                <button style="margin-left:200px" type="submit">Submit</button>
            </form>
            <%
                Class.forName("org.sqlite.JDBC");
                try{
                    Connection conn = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\svsra\\Documents\\NetBeansProjects\\HelloWorld\\Database\\store.db");
                    Statement stat = conn.createStatement();
                    int cnt = 0;
                    String selected_party = request.getParameter("party");
                    ResultSet rs = stat.executeQuery("select * from selections where party = '"+selected_party+"'");
                    while (rs.next()){
                        cnt = rs.getInt("count");
                        System.out.print(rs.getString("party"));
                    }
                    String sql = "DELETE FROM selections WHERE party = '"+selected_party+"'";
                    stat.executeUpdate(sql);
                    sql = "INSERT INTO selections VALUES (?,?)";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, selected_party);
                    stmt.setInt(2, cnt + 1);
                    stmt.executeUpdate();
                    conn.close();
                }
                catch(Exception e){
                    System.out.print("Error Occured");
                }
            %>
        </div>
    </div>
    <script>
        function finish(){
            alert("Response Recorded.Thank you");
        }
        function check() {
            let age = parseInt(document.getElementById("age").value);
            document.getElementById("inputbox").style.display = 'none';
            if (age > 1 && age < 18) {
                document.getElementById("dis_error").style.visibility = 'visible';
            }
            else if (age > 18) {
                document.getElementById("eligible").style.display = 'block';
            }
        }
    </script>
</body>
</html>
<!--Note create a database store.db in sqlite3 with this code
    create table selections(party text,count integer);
    Run with the jar file sqlite-jdbc-3.36.0.3.jar-->
