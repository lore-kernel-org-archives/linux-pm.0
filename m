From: Luca Abeni <luca.abeni@unitn.it>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Tue, 15 Dec 2015 14:39:44 +0100
Message-ID: <56701820.8050807@unitn.it>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214221231.39b5bc4e@luca-1225C>
 <CAKfTPtDT----aVGF-3T90PZQQvsOJay_Y-js19W+NNZpvk7J_w@mail.gmail.com>
 <566FD446.1080004@unitn.it>
 <CAKfTPtA_wtKz26mgeneRn=kxNV45sdoz+Uu0ybsg3L6k=3mk8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35384 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbbLONjr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 08:39:47 -0500
Received: by mail-wm0-f54.google.com with SMTP id p66so91393463wmp.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 05:39:46 -0800 (PST)
In-Reply-To: <CAKfTPtA_wtKz26mgeneRn=kxNV45sdoz+Uu0ybsg3L6k=3mk8A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 12/15/2015 01:43 PM, Vincent Guittot wrote:
[...]
>>>>> I agree that if the WCET is far from reality, we will underestimate
>>>>> available capacity for CFS. Have you got some use case in mind which
>>>>> overestimates the WCET ?
>>>>> If we can't rely on this parameters to evaluate the amount of capacity
>>>>> used by deadline scheduler on a core, this will imply that we can't
>>>>> also use it for requesting capacity to cpufreq and we should fallback
>>>>> on a monitoring mechanism which reacts to a change instead of
>>>>> anticipating it.
>>>>
>>>> I think a more "theoretically sound" approach would be to track the
>>>> _active_ utilisation (informally speaking, the sum of the utilisations
>>>> of the tasks that are actually active on a core - the exact definition
>>>> of "active" is the trick here).
>>>
>>>
>>> The point is that we probably need 2 definitions of "active" tasks.
>>
>> Ok; thanks for clarifying. I do not know much about the remaining capacity
>> used by CFS; however, from what you write I guess CFS really need an
>> "average"
>> utilisation (while frequency scaling needs the active utilisation).
>
> yes. this patch is only about the "average" utilization
Ok; so, I think that the approach of this patch is too pessimistic (it uses
the "worst-case" utilisation as an estimation of the average one).

>>> This one
>>> should be updated quite often with the wake up and the sleep of tasks
>>> as well as the throttling.
>>
>> Strictly speaking, the active utilisation must be updated when a task
>> wakes up and when a task sleeps/terminates (but when a task
>> sleeps/terminates
>> you cannot decrease the active utilisation immediately: you have to wait
>> some time because the task might already have used part of its "future
>> utilisation").
>> The active utilisation must not be updated when a task is throttled: a
>> task is throttled when its current runtime is 0, so it already used all
>> of its utilisation for the current period (think about two tasks with
>> runtime=50ms and period 100ms: they consume 100% of the time on a CPU,
>> and when the first task consumed all of its runtime, you cannot decrease
>> the active utilisation).
>
>   I haven't read the paper you pointed in the previous email but it's
> on my todo list. Does the GRUB-PA take into account the frequency
> transition when selecting the best frequency ?
I do not know...
As far as I understand, the GRUB-PA approach is simple: if the active
utilisation of SCHED_DEADLINE tasks is Ua, then the CPU frequency can be
reduced to the maximum possible frequency multiplied by Ua (of course,
this must be adjusted a little bit, because the original GRUB-PA paper
only considered real-time/SCHED_DEADLINE tasks... To leave some CPU time
for other tasks, you have to increase Ua a little bit).

Some time ago one of the authors of the GRUB-PA paper told me that they
evaluated the performance of the algorithm by simulating the behaviour of
a real CPU, but I do not know the details, and I do not know if they took
the frequency transition into account.



				Luca
