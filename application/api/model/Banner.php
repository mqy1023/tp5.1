<?php

namespace app\api\model;

class Banner extends BaseModel
{
    public function items()
    {
        return $this->hasMany('BannerItem', 'banner_id', 'id');
    }
    //

    /**
     * @param $id int banner所在位置
     * @return Banner
     */
    public static function getBanners()
    {
        $banner = self::with(['items','items.img'])
            ->find();
        return $banner;
    }
}
