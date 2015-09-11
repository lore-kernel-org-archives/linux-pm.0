From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC 08/14] sched/tune: add detailed documentation
Date: Fri, 11 Sep 2015 12:09:59 +0100
Message-ID: <20150911110959.GA22876@e105326-lin>
References: <1440010044-3402-9-git-send-email-patrick.bellasi@arm.com>
 <20150902064958.GA18664@google.com>
 <20150903091849.GB15649@e105326-lin>
 <55F0938A.9000607@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <55F0938A.9000607@linaro.org>
Content-Disposition: inline
Sender: linux-doc-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Ricky Liang <jcliang@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 09, 2015 at 09:16:10PM +0100, Steve Muckle wrote:
> Hi Patrick,

Hi Steve,
 
> On 09/03/2015 02:18 AM, Patrick Bellasi wrote:
> > In my view, one of the main goals of sched-DVFS is actually that to be
> > a solid and generic replacement of different CPUFreq governors.
> > Being driven by the scheduler, sched-DVFS can exploit information on
> > CPU demand of active tasks in order to select the optimal Operating
> > Performance Point (OPP) using a "proactive" approach instead of the
> > "reactive" approach commonly used by existing governors.
> 
> I'd agree that with knowledge of CPU demand on a per-task basis, rather
> than the aggregate per-CPU demand that cpufreq governors use today, it
> is possible to proactively address changes in CPU demand which result
> from task migrations, task creation and exit, etc.
> 
> That said I believe setting the OPP based on a particular given
> historical profile of task load still relies on a heuristic algorithm of
> some sort where there is no single right answer. I am concerned about
> whether sched-dvfs and SchedTune, as currently proposed, will support
> enough of a range of possible heuristics/policies to effectively replace
> the existing cpufreq governors.
> 
> The two most popular governors for normal operation in the mobile world:
> 
> * ondemand: Samples periodically, CPU usage calculated as simple busy
> fraction of last X ms window of time. Goes straight to fmax when load
> exceeds up_threshold tunable %, otherwise scales frequency
> proportionally with load. Can stay at fmax longer if requested before
> re-evaluating by configuring the sampling_down_factor tunable.
> 
> * interactive: Samples periodically, CPU usage calculated as simple busy
> fraction of last Xms window of time. Goes to an intermediate tunable
> freq (hispeed_freq) when load exceeds a user definable threshold
> (go_hispeed_load). Otherwise strives to maintain the CPU usage set by
> the user in the "target_loads" array. Other knobs that affect behavior
> include min_sample_time (min time to spend at a freq before slowing
> down) and above_hispeed_delay (allows various delays to further raise
> speed above hispeed freq).
> 
> It's also worth noting that mobile vendors typically add all sorts of
> hacks on top of the existing cpufreq governors which further complicate
> policy.

Could it be that many of the hacks introduced by vendors are just
there to implement a kind of "scenario based" tuning of governors?
I mean, depending on the specific use-case they try to refine the
value of exposed tunables to improve either performance,
responsiveness or power consumption?

If this is the case, it means that the currently available governors
are missing an important bit of information: what are the best
tunables values for a specific (set of) tasks?

> The current proposal:
> 
> * sched-dvfs/schedtune: Event driven, CPU usage calculated using
> exponential moving average. AFAICS tries to maintain some % of idle
> headroom, but if that headroom doesn't exist at task_tick_fair(), goes
> to max frequency. Schedtune provides a way to boost/inflate the demand
> of individual tasks or overall system demand.

That's quite of a good description. One small correction is that, at
least in the implementation presented by this RFC, SchedTune is not
boosting individual tasks but just the CPU usage.
The link with tasks is just that SchedTune knows how much to boost a
CPU usage by keeping track of which tasks are runnable on that CPU.
However, the utilization signal of each task is not actually modified
from the scheduler standpoint.

> This looks a bit like ondemand to me but without the
> sampling_down_factor functionality and using per-entity load tracking
> instead of a simple window-based aggregate CPU usage.

I agree in principle.
An important difference worth to notice is that we use an "event
based" approach. This means that an enqueue/dequeue can trigger
an immediate OPP change.
If you consider that commonly ondemand uses a 20ms sample rate while
an OPP switch never requires (quite likely) more than 1 or 2 ms, this
means that sched-DVFS can be much more reactive on adapting to
variable loads.

> The interactive functionality would require additional knobs. I
> don't think schedtune will allow for tuning the latency of CPU
> frequency changes (min_sample_time, above_hispeed_delay, etc).

Well, there can be certainly some limitations in the current
implementation. Indeed, the goal of this RFC is to trigger the
discussion and verify if the overall idea make sense and how we
can improve it.

However, regarding specifically the latency on OPP changes, there are
a couple of extension we was thinking about:
1. link the SchedTune boost value with the % of idle headroom which
   triggers an OPP increase
2. use the SchedTune boost value to defined the high frequency to jump
   at when a CPU crosses the % of idle headroom

These are tunables which allows to parameterize the way the PELT
signal for CPU usage is interpreted by the sched-DVFS governor.

How such tunables should be exposed and tuned is to be discussed.
Indeed, one of the main goals of the sched-DVFS and SchedTune
specifically, is to simplify the tuning of a platform by exposing to
userspace a reduced number of tunables, preferably just one.
 
> A separate but related concern - in the (IMO likely, given the above)
> case that folks want to tinker with that policy, it now means they're
> hacking the scheduler as opposed to a self-contained frequency policy
> plugin.

I do not agree on that point. SchedTune, as well as sched-DVFS, are
framework quit well separated from the scheduler.
They are "consumers" of signals usually used by the scheduler, but
they are not directly affecting scheduler decisions (at least in the
implementation proposed by this RFC).

Side effects are possible, of course. For example the selection of an
OPP instead of another can affect the residency of a task on a CPU,
thus somehow biasing some scheduler decisions. However, I think that
this kind of side effects can be produced by current governors as
well.

Eventually, I agree with you if you mean that one can have the
impression of hacking the scheduler because the main compilation unit
of SchedTune is a file under kernel/sched. If this can be a problem,
for example from a maintenance perspective, perhaps we can find a
better location for that code.

> Another issue with policy (but not specific to this proposal) is that
> putting a bunch of it in the CPU frequency selection may derail the
> efforts of the EAS algorithm, which I'm still working on digesting.
> Perhaps a unified sched/cpufreq policy could go there.

We have an internal extension of SchedTune which is proposing an
integration with EAS. We have not included it on that RFC to keep
things simple by exposing at first instance only generic bits which
can extend sched-DVFS features.

However, one of the main goals of this proposal is to respond to a
couple of long lasting demands (e.g. [1,2]) for:
1. a better integration of CPUFreq with the scheduler, which has all
   the required knowledge about workloads demands to target both
   performances and energy efficiency
2. a simple approach to configure a system to care more about
   performance or energy-efficiency

SchedTune addresses mainly the second point. Once SchedTune is
integrated with EAS it will provide a support to decide, in an
energy-efficient way, how much we want to reduce power or boost
performances.

> thanks,
> Steve

Thanks for the interesting feedbacks, this is actually the kind of
discussion we would like to have around this initial proposal.

Cheers Patrick

[1] https://lkml.org/lkml/2012/5/18/91
[2] http://lwn.net/Articles/552889/

-- 
#include <best/regards.h>

Patrick Bellasi

