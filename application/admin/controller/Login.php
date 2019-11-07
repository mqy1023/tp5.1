<?php

namespace app\admin\controller;

use think\Controller;
use app\admin\service\AuthAdminService;
use app\admin\model\AuthAdmin as AuthAdminModel;
use think\captcha\Captcha;

class Login extends Controller
{
    /**
     * 用户登录
     * @return array|mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function login()
    {
        if (get_user_id()) {
            $this->redirect(url('/admin/index'));
        } else {
            if (!request()->isPost()) {
                $is_open_captcha = config('captcha.is_open');
                $this->assign('is_open_captcha', $is_open_captcha);
                return $this->fetch();
            } else {
                $data = input();
                $result = AuthAdminService::login($data);
                return $result;
            }
        }

    }

    /**
     * 用户退出
     * @return array
     */
    public function logout()
    {
        session('user_auth', null);
        session('user_auth_sign', null);
        return ['msg' => '退出成功', 'url' => url('/admin/login')];
    }

    /**
     * 解锁
     */
    public function unlock()
    {
        if (!$this->request->isPost()) {
            $this->error('非法请求');
        }
        $uid = get_user_id();
        if (!$uid) {
            $this->error('登录信息过期', url('/admin/login'));
        }
        $password = input('password', '', 'trim');

        $psd = AuthAdminModel::where('uid', '=', get_user_id())->value('password');
        if (password_verify($password, $psd)) {
            $this->success('解锁成功');
        } else {
            $this->error('密码错误');
        }
    }

    /**
     * 获取验证码
     * @return mixed
     */
    public function verify()
    {
        $config = config('captcha.');
        $captcha = new Captcha($config);
        return $captcha->entry();
    }
}