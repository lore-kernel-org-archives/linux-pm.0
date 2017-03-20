From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Mon, 20 Mar 2017 17:22:33 +0000
Message-ID: <20170320172233.GA28391@e110439-lin>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <20170320145131.GA3623@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755414AbdCTRbW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 13:31:22 -0400
Content-Disposition: inline
In-Reply-To: <20170320145131.GA3623@htj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On 20-Mar 10:51, Tejun Heo wrote:
> Hello, Patrick.

Hi Tejun,

> On Tue, Feb 28, 2017 at 02:38:37PM +0000, Patrick Bellasi wrote:
> >  a) Boosting of important tasks, by enforcing a minimum capacity in the
> >     CPUs where they are enqueued for execution.
> >  b) Capping of background tasks, by enforcing a maximum capacity.
> >  c) Containment of OPPs for RT tasks which cannot easily be switched to
> >     the usage of the DL class, but still don't need to run at the maximum
> >     frequency.
> 
> As this is something completely new, I think it'd be a great idea to
> give a couple concerete examples in the head message to help people
> understand what it's for.

Right, Rafael also asked for a similar better explanation, specifically:
 1. What problem exactly is at hand
 2. What alternative ways of addressing it have been considered
 3. Why the particular one proposed has been chosen over the other ones

I've addressed all these points in one of my previous response in this
thread, you can find here:
   https://lkml.org/lkml/2017/3/16/300

Hereafter are some other (hopefully useful) examples.


A) Boosting of important tasks
==============================

The Android GFX rendering pipeline is composed by a set of tasks which
are relatively small, let say they run for few [ms] every 16 [ms].
The overall generated utilization in the CPU where they are
running is usually below 40/50%.

These tasks are per-application, meaning that every application has
its own set of tasks which constitute the rendering pipeline.

In every moment, there is usually only one application which is the
main one impacting user experience: the one which is in front of his
screen.

Given such an example scenario, currently:

1) the CPUFreq governor selects the OPP based on the actual CPU demand
   of the workload. This is a policy which aims at reducing the power
   consumption while still meeting tasks requirements.
   In this scenario it would pick a mid-range frequency.

   However, for certain important tasks such as these part of the GFX
   pipeline of the current application, it can still be beneficial to
   complete them faster than what would normally happen.
   IOW: it is acceptable to trade-off energy consumption for a better
   reactivity of the system.

2) scheduler signals are used to drive some OPP selection, e.g. PELT
   for CFS tasks.

   However, these signals are usually subject to a dynamic which can
   be relatively slow to build up the required information to select
   the proper frequency.
   This can impact the performance of important tasks, at least
   during their initial activation.

The proposed patch allows to set a minimum capacity for a group of
tasks which has to be (possibly) granted by the system when these
tasks are RUNNABLE.

Ultimately, this allows "informed run-times" to inform the core kernel
components like the scheduler and CPUFreq about tasks requirements.
These information can be used to:

a) Bias OPP selection.
   Thus granting that certain critical tasks always run at least at a
   specified frequency.

b) Bias TASKS placement, which requires an additional extension not
   yet posted to keep things simple.
   This allows heterogeneous systems, where different CPUs have
   different capacities, to schedule important tasks in more capable
   CPUs.


Another interesting example of tasks which can benefits from this
boosting interface are GPU computation workloads. These workloads
usually happen to have a CPU side control thread, which in general
generates a quite small utilization. The small utilization is used to
select a lower frequency in the CPU side.

However, a reduced frequency on the CPU side on certain systems
affects also the performances of the GPU side computation.
In these cases it can be definitively beneficial to force run these
small tasks at an higher frequency to optimize the performance of
off-loaded computations. The proposed interface allows to bump the
frequencies only when these tasks are RUNNABLE without requiring to
set a minimum system-wide frequency constraint.



B) Capping of background tasks
==============================

In the same Android systems, when an application is not in foreground,
we can be interested in limiting the CPU resource it consumes.

The throttling mechanism provided by the CPU bandwidth controller is a
possible solution, which enforces bandwidth by throttling the tasks
within a configured period.
However, for certain use-cases it can be preferred to:
- never suspend tasks, but instead just keep running them at a lower frequency.
- keep running these tasks at higher frequencies when they appears to
  be co-scheduler with tasks without capacity limitations.

Throttling can be the non optimal solution also for workloads
which have very small periods (e.g. 16ms), in which case:

a) using longer cfs_period_us will produce long suspension of the
   tasks, which can thus experience non consistent behaviors.

b) using smaller cfs_period_us will increase the control overheads



C) Containment of OPPs for RT tasks
===================================

This point is conceptually similar to the previous one, but it
focuses mainly to RT tasks to improve how these tasks are currently
managed by the schedutil governor.

The current schedutil implementation enforce the selection of the
maximum OPP every thins a RT task is RUNNABLE. Such a policy can be
overkilling especially for some mobile/embedded use cases, as I better
describe in this other thread, where experimental results are also
reported:
   https://lkml.org/lkml/2017/3/17/214

The proposed solution is generic enough to naturally solve these kind
of corner cases as well thus improving the overall Linux kernel offer
in terms of "application specific" tunings which are possible when
"informed run-times" are available in user-space.


> Thanks.
> 
> -- 
> tejun

Hope this can help in casting some more light in the overall goal for
this proposal.


-- 
#include <best/regards.h>

Patrick Bellasi
