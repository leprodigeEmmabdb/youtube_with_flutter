<?php

use App\Models\Youtube;
use App\Models\Historique;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Resources\YoutubeResource;
use App\Http\Resources\HistoriqueResource;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/create', function(Request $request) {
    $historique = Historique::create([
        'action'=>$request->action,
    ]);

    $date = $historique->created_at;


    $historique = new HistoriqueResource($historique);
    return response()->json($historique);
});


Route::get('/historiques', function(Request $request) {
    $historique = HistoriqueResource::collection(Historique::all());
    return response()->json($historique);
});



Route::get('/youtubes', function(Request $request) {
    $youtube = YoutubeResource::collection(Youtube::all());
    return response()->json($youtube);


});
Route::get('/youtubes/{id}', function($id) {
    $youtube = new YoutubeResource(Youtube::findOrFail($id));
    return response()->json($youtube);


});

Route::delete('/historiques/{id}', function($id) {
    $historique = Historique::find($id);
    if($historique->delete()) {
        return response()->json(['message'=>'Suppression réussie!']);
    }
    else {
        return response()->json(['message'=>'Echec de suppression!']);
    }
});





/*

/ApiYoutubeNew/resources/img/issue.jpg



*/
