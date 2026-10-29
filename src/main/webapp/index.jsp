
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mobile Repair Job Card Entry</title>

    <style>
        body {
            font-family: Arial;
            background: #f2f2f2;
            padding: 30px;
        }

        .box {
            background: white;
            width: 350px;
            margin: auto;
            padding: 20px;
            border-radius: 10px;
        }


        input {
            width: 95%;
            padding: 8px;
            margin: 8px 0;
        }

        button {
            background: blue;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
        }
    </style>

    <script>
        function checkForm() {
            let c = document.getElementById("customer").value.trim();
            let m = document.getElementById("model").value.trim();
            let p = document.getElementById("problem").value.trim();

            if (c == "" || m == "" || p == "") {
                alert("Please fill all fields");
                return false;
            }

            return true;
        }
    </script>
</head>

<body>
    <div class="box">
        <h2>Mobile Repair Job Card Entry</h2>

        <form action="result.jsp" method="post"
              onsubmit="return checkForm()">

            Customer:
            <input type="text" id="customer" name="customer"
                   maxlength="40" required>

            Model:
            <input type="text" id="model" name="model"
                   maxlength="30" required>

            Problem:
            <input type="text" id="problem" name="problem"
                   maxlength="60" required>

            <button type="submit">Save</button>
        </form>
    </div>
</body>
</html>
