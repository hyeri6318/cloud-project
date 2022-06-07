<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <title>CHANGE PASSWORD</title>
        <link rel="stylesheet" href="deleteprofile.css">
    </head>

    <body>
        <div class="head">
            <h3 style="
                margin: 0;
                font-size: 2.5rem;
                color: white;
            ">
                세상에 나쁜 요리는 없다
            </h3>
        </div>
        <div style="height: 100px;">&nbsp;</div>
            <form action="changeprofile.jsp" method="post">
                <p class="easy-login" align="center">PROFILE</p>
            </form>
        

        <form>
            
        <div class="body">
            <form method="post" name="form">
                <div class="form-group">
                    <p calss="ref" align="left">기존 비밀번호
                        <input type="password" class="form-group" name="pps" required>
                    </p>
                </div>

                <div class="form-group">
                    <p class="ref" align="left">변경 비밀번호
                        <input type="password" class="form-group" name="nps1" required>
                    </p>
                </div>

                <div class="form-group">
                    <p class="ref" align="left">변경 비밀번호 확인
                        <input type="password" class="form-group" name="nps2" required>
                    </p>
                </div>

                <div class="change-button">
                    <div class="btn btn-primary">
                        <input type="submit" value="CHANGE" class="btn btn-primary" onClick="form.action='changeprofile.jsp'">
                    </div>
                </div>
            </form>
        </div>
        </form>
    </body>
</html>