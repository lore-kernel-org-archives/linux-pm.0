From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC 08/14] sched/tune: add detailed documentation
Date: Thu, 3 Sep 2015 10:18:49 +0100
Message-ID: <20150903091849.GB15649@e105326-lin>
References: <1440010044-3402-9-git-send-email-patrick.bellasi@arm.com>
 <20150902064958.GA18664@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:55139 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752813AbbICJSw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Sep 2015 05:18:52 -0400
In-Reply-To: <20150902064958.GA18664@google.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ricky Liang <jcliang@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Wed, Sep 02, 2015 at 07:49:58AM +0100, Ricky Liang wrote:
> Hi Patrick,

Hi Ricky,

> I wonder if this can replace the boost function in the interactive
> governor [0], which is widely used in both Android and ChromeOS
> kernels.

In my view, one of the main goals of sched-DVFS is actually that to be
a solid and generic replacement of different CPUFreq governors.
Being driven by the scheduler, sched-DVFS can exploit information on
CPU demand of active tasks in order to select the optimal Operating
Performance Point (OPP) using a "proactive" approach instead of the
"reactive" approach commonly used by existing governors.

In the current implementation proposed by this RFC, SchedTune is just
a simple mechanism on top of sched-DVFS to bias the selection of the
OPP.
In case a task is running for a limited amount of time at each of its
(sporadic) activation, it does not contribute a CPU load which selects
an higher OPP. Thus, the actual performance (i.e. time to completion)
of that task depends on which other tasks are co-scheduled with it.
If it has the chance to be scheduled on a loaded CPU it will run fast,
to the contrary it will be slower when scheduled alone on a CPU
running at the lowest OPP.

If this task is (for whatever reason) "important" and should always
complete an activation as soon as possible, the current situation is:
a) we use the "performance" governor when we know that the task could
   be active, thus running the whole system in "race-to-idle" mode
b) we use the "interactive" governor (if possible, since it is not not
   in mainline) and ensure that this task pokes the "boost" attribute
   when it is active

Notice that, for both these solutions:
1) unless we pin the task on a specific set of CPUs, we must enable
   this governor for all the frequency domains since we do not know on
   which CPU the scheduler will end up to run the task
2) the tuning for a single task is likely to affect the whole system
   once the task as been started all the tasks are going to be boosted
   even when this task is not runnable

SchedTune provides a "global tunable" which allows to get the same
results as a) and b) with the main advantage that only the specific
frequency domain where the task is RUNNING is boosted. Since we do not
need to pin the task to get this result this can simplify (eventually)
the modification required in user-space while still getting optimal
performances for the task without compromising overall system
consumption.

AFAIU, regarding specifically the boost modes supported by the
Interactive governor:

1) the "boost" tunable is substantially similar to setting to 100% the
   SchedTune boost value. Userspace is in charge to trigger the start
   and end of a boost period

2) the "boostpulse" tunable triggers a 100% boost.

   The main difference is that the Interactive governor resets the
   boost after a configurable time (usually 80ms) while in SchedTune
   the boost value is asserted until release by userspace.

   This has advantages and disadvantages. By using SchedTune the
   userspace has to release the boost explicitly. With the Interactive
   governor this is automatic but still the userspace has to defined a
   suitable timeout. However, this can be different for different
   tasks.

3) the "boost_input" tunable is just an hook exposed to kernel drivers
   which can generate input events expected to impact on user the
   experience.
   The actual implementation is just similar to the previous knob.

IMHO the "boostpulse/input_pulse" tunables are a simple solution to
the problem of running fast to get better UI interactive response.
Indeed, the driver/task which generates the input event is not
necessary the actual target of the load and/or user perceived
response.
Moreover, it boosts all the frequency domains independently from where
the actual UI related workload is running.

By exploiting scheduler information on the actual workload demand of
some tasks, we could aim at a more effective solution which boost just
the required CPUs and only when the task affecting the UI experience
is actually running. This is what the "per-task" SchedTune boosting is
trying to enable.

I'm wondering if you could provide some example to better describe
when the "boostpulse" tunables are used in ChromiumOS.
Maybe that by starting from the description of some use-case we could
better understand if the tunables provided by the Interactive governor
are really required of if we can figure out a possible better even if
different approach to be implemented in SchedTune.

> My understanding is that the boost in interactive governor is to
> simply raise the OPP on selected cores.

AFAIU the "boost" of the Interactive governor affects all the (online)
CPUs. Thus if you have a multi frequency domain system (e.g.
big.LITTLE), the Interactive governor switch to performance mode for
all the CPUs. This makes sense since that boosting is triggered by an
event but does not exploit any information on which tasks really need
boosting and where they are executed by the scheduler.

> The SchedTune boost works by adding a margin to the original load of
> a task which makes the kernel think that the task is more demanding
> than it actually is. My intuition was that they work differently and
> could cause different reaction in the kernel.

That's absolutely true, they works differently. However it is worth to
notice that the SchedTune boost value is "consumed" just by
sched-DVFS, when it has to select an OPP.
There are not other links with the scheduler and/or signals "consumed"
by the scheduler. Specifically, all the task/RQ specific signals used
by the scheduler are not affected by the SchedTune value.

This is what happens in the SchedTune version presented by this
RFC. Internally we are working on an extension which integrates the
Energy-Aware scheduler (EAS).
In that case you are right, the boost value could affect some decision
of the EAS scheduler. For example, boosted tasks could end up being
moved into a more capable CPU of a big.LITTLE system even if they are
not generating a big utilization.

> I feel that the per-task cgroup ScheTune boost should work as
> expected as it only boosts a set of tasks and make them appear
> relatively high demanding comparing to other tasks. But if the
> ScheTune boost is applied globally to boost all the tasks in the
> system, will it cause unnecessary task migrations as all the tasks
> appear to be high demanding to the kernel?

IMHO the best usage of SchedTune is via "per-task" boosting, where it
is more easy to control when the system must work at higher OPPs.
However, this will probably require more efforts in the user-space
middleware layers to feed the scheduler with sensible information
about tasks demands.

Meanwhile, the current solutions are based on system-wide tuning, and
that's why SchedTune has been proposed with a support for "global"
boosting.

When we are boosting globally the only information we are providing to
the kernel is that we are in a rush and everything is important. Thus
yes, small tasks could eventually end up being moved into a more
capable CPU.

However, how SchedTune is going to bias tasks allocation is part of our
internal developments targeting its integration with EAS.

> Specifically, my questions is: When the global SchedTune boost is
> enabled in a on-demand manner, is it possible that a light task gets
> migrated to the big core, and in turn kicks out a heavy task
> originally on that core?

In this RFC we presented just the initial idea of task boosting with a
solution which is generic enough to possibly replace some of the most
commonly used CPUFreq governors (e.g. Performance, Ondemand and
Interactive) while still being completely unrelated from the scheduler
decisions on tasks allocation.

We think that the approach of posting small and self-contained updates
can be more effective on creating consensus by working together on
designing and building a solution which fits many different needs.

> I'm wondering whether global SchedTune boost could result in a
> "priority inversion" causing the heavy task to run on the little
> core and the light task to run on the big core.

That's an interesting point we should keep into consideration for the
design of the complete solution.
I would prefer to post-pone this discussion on the list once we will
present the next extension of SchedTune which integrates into EAS.


> [0]: https://android.googlesource.com/kernel/common.git/+/android-3.18/drivers/cpufreq/cpufreq_interactive.c
> 
> Thanks,
> Ricky

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi

