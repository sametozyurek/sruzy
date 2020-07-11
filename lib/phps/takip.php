<?php
$baglanti = new mysqli('localhost', 'sametozyurekcom_admin', '_Sam@3825', 'sametozyurekcom_sruzy');
mysqli_set_charset($baglanti,"utf8");

$takipci = $_POST['user_id'];
$takip = $_POST['takip_id'];

$sorgu = "insert into takip(user_id, takip_id) values('$takipci', '$takip')";
$sorgu2 = "select user_id, takip_id from takip where user_id='$takipci' and takip_id='$takip'";

if($sorgula_unique = mysqli_fetch_assoc($baglanti->query($sorgu2))){
    echo '0';
}
else{
    $baglanti->query($sorgu);
}

mysqli_close($baglanti);

?>