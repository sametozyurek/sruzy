<?php
$baglanti = new mysqli('localhost', 'sametozyurekcom_admin', '_Sam@3825', 'sametozyurekcom_sruzy');
mysqli_set_charset($baglanti,"utf8");

$arama = $_GET["adi"];

$kelimeler = explode(" ",$arama);
$ad = $kelimeler[0];
$soyad = $kelimeler[1];

$sorgu = "SELECT * FROM kullanici_bilgi WHERE adi LIKE '%$ad%' AND soyadi LIKE '%$soyad%'";

$sonuc = $baglanti->query($sorgu);

if($sonuc->num_rows>0){
    while($row = mysqli_fetch_assoc($sonuc)){
        $array[] = $row;
    }
}else{
    echo 'Veri bulunamadi.';
    print("$arama");
}

echo ($sonuc) ?
json_encode(array("code" => 1, "sonuc"=>$array)):
json_encode(array("code" => 0, "message"=>"bulunamadi"));

?>