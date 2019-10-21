<?php
/**
 * Created by PhpStorm.
 * User: eric
 * Date: 2019/10/17
 * Time: 6:00 PM
 */

namespace app\api\controller\v1;

use app\common\exception\ParameterException;
use app\common\exception\SuccessMessage;
use think\Controller;
use app\api\validate\AddressNew;
use app\api\model\Address as AddressModel;
use \app\api\service\Token as TokenService;

class Address extends Controller
{
    /**
     * 更新或者创建用户收获地址
     */
    public function createOrUpdateAddress()
    {
        $arrays = input('post.');
        // user_id 不能从前端传入，而是解析token出来的
        if (array_key_exists('user_id', $arrays) | array_key_exists('uid', $arrays)) {
            // 不允许包含user_id或者uid，防止恶意覆盖user_id外键
            throw new ParameterException('参数中包含有非法的参数名user_id或者uid');
        }

        $validate = new AddressNew();
        $validate->goCheck();

        $user_id = TokenService::getCurrentUid();
        if (!$user_id) {
            throw new ParameterException('用户不存在', 500);
        }
        $address = new AddressModel;
        $arrays['user_id'] = $user_id; // 通过token查询缓存得到user_id
        if (!empty($arrays['id'])) { // 更新
            $address->save($arrays, ['id' => $arrays['id']]);
        } else {
            $address->save($arrays);
        }

        return new SuccessMessage();
    }

    public function getUserAllAddress()
    {
//        $user_id = TokenService::getCurrentUid();
//        if (!isset($user_id)) {
//            throw new ParameterException('用户不存在', 500);
//        }
        $user_id = 10002;
        $addressModel = new AddressModel();
        $allAddress = $addressModel->where('user_id', $user_id)->order('update_time desc')->all()->toArray();
        $data = [];
        foreach ($allAddress as $key => $oneAddress) {
            if ($oneAddress['is_default']) { // is_default为1，默认的地址显示在第一位
                array_unshift($data, $oneAddress); // 往头部添加默认的原生
            } else {
                $data[] = $oneAddress;
            }
        }
        return show('获取成功', 200, $data);
    }

    public function getUserDefaultAddress()
    {
        $user_id = TokenService::getCurrentUid();
        if (!isset($user_id)) {
            throw new ParameterException('用户不存在', 500);
        }
        $addressModel = new AddressModel();
        $defaultAddress = $addressModel::where('user_id', $user_id)->where('is_default', 1)->find();
//        print_r($defaultAddress);die;
        if (empty($defaultAddress)) {
            return show('没有默认地址', 500);
        }
        return show('获取成功', 200, $defaultAddress);
    }

    public function deleteAddress($id)
    {
        $user_id = TokenService::getCurrentUid();
        if (empty($user_id)) {
            throw new ParameterException('用户不存在', 500);
        }
//        $user_id = 10002;
        $addressModel = new AddressModel();
        $addressData = $addressModel::where('user_id', $user_id)->where('id', $id)->findOrEmpty()->toArray();
        if (empty($addressData)) {
            throw new ParameterException('用户和地址对不上', 500);
        } else {
            AddressModel::destroy($id);
        }
        return show('删除成功', 200, $id);
    }
}