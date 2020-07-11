<?php
$baglanti = new mysqli('localhost', 'sametozyurekcom_admin', '_Sam@3825', 'sametozyurekcom_sruzy');
mysqli_set_charset($baglanti,"utf8");

$takipci = $_POST['user_id'];
$takip = $_POST['takip_id'];

$sorgu = "select user_id, takip_id from takip where user_id='$takipci' and takip_id='$takip'";

if($sorgula_unique = mysqli_fetch_assoc($baglanti->query($sorgu))){
    echo '0';
}
else{
    echo '1';
}

mysqli_close($baglanti);

?>