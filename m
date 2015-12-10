From: Luca Abeni <luca.abeni@unitn.it>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Thu, 10 Dec 2015 14:27:39 +0100
Message-ID: <56697DCB.5050800@unitn.it>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <CAKfTPtCV4d=1nSDcU8J4x=MF7HmuyRxKr-4XiYAxPZYPKd1okA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33563 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbbLJN1m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 08:27:42 -0500
Received: by mail-wm0-f51.google.com with SMTP id c201so33017708wme.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2015 05:27:42 -0800 (PST)
In-Reply-To: <CAKfTPtCV4d=1nSDcU8J4x=MF7HmuyRxKr-4XiYAxPZYPKd1okA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

Hi Vincent,

first of all, thanks for adding me in the discussion.

On 12/09/2015 09:50 AM, Vincent Guittot wrote:
> adding Lucas
>
> On 9 December 2015 at 07:19, Steve Muckle <steve.muckle@linaro.org> wrote:
>> From: Vincent Guittot <vincent.guittot@linaro.org>
>>
>> Instead of monitoring the exec time of deadline tasks to evaluate the
>> CPU capacity consumed by deadline scheduler class, we can directly
>> calculate it thanks to the sum of utilization of deadline tasks on the
>> CPU.  We can remove deadline tasks from rt_avg metric and directly use
>> the average bandwidth of deadline scheduler in scale_rt_capacity.
>>
>> Based in part on a similar patch from Luca Abeni <luca.abeni@unitn.it>.
Just to check if my understanding of your patch is correct: what you do is
to track the total utilisation of the tasks that are assigned to a CPU/core,
independently from their state (active or inactive). The difference with my
patch is that I try to track the "active utilisation" (eliminating the utilisation
of the tasks that are blocked).

Is this understanding correct?
If yes, I think your approach is safe (and easier to implement - modulo a small
issue when a task terminates of switches to other scheduling policies; I think
there already are some "XXX" comments in the current code). However, it allows to
save less energy (or reclaim less CPU time). For example, if I create a SCHED_DEADLINE
task with runtime 90ms and period 100ms it will not allow to scale the CPU frequency
even if it never executes (because is always blocked).


[...]
>> +       /* This is the "average utilization" for this runqueue */
>> +       s64 avg_bw;
>>   };
Small nit: why "average" utilization? I think a better name would be "runqueue utilization"
or "local utilization", or something similar... If I understand correctly (sorry if I
missed something), this is not an average, but the sum of the utilisations of the tasks
on this runqueue... No?



				Luca
