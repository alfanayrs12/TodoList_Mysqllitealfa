<?php 
$connection = new mysqli("localhost", "root", "", "latihan");
$title   = $_POST['title'];
$content = $_POST['content'];
$date    = date('y-m-d');

$result = mysqli_query($connection, "insert into note_app set title='$title', content='$content', date='$date'");

    if ($result) {
        echo json_encode([
            'message' => 'Data Berhasil Disimpan'
        ]);
        } else {
        echo json_encode([
            'message' => 'Data Gagal Disimpan'
        ]);
    }