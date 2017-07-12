From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/4] sched: cpufreq: Allow remote callbacks
Date: Thu, 13 Jul 2017 01:22:09 +0200
Message-ID: <2305602.EUg3iPzbWS@aspire.rjw.lan>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62470 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750808AbdGLX3x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 19:29:53 -0400
In-Reply-To: <cover.1498712046.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

On Thursday, June 29, 2017 10:56:29 AM Viresh Kumar wrote:
> Hi,
> 
> Here is the second version of this series. The first [1] version was
> sent several months back.
> 
> With Android UI and benchmarks the latency of cpufreq response to
> certain scheduling events can become very critical. Currently, callbacks
> into schedutil are only made from the scheduler if the target CPU of the
> event is the same as the current CPU. This means there are certain
> situations where a target CPU may not run schedutil for some time.
> 
> One testcase to show this behavior is where a task starts running on
> CPU0, then a new task is also spawned on CPU0 by a task on CPU1. If the
> system is configured such that new tasks should receive maximum demand
> initially, this should result in CPU0 increasing frequency immediately.
> Because of the above mentioned limitation though this does not occur.
> This is verified using ftrace with the sample [2] application.
> 
> Maybe the ideal solution is to always allow remote callbacks but that
> has its own challenges:
> 
> o There is no protection required for single CPU per policy case today,
>   and adding any kind of locking there, to supply remote callbacks,
>   isn't really a good idea.
> 
> o If is local CPU isn't part of the same cpufreq policy as the target
>   CPU, then we wouldn't be able to do fast switching at all and have to
>   use some kind of bottom half to schedule work on the target CPU to do
>   real switching. That may be overkill as well.
> 
> 
> Taking above challenges into consideration, this version proposes a much
> simpler diff as compared to the first version.
> 
> This series only allows remote callbacks for target CPUs that share the
> cpufreq policy with the local CPU. Locking is mostly in place everywhere
> and we wouldn't be required to change a lot of things.
> 
> This series is tested with couple of usecases (Android: hackbench,
> recentfling, galleryfling, vellamo, Ubuntu: hackbench) on ARM hikey
> board (64 bit octa-core, single policy). Only galleryfling showed minor
> improvements, while others didn't had much deviation.
> 
> The reason being that this patchset only targets a corner case, where
> following are required to be true to improve performance and that
> doesn't happen too often with these tests:
> 
> - Task is migrated to another CPU.
> - The task has maximum demand initially, and should take the CPU to
>   higher OPPs.
> - And the target CPU doesn't call into schedutil until the next tick.
> 
> 
> V1->V2:
> - Don't support remote callbacks for unshared cpufreq policies.
> - Don't support remote callbacks where local CPU isn't part of the
>   target CPU's cpufreq policy.
> - Dropped dvfs_possible_from_any_cpu flag.

I would rearrange the changes.

You need two patches for that IMO, one moving the smp_processor_id() check from
the callers of cpufreq_update_util()/cpufreq_update_this_cpu() to the callbacks
in all governors and the other one modifying schedutil to work with cross-CPU
updates.

That at least would reduce the confusion factor somewhat. :-)

Thanks,
Rafael
