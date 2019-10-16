<?php

namespace app\api\controller\v1;

use app\api\validate\IDMustBePositiveInt;
use app\api\model\Banner as BannerModel;
use think\Controller;
use think\Request;

class Banner extends Controller
{
    /**
     * 获取banner列表
     * @url /banner
     *
     * @return \think\Response
     */
    public function getBanner()
    {
        //
//        echo $id;
//        throw new BaseException("333", 100);
//        $validate = new IDMustBePositiveInt();
//        $validate->goCheck();

        $banner = BannerModel::getBanners();

//        var_dump($banner);

//        if (!$banner ) {
//            throw new MissException([
//                'msg' => '请求banner不存在',
//                'errorCode' => 40000
//            ]);
//        }
        return show('成功', 200, $banner);
    }

    /**
     * 显示创建资源表单页.
     *
     * @return \think\Response
     */
    public function create()
    {
        //
    }

    /**
     * 保存新建的资源
     *
     * @param  \think\Request  $request
     * @return \think\Response
     */
    public function save(Request $request)
    {
        //
    }

    /**
     * 显示指定的资源
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function read($id)
    {
        //
    }

    /**
     * 显示编辑资源表单页.
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * 保存更新的资源
     *
     * @param  \think\Request  $request
     * @param  int  $id
     * @return \think\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * 删除指定资源
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function delete($id)
    {
        //
    }
}
