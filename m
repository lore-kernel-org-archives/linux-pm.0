From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in scale_rt_capacity
Date: Thu, 10 Dec 2015 17:11:27 +0100
Message-ID: <CAKfTPtC2bcdO=KKxsF71fF8tMtAxhR8OZQpqZ0m0ce-D=nnNfQ@mail.gmail.com>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org> <CAKfTPtCV4d=1nSDcU8J4x=MF7HmuyRxKr-4XiYAxPZYPKd1okA@mail.gmail.com>
 <56697DCB.5050800@unitn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56697DCB.5050800@unitn.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Abeni <luca.abeni@unitn.it>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 10 December 2015 at 14:27, Luca Abeni <luca.abeni@unitn.it> wrote:
> Hi Vincent,
>
> first of all, thanks for adding me in the discussion.
>
> On 12/09/2015 09:50 AM, Vincent Guittot wrote:
>>
>> adding Lucas
>>
>> On 9 December 2015 at 07:19, Steve Muckle <steve.muckle@linaro.org> wrote:
>>>
>>> From: Vincent Guittot <vincent.guittot@linaro.org>
>>>
>>> Instead of monitoring the exec time of deadline tasks to evaluate the
>>> CPU capacity consumed by deadline scheduler class, we can directly
>>> calculate it thanks to the sum of utilization of deadline tasks on the
>>> CPU.  We can remove deadline tasks from rt_avg metric and directly use
>>> the average bandwidth of deadline scheduler in scale_rt_capacity.
>>>
>>> Based in part on a similar patch from Luca Abeni <luca.abeni@unitn.it>.
>
> Just to check if my understanding of your patch is correct: what you do is
> to track the total utilisation of the tasks that are assigned to a CPU/core,
> independently from their state (active or inactive). The difference with my
> patch is that I try to track the "active utilisation" (eliminating the
> utilisation
> of the tasks that are blocked).
>
> Is this understanding correct?

yes, i want to know the average utilization of the CPU/core by
deadline scheduler.

> If yes, I think your approach is safe (and easier to implement - modulo a
> small
> issue when a task terminates of switches to other scheduling policies; I
> think
> there already are some "XXX" comments in the current code). However, it
> allows to
> save less energy (or reclaim less CPU time). For example, if I create a
> SCHED_DEADLINE
> task with runtime 90ms and period 100ms it will not allow to scale the CPU
> frequency
> even if it never executes (because is always blocked).

Yes, i agree. If the task behavior is not aligned with its deadline
parameters, we will over provisioned CPU capacity to the deadline
scheduler.
This metric is not used to select the OPP but to provisioned some CPU
capacity to the deadline scheduler and to inform the CFS scheduler of
the remaining capacity.
So the main side effect of an always blocked deadline task will be to
decrease the rq->cpu_capacity that is then used by the CFS scheduler.

>
>
> [...]
>>>
>>> +       /* This is the "average utilization" for this runqueue */
>>> +       s64 avg_bw;
>>>   };
>
> Small nit: why "average" utilization? I think a better name would be
> "runqueue utilization"
> or "local utilization", or something similar... If I understand correctly
> (sorry if I
> missed something), this is not an average, but the sum of the utilisations
> of the tasks
> on this runqueue... No?

I have used "average" because it doesn't reflect the active/actual
utilization of the run-queue but the forecasted average bandwidth of
the CPU that will be used by deadline task. I'm open to change the
name if another one makes more sense

Regards,
Vincent

>
>
>
>                                 Luca
