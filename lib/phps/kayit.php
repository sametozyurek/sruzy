<?php
$baglanti = new mysqli('localhost', 'sametozyurekcom_admin', '_Sam@3825', 'sametozyurekcom_sruzy');
mysqli_set_charset($baglanti,"utf8");
$adi = $_POST['ad'];
$soyadi = $_POST['soyad'];
$kadi = $_POST['kadi'];
$sifre = $_POST['sifre'];
$eposta = $_POST['eposta'];

$sorgu2 = "select kullanici_adi, e_posta from kullanici_bilgi where kullanici_adi='$kadi' or e_posta='$eposta'";
$sorgu = "insert into kullanici_bilgi(adi, soyadi, kullanici_adi, sifre, e_posta) values('$adi', '$soyadi', '$kadi', '$sifre', '$eposta')";

if($adi == "" || $soyadi == "" || $kadi == "" || $sifre == "" || $eposta == ""){
    echo '-1';
}else{
if($baglanti->query($sorgu2)){
    $sorgula_unique = mysqli_fetch_assoc($baglanti->query($sorgu2));
    if($sorgula_unique['kullanici_adi']==$kadi){
        echo '1';
    }
    elseif($sorgula_unique['e_posta']==$eposta){
        echo '0';
    }
    else{
        if($baglanti->query($sorgu)){
            echo "Kayıt Başarılı.";
        }
        else{
            echo "Kayıt Yapılamadı.";
            echo $kadi;
        }
    }
}
else{
    echo "Sorgu2 çalışmadı";
}
}

mysqli_close($baglanti);

?>