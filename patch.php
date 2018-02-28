<?php

$version = $argv[1];
//$version = '4.4.11';
list($major, $medium, $minor) = explode('.', $version);
echo $major;
$path = $argv[2];
// $json = $argv[2];
// $json = file_get_contents(' https://api.wordpress.org/coreversion-check/1.7/?version='.$version.'&locale=%22fr_FR%22');
// $obj = json_decode($json);
// // var_dump($obj);

// var_dump($version);
// var_dump($path);
function contains($needle, $haystack)
{
    return strpos($haystack, $needle) !== false;
}

$ch = curl_init();
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_URL, 'https://api.wordpress.org/core/version-check/1.7/?version='.$version.'&locale=%22fr_FR%22');
$result = curl_exec($ch);
curl_close($ch);
$obj = json_decode($result);
$nextv='';
foreach ($obj->offers as $key => $value) {
	$m = $major.'.'.$medium;
	if(contains($m,$value->version)){

		$nextv = $value->version;
		$url = $value->download;
		echo $url;
	}

}

