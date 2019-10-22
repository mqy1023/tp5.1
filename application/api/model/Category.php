<?php

namespace app\api\model;

use think\facade\Cache;

class Category extends BaseModel
{

    protected $hidden = [ 'create_time', 'update_time', 'delete_time'];

    /**
     * 所有分类
     * @return mixed
     */
    public static function getALL()
    {
        $expire_in = config('setting.cache_expire_in');
        $model = new static;
//        if (!Cache::get('category')) {
            $data = $model->with(['img'])->order(['sort' => 'asc', 'create_time' => 'asc'])->select();
            $all = !empty($data) ? $data->toArray() : [];
            $tree = [];
            foreach ($all as $first) {
                if ($first['parent_id'] != 0) continue;
                $twoTree = [];
                foreach ($all as $two) {
                    if ($two['parent_id'] != $first['id']) continue;
                    $threeTree = [];
                    foreach ($all as $three)
                        $three['parent_id'] == $two['id']
                        && $threeTree[$three['id']] = $three;
                    !empty($threeTree) && $two['child'] = $threeTree;
                    $twoTree[$two['id']] = $two;
                }
                if (!empty($twoTree)) {
                    array_multisort(array_column($twoTree, 'sort'), SORT_ASC, $twoTree);
                    $first['child'] = $twoTree;
                }
                $tree[$first['id']] = $first;
            }
            Cache::set('category', compact('all', 'tree'), $expire_in);
//        }
        return Cache::get('category');
    }

}
