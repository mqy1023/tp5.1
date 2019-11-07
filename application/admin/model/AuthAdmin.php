<?php

namespace app\admin\model;

use think\Model;

class AuthAdmin extends Model
{
    protected $autoWriteTimestamp = true;
    protected $pk = 'uid';
    protected $type = [
        'last_login_time' => 'timestamp',
    ];

    /**
     * 获取用户所属组
     * @param $value
     * @param $data
     * @return string
     */
    public function getGroupTitlesAttr($value, $data)
    {
        $titles = AuthGroupAccess::where('uid', '=', $data['uid'])
            ->alias('AuthGroupAccess')
            ->join('auth_group AuthGroup', 'AuthGroup.id = AuthGroupAccess.group_id')
            ->column('AuthGroup.title');
        return implode(',', $titles);
    }

    /**
     * 搜索器
     * @param $query
     * @param $value
     */
    public function searchNameAttr($query, $value)
    {
        if ($value) {
            $query->where('user|name', 'like', '%' . $value . '%');
        }
    }
}