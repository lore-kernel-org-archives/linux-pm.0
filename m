From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 16:26:06 +0100
Message-ID: <20161121152606.GI3092@twins.programming.kicks-ass.net>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121121432.GK24383@e106622-lin>
 <20161121122622.GC3092@twins.programming.kicks-ass.net>
 <20161121135308.GN24383@e106622-lin>
 <20161121145919.GA3414@e105326-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161121145919.GA3414@e105326-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <Juri.Lelli@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2016 at 02:59:19PM +0000, Patrick Bellasi wrote:

> A fundamental problem in IMO is that we are trying to use a "dynamic
> metric" to act as a "predictor".
> 
> PELT is a "dynamic metric" since it continuously change while a task
> is running. Thus it does not really provides an answer to the question
> "how big this task is?" _while_ the task is running.
> Such an information is available only when the task sleep.
> Indeed, only when the task completes an activation and goes to sleep
> PELT has reached a value which represents how much CPU bandwidth has
> been required by that task.

I'm not sure I agree with that. We can only tell how big a task is
_while_ its running, esp. since its behaviour is not steady-state. Tasks
can change etc..

Also, as per the whole argument on why peak_util was bad, at the moment
a task goes to sleep, the PELT signal is actually an over-estimate,
since it hasn't yet had time to average out.

And a real predictor requires a crytal-ball instruction, but until such
time that hardware people bring us that goodness, we'll have to live
with predicting the near future based on the recent past.

> For example, if we consider the simple yet interesting case of a
> periodic task, PELT is a wobbling signal which reports a correct
> measure of how much bandwidth is required only when a task completes
> its RUNNABLE status.

Its actually an over-estimate at that point, since it just added a
sizable chunk to the signal (for having been runnable) that hasn't yet
had time to decay back to the actual value.

> To be more precise, the correct value is provided by the average PELT
> and this also depends on the period of the task compared to the
> PELT rate constant.
> But still, to me a fundamental point is that the "raw PELT value" is
> not really meaningful in _each and every single point in time_.

Agreed.

> All that considered, we should be aware that to properly drive
> schedutil and (in the future) the energy aware scheduler decisions we
> perhaps need better instead a "predictor".
> In the simple case of the periodic task, a good predictor should be
> something which reports always the same answer _in each point in
> time_.

So the problem with this is that not many tasks are that periodic, and
any filter you put on top will add, lets call it, momentum to the
signal. A reluctance to change. This might negatively affect
non-periodic tasks.

In any case, worth trying, see what happens.

> For example, a task running 30 [ms] every 100 [ms] is a ~300 util_avg
> task. With PELT, we get a signal which range between [120,550] with an
> average of ~300 which is instead completely ignored. By capping the
> decay we will get:
> 
>    decay_cap [ms]      range    average
>                 0      120:550     300
>                64      140:560     310
>                32      320:660     430
> 
> which means that still the raw PELT signal is wobbling and never
> provides a consistent response to drive decisions.
> 
> Thus, a "predictor" should be something which sample information from
> PELT to provide a more consistent view, a sort of of low-pass filter
> on top of the "dynamic metric" which is PELT.
> 
> Should not such a "predictor" help on solving some of the issues
> related to PELT slow ramp-up or fast ramp-down?

I think intel_pstate recently added a local PID filter, I asked at the
time if something like that should live in generic code, looks like
maybe it should.
