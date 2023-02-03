<?php
declare(strict_types=1);

$i = 1;

++$i;
$cfg['Servers'][$i]['auth_type'] = 'config';
$cfg['Servers'][$i]['user'] = 'wordpress';
$cfg['Servers'][$i]['password'] = 'wordpress';
$cfg['Servers'][$i]['only_db'] = 'wordpress';

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
