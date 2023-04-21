<?php

use App\Models\Historique;
use App\Models\Youtube;
use Illuminate\Support\Facades\Route;

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

Route::post('/riennn', function () {

    $post = new Youtube();

    $post->title = "Shakira";
    $post->content = "Waka waka ";
    $post->video = "Video5";
    $post->save();
    return $post;

});
