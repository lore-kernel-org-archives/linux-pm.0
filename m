From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC 08/14] sched/tune: add detailed documentation
Date: Mon, 14 Sep 2015 13:00:51 -0700
Message-ID: <55F72773.9090001@linaro.org>
References: <1440010044-3402-9-git-send-email-patrick.bellasi@arm.com>
 <20150902064958.GA18664@google.com> <20150903091849.GB15649@e105326-lin>
 <55F0938A.9000607@linaro.org> <20150911110959.GA22876@e105326-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20150911110959.GA22876@e105326-lin>
Sender: linux-doc-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ricky Liang <jcliang@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Patrick,

On 09/11/2015 04:09 AM, Patrick Bellasi wrote:
>> It's also worth noting that mobile vendors typically add all sorts of
>> hacks on top of the existing cpufreq governors which further complicate
>> policy.
> 
> Could it be that many of the hacks introduced by vendors are just
> there to implement a kind of "scenario based" tuning of governors?
> I mean, depending on the specific use-case they try to refine the
> value of exposed tunables to improve either performance,
> responsiveness or power consumption?

>From what I've seen I think it's both scenario based tuning (add
functionality to detect and improve power/perf for say web browsing or
mp3 playback usecases specifically), as well as tailoring general case
behavior. Some of these are actually new features in the governor though
as opposed to just tweaks of existing tunables.

> If this is the case, it means that the currently available governors
> are missing an important bit of information: what are the best
> tunables values for a specific (set of) tasks?

Agreed, though I also think those tunable values might also change for a
given set of tasks in different circumstances.

> 
>> The current proposal:
>>
>> * sched-dvfs/schedtune: Event driven, CPU usage calculated using
>> exponential moving average. AFAICS tries to maintain some % of idle
>> headroom, but if that headroom doesn't exist at task_tick_fair(), goes
>> to max frequency. Schedtune provides a way to boost/inflate the demand
>> of individual tasks or overall system demand.
> 
> That's quite of a good description. One small correction is that, at
> least in the implementation presented by this RFC, SchedTune is not
> boosting individual tasks but just the CPU usage.
> The link with tasks is just that SchedTune knows how much to boost a
> CPU usage by keeping track of which tasks are runnable on that CPU.
> However, the utilization signal of each task is not actually modified
> from the scheduler standpoint.

Ah yes I see what you mean. I was thinking of the cgroup stuff but I see
that max per-task boost is tracked per-CPU and that CPU's aggregate
usage is boosted accordingly.

>> This looks a bit like ondemand to me but without the
>> sampling_down_factor functionality and using per-entity load tracking
>> instead of a simple window-based aggregate CPU usage.
> 
> I agree in principle.
> An important difference worth to notice is that we use an "event
> based" approach. This means that an enqueue/dequeue can trigger
> an immediate OPP change.
> If you consider that commonly ondemand uses a 20ms sample rate while
> an OPP switch never requires (quite likely) more than 1 or 2 ms, this
> means that sched-DVFS can be much more reactive on adapting to
> variable loads.

"Can be" are the important words to me there... it'd be nice to be able
to control that. Aggressive frequency changes may not be desirable for
power or performance, even if the transition can be quickly completed.
The configuration values of min_sample_time and above_hispeed_delay in
the interactive governor on some recent devices may give clues as to
whether latency is being intentionally increased on various platforms.

The latency/reactiveness of CPU frequency changes are also IMO a product
of two things - the CPUfreq/sched-dvfs policy, and the task load
tracking algorithm. I don't have enough experience with the mainline
task load tracking algorithm yet to know how it will compare with the
window-based aggregate CPU usage metric used by mainline cpufreq
governors. But I would imagine it will smooth out some of the aggressive
nature of sched-dvfs' event-driven approach. The hardcoded values in the
task load tracking algorithm seem concerning though from a tuning
standpoint.

>> The interactive functionality would require additional knobs. I
...
> However, regarding specifically the latency on OPP changes, there are
> a couple of extension we was thinking about:
> 1. link the SchedTune boost value with the % of idle headroom which
>    triggers an OPP increase
> 2. use the SchedTune boost value to defined the high frequency to jump
>    at when a CPU crosses the % of idle headroom

Hmmm... This may be useful (only testing/profiling would tell) though it
may be nice to be able to tune these values.

> These are tunables which allows to parameterize the way the PELT
> signal for CPU usage is interpreted by the sched-DVFS governor.
> 
> How such tunables should be exposed and tuned is to be discussed.
> Indeed, one of the main goals of the sched-DVFS and SchedTune
> specifically, is to simplify the tuning of a platform by exposing to
> userspace a reduced number of tunables, preferably just one.

This last point (the desire for a single tunable) is perhaps at the root
of my main concern. There are users/vendors for whom the current
tunables are insufficient, resulting in their hacking the governors to
add more tunables or features in the policy.

Consolidating CPU frequency and idle management in the scheduler will
clean things up and probably make things more effective, but I don't
think it will remove the need for a highly configurable policy.

I'm curious about the drive for one tunable. Is that something there's
specifically been a broad call for? Don't get me wrong, I'm all for
simplification and cleanup, if the flexibility and used features can be
retained.

>> A separate but related concern - in the (IMO likely, given the above)
>> case that folks want to tinker with that policy, it now means they're
>> hacking the scheduler as opposed to a self-contained frequency policy
>> plugin.
> 
> I do not agree on that point. SchedTune, as well as sched-DVFS, are
> framework quit well separated from the scheduler.
> They are "consumers" of signals usually used by the scheduler, but
> they are not directly affecting scheduler decisions (at least in the
> implementation proposed by this RFC).

Agreed it's not affecting scheduler decision making (not directly). It's
more just the mixing of the policy into the same code, as margin is
added in enqueue_task_fair()/task_tick_fair() etc. That one in
particular would probably be easy to solve. A more difficult one is if
someone wants to make adjustments to the load tracking algorithm because
it is driving CPU frequency.

> Side effects are possible, of course. For example the selection of an
...
> However, one of the main goals of this proposal is to respond to a
> couple of long lasting demands (e.g. [1,2]) for:
> 1. a better integration of CPUFreq with the scheduler, which has all
>    the required knowledge about workloads demands to target both
>    performances and energy efficiency
> 2. a simple approach to configure a system to care more about
>    performance or energy-efficiency
> 
> SchedTune addresses mainly the second point. Once SchedTune is
> integrated with EAS it will provide a support to decide, in an
> energy-efficient way, how much we want to reduce power or boost
> performances.

The provided links definitely establish the need for (1) but I am still
wondering about the motivation for (2), because I don't think it's going
to be possible to boil everything down to a single slider tunable
without losing flexibility/functionality.

cheers,
Steve

