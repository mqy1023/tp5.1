<?php
/**
 * Created by PhpStorm.
 * User: eric
 * Date: 2019/11/6
 * Time: 1:35 PM
 */

namespace app\admin\service;

use app\admin\model\AuthAdmin;
use app\admin\model\LoginLog;
use app\admin\model\AuthGroupAccess;

use app\admin\traits\Result;


class UserService
{
    use Result;


    /**
     * 验证登录
     * @param $data  待验证数据
     * @return array|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public static function login($data)
    {
        $validate = validate('AuthAdmin');
        if(config('captcha.is_open')){
            $validate->scene('captcha');
        }
        if (!$validate->check($data)) {
            return Result::error($validate->getError());
        }
        $list = AuthAdmin::where(['user' => $data['user']])->findOrEmpty();
        if (empty($list)) {
            return Result::error('账号不存在');
        }
        if ($list['status'] == 0) {
            $msg = Result::error('账号禁用');
        } else if (!password_verify($data['password'], $list['password'])) {
            $msg = Result::error('密码错误');
        } else {
            $group_id = model('AuthGroupAccess')->where('uid', '=', $list['uid'])->column('group_id');
            //获取用户组
            if(!$group_id && $list['uid'] != 1){
                $msg = Result::error('未设置用户组，请联系管理员');
            } else {
                self::autoSession($list['uid'], $group_id);
                $msg = Result::success('登录成功', url('/admin/index'));
            }
        }
        return $msg;
    }

    /**
     * 记录session
     * @param $uid int 用户id
     * @param $group_id array 用户组
     */
    private static function autoSession($uid, $group_id)
    {
        /* 更新登录信息 */
        $data = [
            'uid' => $uid,
            'login_count' => ['inc', 1],
            'last_login_ip' => request()->ip(),
            'last_login_time' => time(),
        ];
        //更新记录
        AuthAdmin::update($data);
        //获取用户信息
        $user = AuthAdmin::get($uid);
        /* 记录登录SESSION */
        $auth = [
            'uid' => $user['uid'],
            'user' => $user['user'],
            'name' => $user['name'],
            'head' => $user['head'],
            'group_id' => $group_id,
            'updatapassword' => $user['updatapassword'],
            'last_login_time' => $user['last_login_time'],
            'login_count' => $user['login_count'],
            'last_login_ip' => $user['last_login_ip'],
        ];
        //设置session
        session('user_auth', $auth);
        //设置session签名
        session('user_auth_sign', sign($auth));
        self::log($user);
    }

    /**
     * 记录登录日志
     * @param $data
     */
    private static function log($data)
    {
        //添加数据
        $LoginLog = new LoginLog;
        $LoginLog->save([
            'uid' => $data['uid'],
            'user' => $data['user'],
            'name' => $data['name'],
            'last_login_ip' => $data['last_login_ip'],
        ]);
    }
}