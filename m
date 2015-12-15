From: Luca Abeni <luca.abeni@unitn.it>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Tue, 15 Dec 2015 09:50:14 +0100
Message-ID: <566FD446.1080004@unitn.it>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214221231.39b5bc4e@luca-1225C>
 <CAKfTPtDT----aVGF-3T90PZQQvsOJay_Y-js19W+NNZpvk7J_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtDT----aVGF-3T90PZQQvsOJay_Y-js19W+NNZpvk7J_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 12/15/2015 05:59 AM, Vincent Guittot wrote:
[...]
>>>> So I don't think this is right. AFAICT this projects the WCET as the
>>>> amount of time actually used by DL. This will, under many
>>>> circumstances, vastly overestimate the amount of time actually
>>>> spend on it. Therefore unduly pessimisme the fair capacity of this
>>>> CPU.
>>>
>>> I agree that if the WCET is far from reality, we will underestimate
>>> available capacity for CFS. Have you got some use case in mind which
>>> overestimates the WCET ?
>>> If we can't rely on this parameters to evaluate the amount of capacity
>>> used by deadline scheduler on a core, this will imply that we can't
>>> also use it for requesting capacity to cpufreq and we should fallback
>>> on a monitoring mechanism which reacts to a change instead of
>>> anticipating it.
>> I think a more "theoretically sound" approach would be to track the
>> _active_ utilisation (informally speaking, the sum of the utilisations
>> of the tasks that are actually active on a core - the exact definition
>> of "active" is the trick here).
>
> The point is that we probably need 2 definitions of "active" tasks.
Ok; thanks for clarifying. I do not know much about the remaining capacity
used by CFS; however, from what you write I guess CFS really need an "average"
utilisation (while frequency scaling needs the active utilisation).
So, I suspect you really need to track 2 different things.
 From a quick look at the code that is currently in mainline, it seems to
me that it does a reasonable thing for tracking the remaining capacity
used by CFS...

> The 1st one would be used to scale the frequency. From a power saving
> point of view, it have to reflect the minimum frequency needed at the
> current time to handle all works without missing deadline.
Right. And it can be computed as shown in the GRUB-PA paper I mentioned
in a previous mail (that is, by tracking the active utilisation, as done
by my patches).

> This one
> should be updated quite often with the wake up and the sleep of tasks
> as well as the throttling.
Strictly speaking, the active utilisation must be updated when a task
wakes up and when a task sleeps/terminates (but when a task sleeps/terminates
you cannot decrease the active utilisation immediately: you have to wait
some time because the task might already have used part of its "future
utilisation").
The active utilisation must not be updated when a task is throttled: a
task is throttled when its current runtime is 0, so it already used all
of its utilisation for the current period (think about two tasks with
runtime=50ms and period 100ms: they consume 100% of the time on a CPU,
and when the first task consumed all of its runtime, you cannot decrease
the active utilisation).

> The 2nd definition is used to compute the remaining capacity for the
> CFS scheduler. This one doesn't need to be updated at each wake/sleep
> of a deadline task but should reflect the capacity used by deadline in
> a larger time scale. The latter will be used by the CFS scheduler  at
> the periodic load balance pace
Ok, so as I wrote above this really looks like an average utilisation.
My impression (but I do not know the CFS code too much) is that the mainline
kernel is currently doing the right thing to compute it, so maybe there is no
need to change the current code in this regard.
If the current code is not acceptable for some reason, an alternative would
be to measure the active utilisation for frequency scaling, and then apply a
low-pass filter to it for CFS.


				Luca

>
>> As done, for example, here:
>> https://github.com/lucabe72/linux-reclaiming/tree/track-utilisation-v2
>> (in particular, see
>> https://github.com/lucabe72/linux-reclaiming/commit/49fc786a1c453148625f064fa38ea538470df55b
>> )
>> I understand this approach might look too complex... But I think it is
>> much less pessimistic while still being "safe".
>> If there is something that I can do to make that code more acceptable,
>> let me know.
>>
>>
>>                          Luca
