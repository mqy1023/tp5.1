<?php

namespace app\api\model;

class Banner extends BaseModel
{
    protected $hidden = ['delete_time', 'id', 'img_id', 'update_time'];

    /**
     * @param $id int banner所在位置
     * @return Banner
     */
    public static function getBanners()
    {
        $banner = self::all([], 'img');
        return $banner;
    }
}
