<?php
#-------------------------------------------------------------------------------
# EE368 Digital Image Processing
# Android Tutorial #3: Server-Client Interaction Example for Image Processing
# Author: Derek Pang (dcypang@stanford.edu), David Chen (dmchen@stanford.edu)
#------------------------------------------------------------------------------

#function for streaming file to client
function streamFile($location, $filename, $mimeType='application/octet-stream')
{ if(!file_exists($location))
  { header ("HTTP/1.0 404 Not Found");
    return;
  }
  
  $size=filesize($location);
  $time=date('r',filemtime($location));
  #html response header
  header('Content-Description: File Transfer');	
  header("Content-Type: $mimeType"); 
  header('Cache-Control: public, must-revalidate, max-age=0');
  header('Pragma: no-cache');  
  header('Accept-Ranges: bytes');
  header('Content-Length:'.($size));
  header("Content-Disposition: inline; filename=$filename");
  header("Content-Transfer-Encoding: binary\n");
  header("Last-Modified: $time");
  header('Connection: close');      

  ob_clean();
  flush();
  readfile($location);	
}

#**********************************************************
# Research Script
#**********************************************************

#<1> Run Enrollment with matlab.
$command = "matlab -wait -nodesktop -nodisplay -r \"ResearchScript('DontCare','" . $_POST['ItemType'] . "',0," . $_POST['ItemId'] . "," . $_POST['ItemId'] . "," . $_POST['AnswerBaseImage'] . ");exit\"";
exec($command);
#echo $command;

#<2> set target path for storing photo uploads on the server.
$processed_photo_output_dir = "./DataBase/" . $_POST['ItemType']. '/' . $_POST['ItemId'] . "/AnswerForClient/";
$processed_photo_output_path = $processed_photo_output_dir . "pictureWithId.jpg";
$downloadFileName = basename( $processed_photo_output_path);

#<3> modify maximum allowable file size to 10MB and timeout to 300s.
ini_set('upload_max_filesize', '10M');
ini_set('post_max_size', '10M');
ini_set('max_input_time', 300);
ini_set('max_execution_time', 300);

streamFile($processed_photo_output_path, $downloadFileName,"application/octet-stream");

?>
