<?php

namespace App\Http\Controllers;

use App\Exam;
use App\ExamSession;
use App\Question;
use App\ReportExam;
use App\Scores;
use Illuminate\Contracts\Session\Session;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;


class ExamController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application exam list.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function getExamList()
    {
        $exam = Exam::join('users', 'exam.id', '=', 'users.id')->select('exam_id', 'exam_name', 'exam_kind', 'exam_describe', 'exam.created_at', 'exam.id', 'name', 'running')->where('running', '=', 1)->get();
        return view('examList', ['exam' => $exam, 'i' => 1]);
    }

    public function getInfoExam($name)
    {
        $info = Exam::where('exam_id', '=', explode('&&', $name)[1])->first();
        $number_user = Scores::where('exam_id', '=', explode('&&', $name)[1])
            ->distinct()
            ->count('id');
        $min = Scores::where('exam_id', '=', explode('&&', $name)[1])
            ->min('scores');
        $max = Scores::where('exam_id', '=', explode('&&', $name)[1])
            ->max('scores');
        $avg = Scores::where('exam_id', '=', explode('&&', $name)[1])
            ->avg('scores');
        $list = Scores::join('users', 'scores.id', '=', 'users.id')->select('scores', 'exam_id', 'scores.created_at', 'name', 'users.id')->where('exam_id', '=', explode('&&', $name)[1])->where('users.id', '=', Auth::user()->id)->get();
        return view('infoExam', ['info' => $info, 'list' => $list, 'i' => 1, 'min' => $min, 'max' => $max, 'number_user' => $number_user, 'avg' => $avg]);
    }

    public function getReportExam($name)
    {
        $info = explode('&&', $name);
        return view('report', ['info' => $info, 'name' => $name]);
    }


    public function postReportExam($name, Request $request)
    {
        $info = explode('&&', $name);
        $arr = [
            'id' => Auth::user()->id,
            'created_at' => date("Y-m-d H:i:s"),
            'report' => $request->report,
            'exam_id' => $info[1],
        ];
        ReportExam::insert($arr);
        $messenger = 'Report successful';
        return redirect(route('messenger', $messenger));
    }
    public function getPasswordExam($name)
    {
        return view('passwordExam', ['name' => $name]);
    }

    public function postPasswordExam($name, Request $request)
    {
        $id = explode('&&', $name);
        $info = Exam::where('exam_id', '=', $id[1])->select('exam_password')->first();
        if ($info['exam_password'] == md5($request->exam_password)) {
            $exam_id = explode('&&', $name)[1];
            $session = ExamSession::where('id', '=', Auth::user()->id)->where('exam_id', '=', $exam_id)->get();

            if (session()->has(Auth::user()->id)) {
                if (session()->get(Auth::user()->id)['exam_id'] == $exam_id) {
                    $sess = session()->get(Auth::user()->id);
                    return view('continueExam', ['exam_name' => $sess['exam_name'], 'exam_id' => $sess['exam_id']]);
                } else {
                    ExamSession::insert(session()->get(Auth::user()->id));
                    session()->forget(Auth::user()->id);
                    if (count($session) != 0) {
                        $sess = ExamSession::where('id', '=', Auth::user()->id)->where('exam_id', '=', $exam_id)->first();
                        return view('continueExam', ['exam_name' => $sess['exam_name'], 'exam_id' => $sess['exam_id']]);
                    } else {
                        return redirect(route('test_exam', $name));
                    }
                }
            } else {
                if (count($session) != 0) {
                    $sess = ExamSession::where('id', '=', Auth::user()->id)->where('exam_id', '=', $exam_id)->first();
                    return view('continueExam', ['exam_name' => $sess['exam_name'], 'exam_id' => $sess['exam_id']]);
                } else {
                    return redirect(route('test_exam', $name));
                }
            }
        } else {
            $messenger = 'Exam password is unsuccessful';
            return redirect(route('messenger', $messenger));
        }
    }
    public function postCheckContinue($name, Request $request)
    {
        if ($request->check == 'yes') {
            return redirect(route('test_exam', $name));
        } else {
            $exam_id = explode('&&', $name)[1];
            session()->forget(Auth::user()->id);
            ExamSession::where('id', '=', Auth::user()->id)->where('exam_id', '=', $exam_id)->delete();
            return redirect(route('test_exam', $name));
        }
    }

    public function searchExam(Request $request)
    {
        $search = $request->search;
        $exam = Exam::join('users', 'exam.id', '=', 'users.id')->select('exam_id', 'exam_name', 'exam_kind', 'exam_describe', 'exam.created_at', 'exam.id', 'name', 'running')->where('running', '=', 1)->orWhere('name', 'like', '%' . $search . '%')->get();
        return view('searchExam', ['exam' => $exam, 'i' => 1]);
    }

    public function getExam($name)
    {
        $exam_id = explode('&&', $name)[1];
        $session = ExamSession::where('id', '=', Auth::user()->id)->where('exam_id', '=', $exam_id)->get();
        if (session()->has(Auth::user()->id)) {
            $sess = session()->get(Auth::user()->id);
            $id = $sess['exam_id'];
            $info = Exam::where('exam_id', '=', $id)->first();
            $quest = [];
            $exam = Question::where('exam_id', '=', $id)->get();
            foreach ($exam as $ex) {
                $arr = [
                    'question' => $ex['question'],
                    'answers' => explode('***', $ex['answer']),
                ];
                array_push($quest, $arr);
            }
            $time = $sess['time'];
            $data = explode(' ', $sess['data']);

            return view('exam', ['quest' => $quest, 'info' => $info, 'time' => $time, 'data' => $data]);
        } else if (count($session) != 0) {
            $sess = ExamSession::where('id', '=', Auth::user()->id)->where('exam_id', '=', $exam_id)->first();
            $id = $sess['exam_id'];
            $info = Exam::where('exam_id', '=', $id)->first();
            $quest = [];
            $exam = Question::where('exam_id', '=', $id)->get();
            foreach ($exam as $ex) {
                $arr = [
                    'question' => $ex['question'],
                    'answers' => explode('***', $ex['answer']),
                ];
                array_push($quest, $arr);
            }
            $time = $sess['time'];
            $data = explode(' ', $sess['data']);

            return view('exam', ['quest' => $quest, 'info' => $info, 'time' => $time, 'data' => $data]);
        } else {
            $id = explode('&&', $name);
            $info = Exam::where('exam_id', '=', $id[1])->first();
            $data = [];
            $quest = [];
            $exam = Question::where('exam_id', '=', $id[1])->get();
            foreach ($exam as $ex) {
                $arr = [
                    'question' => $ex['question'],
                    'answers' => explode('***', $ex['answer']),
                ];
                array_push($quest, $arr);
                array_push($data, 'null');
            }
            $time = $info['exam_time'] * 60;

            return view('exam', ['quest' => $quest, 'info' => $info, 'time' => $time, 'data' => $data]);
        }
    }
    public function postExam(Request $request, $name)
    {
        $answer = explode(',', $request->score);
        $exam = Question::where('exam_id', '=', $name)->select('rightAnswer')->get();
        $number = 0;
        $true = 0;
        foreach ($exam as $ex) {
            if ($ex['rightAnswer'] == $answer[$number]) {
                $true++;
            }
            $number++;
        }
        $scores =  round((($true * 10) / $number) * 100) / 100;
        $arr = [
            'scores' => $scores,
            'id' => Auth::user()->id,
            'created_at' => date("Y-m-d H:i:s"),
            'exam_id' => $name,

        ];
        ExamSession::where('id', '=', Auth::user()->id)->where('exam_id', '=', $name)->delete();
        session()->forget(Auth::user()->id);
        Scores::insert($arr);

        return view('showScore', ['scores' => $scores, 'true' => $true, 'number' => $number]);
    }
    public function postSaveResultExam(Request $request)
    {
        $arr = [
            'id' => Auth::user()->id,
            'exam_id' => $request->exam_id,
            'exam_name' => $request->exam_name,
            'time' => explode(' : ', $request->time)[0] * 60 + explode(' : ', $request->time)[1],
            'data' => implode(' ', $request->data),
        ];
        session()->put(Auth::user()->id, $arr);
    }
}
