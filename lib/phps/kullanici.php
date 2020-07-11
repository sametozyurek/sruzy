<?php
$baglanti = new mysqli('localhost', 'sametozyurekcom_admin', '_Sam@3825', 'sametozyurekcom_sruzy');
mysqli_set_charset($baglanti,"utf8");

$id = $_GET["id"];

$sorgu = "SELECT * from kullanici_bilgi where id='$id'";

$sonuc = $baglanti->query($sorgu);

if($sonuc->num_rows>0){
    while($row = mysqli_fetch_assoc($sonuc)){
        $array[] = $row;
    }
}else{
    echo 'Veri bulunamadi.';
}

echo ($sonuc) ?
json_encode(array("code" => 1, "sonuc"=>$array)):
json_encode(array("code" => 0, "message"=>"bulunamadi"));

?>