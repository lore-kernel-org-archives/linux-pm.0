From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC 08/14] sched/tune: add detailed documentation
Date: Tue, 15 Sep 2015 16:00:45 +0100
Message-ID: <20150915150044.GD3206@e105326-lin>
References: <1440010044-3402-9-git-send-email-patrick.bellasi@arm.com>
 <20150902064958.GA18664@google.com>
 <20150903091849.GB15649@e105326-lin>
 <55F0938A.9000607@linaro.org>
 <20150911110959.GA22876@e105326-lin>
 <55F72773.9090001@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:26026 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751656AbbIOPAt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Sep 2015 11:00:49 -0400
In-Reply-To: <55F72773.9090001@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Ricky Liang <jcliang@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On Mon, Sep 14, 2015 at 09:00:51PM +0100, Steve Muckle wrote:
> Hi Patrick,
> 
> On 09/11/2015 04:09 AM, Patrick Bellasi wrote:
> >> It's also worth noting that mobile vendors typically add all sorts of
> >> hacks on top of the existing cpufreq governors which further complicate
> >> policy.
> > 
> > Could it be that many of the hacks introduced by vendors are just
> > there to implement a kind of "scenario based" tuning of governors?
> > I mean, depending on the specific use-case they try to refine the
> > value of exposed tunables to improve either performance,
> > responsiveness or power consumption?
> 
> From what I've seen I think it's both scenario based tuning (add
> functionality to detect and improve power/perf for say web browsing or
> mp3 playback usecases specifically), as well as tailoring general case
> behavior. Some of these are actually new features in the governor though
> as opposed to just tweaks of existing tunables.
> 
> > If this is the case, it means that the currently available governors
> > are missing an important bit of information: what are the best
> > tunables values for a specific (set of) tasks?
> 
> Agreed, though I also think those tunable values might also change for a
> given set of tasks in different circumstances.

Could you provide an example?

In my view the per-task support should be exploited just for quite
specialized tasks, which are usually not subject to many different
phases during their execution.

For example, in a graphics rendering pipeline usually we have a host
"controller" task and a set set of "worker" tasks running on the
processing elements of the GPU.
Since the controller task is usually low intensity, it does not
generate on the CPU a load big enough to trigger the selection of an
higher OPP. The main issue in this case is that running this task on a
lower OPP could have sensible effects on latency affecting the
performance of the whole graphics pipeline.

For example, on Intel machines I was able to verify that running two
OpenCL workloads concurrently on the same GPU gives better FPS than
just running a single workload. And that it's mainly due to the
selection of an higher OPP on the CPU side when two instances are
running instead of just one.

In these scenarios, the boosting of the CPU OPP when a specific task
is runnable can help on getting better performance.

> >> The current proposal:
> >>
> >> * sched-dvfs/schedtune: Event driven, CPU usage calculated using
> >> exponential moving average. AFAICS tries to maintain some % of idle
> >> headroom, but if that headroom doesn't exist at task_tick_fair(), goes
> >> to max frequency. Schedtune provides a way to boost/inflate the demand
> >> of individual tasks or overall system demand.
> > 
> > That's quite of a good description. One small correction is that, at
> > least in the implementation presented by this RFC, SchedTune is not
> > boosting individual tasks but just the CPU usage.
> > The link with tasks is just that SchedTune knows how much to boost a
> > CPU usage by keeping track of which tasks are runnable on that CPU.
> > However, the utilization signal of each task is not actually modified
> > from the scheduler standpoint.
> 
> Ah yes I see what you mean. I was thinking of the cgroup stuff but I see
> that max per-task boost is tracked per-CPU and that CPU's aggregate
> usage is boosted accordingly.

Right, the idea is to have a sort of "boosting inheritance" mechanism.
While two tasks, with two different boosting values, are concurrently
runnable on a CPU, that CPU is boosted according to the max boost
value for these two tasks.

