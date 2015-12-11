From: Luca Abeni <luca.abeni@unitn.it>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Fri, 11 Dec 2015 08:48:34 +0100
Message-ID: <566A7FD2.4050601@unitn.it>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <CAKfTPtCV4d=1nSDcU8J4x=MF7HmuyRxKr-4XiYAxPZYPKd1okA@mail.gmail.com>
 <56697DCB.5050800@unitn.it>
 <CAKfTPtC2bcdO=KKxsF71fF8tMtAxhR8OZQpqZ0m0ce-D=nnNfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34011 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbLKHsm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 02:48:42 -0500
Received: by mail-wm0-f42.google.com with SMTP id c17so1432134wmd.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2015 23:48:41 -0800 (PST)
In-Reply-To: <CAKfTPtC2bcdO=KKxsF71fF8tMtAxhR8OZQpqZ0m0ce-D=nnNfQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

Hi Vincent,

On 12/10/2015 05:11 PM, Vincent Guittot wrote:
[...]
>> If yes, I think your approach is safe (and easier to implement - modulo a
>> small
>> issue when a task terminates of switches to other scheduling policies; I
>> think
>> there already are some "XXX" comments in the current code). However, it
>> allows to
>> save less energy (or reclaim less CPU time). For example, if I create a
>> SCHED_DEADLINE
>> task with runtime 90ms and period 100ms it will not allow to scale the CPU
>> frequency
>> even if it never executes (because is always blocked).
>
> Yes, i agree. If the task behavior is not aligned with its deadline
> parameters, we will over provisioned CPU capacity to the deadline
> scheduler.
> This metric is not used to select the OPP but to provisioned some CPU
> capacity to the deadline scheduler and to inform the CFS scheduler of
> the remaining capacity.
Ah, sorry; I missed this point.


>>>> +       /* This is the "average utilization" for this runqueue */
>>>> +       s64 avg_bw;
>>>>    };
>>
>> Small nit: why "average" utilization? I think a better name would be
>> "runqueue utilization"
>> or "local utilization", or something similar... If I understand correctly
>> (sorry if I
>> missed something), this is not an average, but the sum of the utilisations
>> of the tasks
>> on this runqueue... No?
>
> I have used "average" because it doesn't reflect the active/actual
> utilization of the run-queue but the forecasted average bandwidth of
> the CPU that will be used by deadline task.
Well, this is just nitpicking, so feel free to ignore (I just mentioned
this point because I was initially confused by the "average" name). But I
think this is "maximum", or "worst-case", not "average", because (as far
as I can understand) this field indicates that SCHED_DEADLINE tasks will
not be able to consume more than this fraction of CPU (if they try to
consume more, the scheduler throttles them).

> I'm open to change the name if another one makes more sense
In real-time literature this is often called simply "utilization" (or "worst-case
utilization" by someone): when a task can have a variable execution time, its
utilization is defined as WCET (maximum execution time) / period.



				Luca
