<?php

namespace app\api\model;

use think\Model;

class Address extends Model
{

    protected $hidden = [ 'user_id', 'create_time', 'update_time', 'delete_time'];
}