> >> This looks a bit like ondemand to me but without the
> >> sampling_down_factor functionality and using per-entity load tracking
> >> instead of a simple window-based aggregate CPU usage.
> > 
> > I agree in principle.
> > An important difference worth to notice is that we use an "event
> > based" approach. This means that an enqueue/dequeue can trigger
> > an immediate OPP change.
> > If you consider that commonly ondemand uses a 20ms sample rate while
> > an OPP switch never requires (quite likely) more than 1 or 2 ms, this
> > means that sched-DVFS can be much more reactive on adapting to
> > variable loads.
> 
> "Can be" are the important words to me there... it'd be nice to be able
> to control that. Aggressive frequency changes may not be desirable for
> power or performance, even if the transition can be quickly completed.
> The configuration values of min_sample_time and above_hispeed_delay in
> the interactive governor on some recent devices may give clues as to
> whether latency is being intentionally increased on various platforms.

IMO these knobs are more like fixes for a too "coarse grained" solution.
The main limitation of the current CPUFreq governors are:
1. use a single set of knobs to track many different tasks
2. use a system-wide view to control all tasks

The solution we get is working but, of course, it is an "average"
solution which satisfy on "average" the requirement of different
tasks.

With SchedTune we would like to get a similar result to the one you
describe using min_sample_time and above_hispeed_delay by linking
somehow the "interpretation" of the PELT signal with the boost value.

Right now we have in sched-DVFS an idle % headroom which is hardcoded
to be ~20% of the current OPP capacity. When we cross that boundary
that threshold with the CPU usage, we switch straight to the max OPP.
If we could figure out a proper mechanism to link the boost signal to
both the idle % headroom and the target OPP, I think we could achieve
quite similar results than what you can get with the knobs offered by
the interactive governor.
The more you boost a task the bigger is the idle % headroom and
the higher is the OPP you will jump.

> The latency/reactiveness of CPU frequency changes are also IMO a product
> of two things - the CPUfreq/sched-dvfs policy, and the task load
> tracking algorithm. I don't have enough experience with the mainline
> task load tracking algorithm yet to know how it will compare with the
> window-based aggregate CPU usage metric used by mainline cpufreq
> governors. But I would imagine it will smooth out some of the aggressive
> nature of sched-dvfs' event-driven approach.

That's right, somehow the PELT signal has a dynamic which is well
defined by the time constants it uses. Task enqueue/dequeue events
could happen with a higher frequency dynamic, however these are only
"check points" where the most updated value of a PELT signal could be
used to take a decision.

> The hardcoded values in the
> task load tracking algorithm seem concerning though from a tuning
> standpoint.

I agree, that's why we are thinking about the solution described
before. Exploit the boost value to replace the hardcoded thresholds
should allow to get more flexibility while being per-task defined.
Hopefully, tuning per task can be more easy and effective than
selection a single value fitting all needs.

> 
> >> The interactive functionality would require additional knobs. I
> ...
> > However, regarding specifically the latency on OPP changes, there are
> > a couple of extension we was thinking about:
> > 1. link the SchedTune boost value with the % of idle headroom which
> >    triggers an OPP increase
> > 2. use the SchedTune boost value to defined the high frequency to jump
> >    at when a CPU crosses the % of idle headroom
> 
> Hmmm... This may be useful (only testing/profiling would tell) though it
> may be nice to be able to tune these values.

Again, in my view the tuning should be per task with a single knob.
The value of the knob should than be properly mapped on other internal
values to obtain a well defined behavior driven by information shared
with the scheduler, i.e. a PELT signal.

> > These are tunables which allows to parameterize the way the PELT
> > signal for CPU usage is interpreted by the sched-DVFS governor.
> > 
> > How such tunables should be exposed and tuned is to be discussed.
> > Indeed, one of the main goals of the sched-DVFS and SchedTune
> > specifically, is to simplify the tuning of a platform by exposing to
> > userspace a reduced number of tunables, preferably just one.
> 
> This last point (the desire for a single tunable) is perhaps at the root
> of my main concern. There are users/vendors for whom the current
> tunables are insufficient, resulting in their hacking the governors to
> add more tunables or features in the policy.

