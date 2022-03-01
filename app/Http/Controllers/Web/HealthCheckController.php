<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class HealthCheckController extends Controller
{
    /**
     * Welcome route checking database connection
     */
    public function welcome() {
        try {
            DB::connection()->getPDO();
            $data = [ 
                "database"  => DB::connection()->getDatabaseName(),
                "status"     => "success"
            ];
        } catch (\Exception $e) {
            $data = [ 
                "database"  => "None",
                "status"     => "error"
            ];
        }
        return view('welcome')->with($data);
    }
}
