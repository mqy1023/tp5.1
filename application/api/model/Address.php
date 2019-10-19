<?php

namespace app\api\model;

class Address extends BaseModel
{

    protected $hidden = ['user_id', 'create_time', 'update_time', 'delete_time'];
}
