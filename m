From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [PATCH v3 02/14] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Tue, 14 Aug 2018 16:55:09 +0530
Message-ID: <20180814112509.GB2661@codeaurora.org>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-3-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-3-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 06, 2018 at 05:39:34PM +0100, Patrick Bellasi wrote:
> Utilization clamping requires each CPU to know which clamp values are
> assigned to tasks that are currently RUNNABLE on that CPU.
> Multiple tasks can be assigned the same clamp value and tasks with
> different clamp values can be concurrently active on the same CPU.
> Thus, a proper data structure is required to support a fast and
> efficient aggregation of the clamp values required by the currently
> RUNNABLE tasks.
> 
> For this purpose we use a per-CPU array of reference counters,
> where each slot is used to account how many tasks require a certain
> clamp value are currently RUNNABLE on each CPU.
> Each clamp value corresponds to a "clamp index" which identifies the
> position within the array of reference couters.
> 
>                                  :
>        (user-space changes)      :      (kernel space / scheduler)
>                                  :
>              SLOW PATH           :             FAST PATH
>                                  :
>     task_struct::uclamp::value   :     sched/core::enqueue/dequeue
>                                  :         cpufreq_schedutil
>                                  :
>   +----------------+    +--------------------+     +-------------------+
>   |      TASK      |    |     CLAMP GROUP    |     |    CPU CLAMPS     |
>   +----------------+    +--------------------+     +-------------------+
>   |                |    |   clamp_{min,max}  |     |  clamp_{min,max}  |
>   | util_{min,max} |    |      se_count      |     |    tasks count    |
>   +----------------+    +--------------------+     +-------------------+
>                                  :
>            +------------------>  :  +------------------->
>     group_id = map(clamp_value)  :  ref_count(group_id)
>                                  :
>                                  :
> 
> Let's introduce the support to map tasks to "clamp groups".
> Specifically we introduce the required functions to translate a
> "clamp value" into a clamp's "group index" (group_id).
> 
> Only a limited number of (different) clamp values are supported since:
> 1. there are usually only few classes of workloads for which it makes
>    sense to boost/limit to different frequencies,
>    e.g. background vs foreground, interactive vs low-priority
> 2. it allows a simpler and more memory/time efficient tracking of
>    the per-CPU clamp values in the fast path.
> 
> The number of possible different clamp values is currently defined at
> compile time. Thus, setting a new clamp value for a task can result into
> a -ENOSPC error in case this will exceed the number of maximum different
> clamp values supported.
> 

I see that we drop reference on the previous clamp group when a task changes
its clamp limits. What about exiting tasks which claimed clamp groups? should
not we drop the reference?

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
