<?php
$baglanti = new mysqli('localhost', 'sametozyurekcom_admin', '_Sam@3825', 'sametozyurekcom_sruzy');
mysqli_set_charset($baglanti,"utf8");
$eposta = $_POST["eposta"];
$sifre = $_POST["sifre"];

$sorgu ="SELECT * FROM kullanici_bilgi WHERE e_posta='$eposta' and sifre='$sifre'";
$cikti=$baglanti->query($sorgu);
//print_r($sorgu);

if($cikti->num_rows>0){
    $oku = mysqli_fetch_assoc($cikti);
    echo $oku['id'];
}else{
    echo '0';
}
mysqli_close($baglanti);
?>