We should also consider that we are proposing not only a single
tunable but also a completely different standpoint. Not more a "blind"
system-wide view on the average system behaviors, but instead a more
detailed view on tasks behaviors. A single tunable used to "tag" tasks
maybe it's not such a limited solution in this design.

> Consolidating CPU frequency and idle management in the scheduler will
> clean things up and probably make things more effective, but I don't
> think it will remove the need for a highly configurable policy.

This can be verified only by starting to use sched-DVFS + SchedTune on
real/synthetic setup to verify which features are eventually missing,
or specific use-cases not properly managed.
If we are able to setup these experiments perhaps we will be able to
identify a better design for a scheduler driver solution.

> I'm curious about the drive for one tunable. Is that something there's
> specifically been a broad call for? Don't get me wrong, I'm all for
> simplification and cleanup, if the flexibility and used features can be
> retained.

All this thread [1] was somehow calling out for a solution which goes
in the direction of a single tunable.

The main idea is to exploit the current effort around EAS.
While we are redesign some parts of the scheduler to be energy-ware it
is convenient also to include in that design a knob which allows to
configure how much we want to optimize for reduced power consumption
or increased performance.

> >> A separate but related concern - in the (IMO likely, given the above)
> >> case that folks want to tinker with that policy, it now means they're
> >> hacking the scheduler as opposed to a self-contained frequency policy
> >> plugin.
> > 
> > I do not agree on that point. SchedTune, as well as sched-DVFS, are
> > framework quit well separated from the scheduler.
> > They are "consumers" of signals usually used by the scheduler, but
> > they are not directly affecting scheduler decisions (at least in the
> > implementation proposed by this RFC).
> 
> Agreed it's not affecting scheduler decision making (not directly). It's
> more just the mixing of the policy into the same code, as margin is
> added in enqueue_task_fair()/task_tick_fair() etc. That one in
> particular would probably be easy to solve. A more difficult one is if
> someone wants to make adjustments to the load tracking algorithm because
> it is driving CPU frequency.

That's not so straightforward.

We have plenty of experience, collected on the past years, on CPUFreq
governors and customer specific mods.
Don't you think we can exploit that experience to reason around a
fresh new design that allows to satisfy all requirements while
providing possibly a simpler interface?

I agree with you that all the current scenarios must be supported by
the new proposal. We should probably start by listing them and come
out with a set of test cases that allow to verify where we are wrt
the state of the art.

Tools and benchmarks to verify the proposals and measure the
regress/progress should become more and more used.
This is an even more important requirement to setup a common
language and aims at objective evaluations.
Moreover, it has been already required by scheduler maintainers in the
past.

> > Side effects are possible, of course. For example the selection of an
> ...
> > However, one of the main goals of this proposal is to respond to a
> > couple of long lasting demands (e.g. [1,2]) for:
> > 1. a better integration of CPUFreq with the scheduler, which has all
> >    the required knowledge about workloads demands to target both
> >    performances and energy efficiency
> > 2. a simple approach to configure a system to care more about
> >    performance or energy-efficiency
> > 
> > SchedTune addresses mainly the second point. Once SchedTune is
> > integrated with EAS it will provide a support to decide, in an
> > energy-efficient way, how much we want to reduce power or boost
> > performances.
> 
> The provided links definitely establish the need for (1) but I am still
> wondering about the motivation for (2), because I don't think it's going
> to be possible to boil everything down to a single slider tunable
> without losing flexibility/functionality.

I see and understand your concerns, still I'm on the idea that we
should try to evaluate a different solution which possibly allows to
simplify the user-space interface as well as to reduce the tuning
effort.
All that without scarifying the (measurable) efficiency of the final
result.

> cheers,
> Steve
> 

Thanks for this interesting discussion.

Patrick

[1] http://thread.gmane.org/gmane.linux.kernel/1236846/focus=1237796

-- 
#include <best/regards.h>

Patrick Bellasi

