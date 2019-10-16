<?php

namespace app\common\exception;

/**
 * 404时抛出此异常
 */
class MissException extends BaseException
{
    public $code = 404;
    public $message = 'global:your required resource are not found';
    public $httpCode = 200;
}