<?php

namespace app\api\model;

class Banner extends BaseModel
{
    protected $hidden = ['delete_time', 'id', 'img_id', 'update_time'];

    // 关联Image图片数据库
    public function img()
    {
        return $this->belongsTo('Image', 'img_id', 'id');
    }

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
