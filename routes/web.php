<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::group(['namespace' => 'Web'], function () {
    Route::get('/', ['uses' => 'HealthCheckController@welcome']);
});

Route::get('/healthcheck', function () {
    return 'ok';
});