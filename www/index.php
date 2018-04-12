<?php

$connect = mysqli_connect("mysql", "root", $_ENV["MYSQL_PASSWORD"]);

 if (mysqli_connect_errno()) {
    die(" 连接错误: (" . mysqli_connect_errno() . ") " . mysqli_connect_error());
}

echo "<h1> 成功连接 MySQL 服务器 </h1>" . PHP_EOL;
mysqli_close($connect);

phpinfo();
?>
