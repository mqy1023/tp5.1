<?php

namespace app\api\controller\v1;

use app\common\exception\SuccessMessage;
use app\api\model\Category as CategoryModel;
use think\Controller;

class Category extends Controller
{
    /**
     * 获取Category树状列表
     * @url /category
     *
     * @return \think\Response
     */
    public function getCategoryTree()
    {
        $banner = CategoryModel::getALL()['tree'];

        return show('成功', 200, $banner);
    }

    /**
     * 获取Category所有列表
     * @url /category
     *
     * @return \think\Response
     */
    public function getCategoryAll()
    {
        $banner = CategoryModel::getALL()['all'];

        return show('成功', 200, $banner);
    }


    public function createOrUpdateCategory()
    {
        $arrays = input('post.');

//        $user_id = TokenService::getCurrentUid();
//        if (!$user_id) {
//            throw new ParameterException([ 'message' => '用户不存在' ]);
//        }
        $category = new CategoryModel;

        if (!empty($arrays['id'])) { // 更新
            $category->save($arrays, ['id' => $arrays['id']]);
        } else {
            $category->save($arrays);
        }

        return new SuccessMessage();
    }
}
