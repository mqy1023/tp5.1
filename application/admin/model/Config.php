<?php

namespace app\admin\model;

use think\Model;

class Config extends Model
{
    protected $autoWriteTimestamp = true;
    protected $json = ['value'];
    protected $jsonAssoc = true;
}