From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 16:24:24 +0000
Message-ID: <20161121162424.GA10744@e105326-lin>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121121432.GK24383@e106622-lin>
 <20161121122622.GC3092@twins.programming.kicks-ass.net>
 <20161121135308.GN24383@e106622-lin>
 <20161121145919.GA3414@e105326-lin>
 <20161121152606.GI3092@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753005AbcKUQYc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Nov 2016 11:24:32 -0500
Content-Disposition: inline
In-Reply-To: <20161121152606.GI3092@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <Juri.Lelli@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>

On 21-Nov 16:26, Peter Zijlstra wrote:
> On Mon, Nov 21, 2016 at 02:59:19PM +0000, Patrick Bellasi wrote:
> 
> > A fundamental problem in IMO is that we are trying to use a "dynamic
> > metric" to act as a "predictor".
> > 
> > PELT is a "dynamic metric" since it continuously change while a task
> > is running. Thus it does not really provides an answer to the question
> > "how big this task is?" _while_ the task is running.
> > Such an information is available only when the task sleep.
> > Indeed, only when the task completes an activation and goes to sleep
> > PELT has reached a value which represents how much CPU bandwidth has
> > been required by that task.
> 
> I'm not sure I agree with that. We can only tell how big a task is
> _while_ its running, esp. since its behaviour is not steady-state. Tasks
> can change etc..

Sure, what I was saying is that while a task is running we can only
know that it still needs more CPU bandwidth but not how much it will
consume at the end. PELT rumping up measure how much bandwidth a task
consumed so far and only at the end it allows to know how much we
need, usually defined by the average between the initial decayed value
and the final ramp-up value.

> Also, as per the whole argument on why peak_util was bad, at the moment
> a task goes to sleep, the PELT signal is actually an over-estimate,
> since it hasn't yet had time to average out.

Right, but there are two main observations on that point:
1) how much we over-esitmate depends on the task periodicity compared
   to the PELT rate
2) the peak_util was just an initial bit (quite oversimplified) of
   a more complete solution which can allow to track a better metric,
   like for example the average, and transparently expose it in place
   of the raw PELT signal whenever it make sense

> And a real predictor requires a crytal-ball instruction, but until such
> time that hardware people bring us that goodness, we'll have to live
> with predicting the near future based on the recent past.

That will definitively be a bright future :)

However, I agree that the only sensible and possible thing is to
estimate based on recent past. The point is to decide which "past"
provides the most useful information.

PELT past is measured in terms on 1ms, every few [ms] the task size
PELT reports is different while the task is running.

Perhaps a better approach could be to consolidate the PELT information
each time a task completes an activation. In this case the past will
be measued in terms of "the last time this task executed".
 
> > For example, if we consider the simple yet interesting case of a
> > periodic task, PELT is a wobbling signal which reports a correct
> > measure of how much bandwidth is required only when a task completes
> > its RUNNABLE status.
> 
> Its actually an over-estimate at that point, since it just added a
> sizable chunk to the signal (for having been runnable) that hasn't yet
> had time to decay back to the actual value.

Kind of disagree on "actual value", when the value is decayed what we
get is a lower estimation of the actual required bandwidth. Compared
to the PELT averate: the peak value over-estimate almost as much as the
decayed value lower-estimate, isn't it?

> > To be more precise, the correct value is provided by the average PELT
> > and this also depends on the period of the task compared to the
> > PELT rate constant.
> > But still, to me a fundamental point is that the "raw PELT value" is
> > not really meaningful in _each and every single point in time_.
> 
> Agreed.
> 
> > All that considered, we should be aware that to properly drive
> > schedutil and (in the future) the energy aware scheduler decisions we
> > perhaps need better instead a "predictor".
> > In the simple case of the periodic task, a good predictor should be
> > something which reports always the same answer _in each point in
> > time_.
> 
> So the problem with this is that not many tasks are that periodic, and
> any filter you put on top will add, lets call it, momentum to the
> signal. A reluctance to change. This might negatively affect
> non-periodic tasks.

In mobile environment many "main" tasks are generally quite periodic
with a limited variability every other activation. We could argue that
those tasks should be scheduled using a different classes, however we
should also consider that sometimes this is not possible.

However, I agree that a generic solution should fit variable tasks as well.
That's why the more complete and generic solution, wrt the peak_util
posted by Morten, was something which allows to transparently switch
from the estimated value to the PELT one. for example when the PELT
value ramps up above the estimated one.

> In any case, worth trying, see what happens.

Are you saying that you would like to see the code which implements a
more generic version of the peak_util "filter" on top of PELT?

IMO it could be a good exercise now that we agree we want to improve
PELT without replacing it.

> > For example, a task running 30 [ms] every 100 [ms] is a ~300 util_avg
> > task. With PELT, we get a signal which range between [120,550] with an
> > average of ~300 which is instead completely ignored. By capping the
> > decay we will get:
> > 
> >    decay_cap [ms]      range    average
> >                 0      120:550     300
> >                64      140:560     310
> >                32      320:660     430
> > 
> > which means that still the raw PELT signal is wobbling and never
> > provides a consistent response to drive decisions.
> > 
> > Thus, a "predictor" should be something which sample information from
> > PELT to provide a more consistent view, a sort of of low-pass filter
> > on top of the "dynamic metric" which is PELT.
> > 
> > Should not such a "predictor" help on solving some of the issues
> > related to PELT slow ramp-up or fast ramp-down?
> 
> I think intel_pstate recently added a local PID filter, I asked at the
> time if something like that should live in generic code, looks like
> maybe it should.

That PID filter is not "just" a software implementation of the ACPI's
Collaborative Processor Performance Control (CPPC) when HWP hardware
is not provided by a certain processor?

-- 
#include <best/regards.h>

Patrick Bellasi
