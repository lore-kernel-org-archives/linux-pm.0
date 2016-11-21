From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 14:59:19 +0000
Message-ID: <20161121145919.GA3414@e105326-lin>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121121432.GK24383@e106622-lin>
 <20161121122622.GC3092@twins.programming.kicks-ass.net>
 <20161121135308.GN24383@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161121135308.GN24383@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On 21-Nov 13:53, Juri Lelli wrote:
> On 21/11/16 13:26, Peter Zijlstra wrote:
> > On Mon, Nov 21, 2016 at 12:14:32PM +0000, Juri Lelli wrote:
> > > On 21/11/16 11:19, Peter Zijlstra wrote:
> > 
> > > > So no tunables and rate limits here at all please.
> > > > 
> > > > During LPC we discussed the rampup and decay issues and decided that we
> > > > should very much first address them by playing with the PELT stuff.
> > > > Morton was going to play with capping the decay on the util signal. This
> > > > should greatly improve the ramp-up scenario and cure some other wobbles.
> > > > 
> > > > The decay can be set by changing the over-all pelt decay, if so desired.
> > > > 
> > > 
> > > Do you mean we might want to change the decay (make it different from
> > > ramp-up) once for all, or maybe we make it tunable so that we can
> > > address different power/perf requirements?
> > 
> > So the limited decay would be the dominant factor in ramp-up time,
> > leaving the regular PELT period the dominant factor for ramp-down.
> > 
> 
> Hmmm, AFAIU the limited decay will help not forgetting completely the
> contribution of tasks that sleep for a long time, but it won't modify
> the actual ramp-up of the signal. So, for new tasks we will need to play
> with a sensible initial value (trading off perf and power as usual).

A fundamental problem in IMO is that we are trying to use a "dynamic
metric" to act as a "predictor".

PELT is a "dynamic metric" since it continuously change while a task
is running. Thus it does not really provides an answer to the question
"how big this task is?" _while_ the task is running.
Such an information is available only when the task sleep.
Indeed, only when the task completes an activation and goes to sleep
PELT has reached a value which represents how much CPU bandwidth has
been required by that task.

For example, if we consider the simple yet interesting case of a
periodic task, PELT is a wobbling signal which reports a correct
measure of how much bandwidth is required only when a task completes
its RUNNABLE status.
To be more precise, the correct value is provided by the average PELT
and this also depends on the period of the task compared to the
PELT rate constant.
But still, to me a fundamental point is that the "raw PELT value" is
not really meaningful in _each and every single point in time_.


All that considered, we should be aware that to properly drive
schedutil and (in the future) the energy aware scheduler decisions we
perhaps need better instead a "predictor".
In the simple case of the periodic task, a good predictor should be
something which reports always the same answer _in each point in
time_.

For example, a task running 30 [ms] every 100 [ms] is a ~300 util_avg
task. With PELT, we get a signal which range between [120,550] with an
average of ~300 which is instead completely ignored. By capping the
decay we will get:

   decay_cap [ms]      range    average
                0      120:550     300
               64      140:560     310
               32      320:660     430

which means that still the raw PELT signal is wobbling and never
provides a consistent response to drive decisions.

Thus, a "predictor" should be something which sample information from
PELT to provide a more consistent view, a sort of of low-pass filter
on top of the "dynamic metric" which is PELT.

Should not such a "predictor" help on solving some of the issues
related to PELT slow ramp-up or fast ramp-down?

It should provides benefits, similar to that of the proposed knobs,
not only to schedutil but also to other clients of the PELT signal.

> > (Note that the decay limit would only be applied on the per-task signal,
> > not the accumulated signal.)
> 
> Right, and since schedutil consumes the latter, we could still suffer
> from too frequent frequency switch events I guess (this is where the
> down threshold thing came as a quick and dirty fix). Maybe we can think
> of some smoothing applied to the accumulated signal, or make it decay
> slower (don't really know what this means in practice, though :) ?
> 
> > It could be an option, for some, to build the kernel with a PELT window
> > of 16ms or so (half its current size), this of course means regenerating
> > all the constants etc.. And this very much is a compile time thing.
> > 
> 
> Right. I seem to remember that helped a bit for mobile type of
> workloads. But never did a thorough evaluation.
> 
> > We could fairly easy; if this is so desired; make the PELT window size a
> > CONFIG option (hidden by default).
> > 
> > But like everything; patches should come with numbers justifying them
> > etc..
> > 
> 
> Sure. :)
> 
> > > > Also, there was the idea of; once the above ideas have all been
> > > > explored; tying the freq ram rate to the power curve.
> > > > 
> > > 
> > > Yep. That's an interesting one to look at, but it might require some
> > > time.
> > 
> > Sure, just saying that we should resist knobs until all other avenues
> > have been explored. Never start with a knob.

-- 
#include <best/regards.h>

Patrick Bellasi
