From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in scale_rt_capacity
Date: Mon, 14 Dec 2015 15:02:32 +0100
Message-ID: <CAKfTPtBBaZ2Dv83Hp7Jfz==pymzaYSixEBi2VDbhZbmgZRYOLA@mail.gmail.com>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org> <CAKfTPtCV4d=1nSDcU8J4x=MF7HmuyRxKr-4XiYAxPZYPKd1okA@mail.gmail.com>
 <56697DCB.5050800@unitn.it> <CAKfTPtC2bcdO=KKxsF71fF8tMtAxhR8OZQpqZ0m0ce-D=nnNfQ@mail.gmail.com>
 <566A7FD2.4050601@unitn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <566A7FD2.4050601@unitn.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Abeni <luca.abeni@unitn.it>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 11 December 2015 at 08:48, Luca Abeni <luca.abeni@unitn.it> wrote:
> Hi Vincent,
>
> On 12/10/2015 05:11 PM, Vincent Guittot wrote:
> [...]
>>>
>>> If yes, I think your approach is safe (and easier to implement - modulo a
>>> small
>>> issue when a task terminates of switches to other scheduling policies; I
>>> think
>>> there already are some "XXX" comments in the current code). However, it
>>> allows to
>>> save less energy (or reclaim less CPU time). For example, if I create a
>>> SCHED_DEADLINE
>>> task with runtime 90ms and period 100ms it will not allow to scale the
>>> CPU
>>> frequency
>>> even if it never executes (because is always blocked).
>>
>>
>> Yes, i agree. If the task behavior is not aligned with its deadline
>> parameters, we will over provisioned CPU capacity to the deadline
>> scheduler.
>> This metric is not used to select the OPP but to provisioned some CPU
>> capacity to the deadline scheduler and to inform the CFS scheduler of
>> the remaining capacity.
>
> Ah, sorry; I missed this point.
>
>
>>>>> +       /* This is the "average utilization" for this runqueue */
>>>>> +       s64 avg_bw;
>>>>>    };
>>>
>>>
>>> Small nit: why "average" utilization? I think a better name would be
>>> "runqueue utilization"
>>> or "local utilization", or something similar... If I understand correctly
>>> (sorry if I
>>> missed something), this is not an average, but the sum of the
>>> utilisations
>>> of the tasks
>>> on this runqueue... No?
>>
>>
>> I have used "average" because it doesn't reflect the active/actual
>> utilization of the run-queue but the forecasted average bandwidth of
>> the CPU that will be used by deadline task.
>
> Well, this is just nitpicking, so feel free to ignore (I just mentioned
> this point because I was initially confused by the "average" name). But I
> think this is "maximum", or "worst-case", not "average", because (as far
> as I can understand) this field indicates that SCHED_DEADLINE tasks will
> not be able to consume more than this fraction of CPU (if they try to
> consume more, the scheduler throttles them).
>
>> I'm open to change the name if another one makes more sense
>
> In real-time literature this is often called simply "utilization" (or
> "worst-case
> utilization" by someone): when a task can have a variable execution time,
> its
> utilization is defined as WCET (maximum execution time) / period.

ok. Let follow real-time literature wording and remove "average" to
keep only utilization.
so the variable will be named:

s64 util_bw;

Thanks

>
>
>
>                                 Luca
