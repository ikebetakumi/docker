<?php
$title = 'Hello World';
?>
<!DOCTYPE html>
<head>
    <title><?php echo $title; ?> | localhost</title>
</head>
<body>
    <h1><?php echo $title; ?></h1>
<?php

$host = 'mysql';// MySQLコンテナのサービス名
$dbname = $_ENV['MYSQL_DATABASE'];
$username = 'root';
$password = $_ENV['MYSQL_ROOT_PASSWORD'];

$errMessage = '';
try {
    $db = new PDO("mysql:host={$host};dbname={$dbname};charset=utf8", $username, $password);
    $mysqlStatus = '成功';
} catch (\Throwable $th) {
    $mysqlStatus = '失敗';
    $errMessage = $th->getMessage();
}
echo '<p>MySQL：接続に'.$mysqlStatus.'しました。</p>';
if ($errMessage !== '') {
    echo '<p style="color:red;">'.$errMessage.'</p><br>';
}

# SQL　文を実行
// $stmt = $db->prepare('SELECT * FROM mytable');
// $stmt->execute();
// $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
// foreach ($results as $result) {
//     echo $result['id'] . '. ' . $result['name'] . PHP_EOL;
// }

phpinfo();