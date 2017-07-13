From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 0/3] sched: cpufreq: Allow remote callbacks
Date: Thu, 13 Jul 2017 17:17:19 +0200
Message-ID: <CAJZ5v0gocJZJLsF4=2eWzbmDkzbPYGr+n88dZVsMdBF5hPU=pA@mail.gmail.com>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1499927699.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <smuckle.linux@gmail.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, eas-dev@lists.linaro.org, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 13, 2017 at 8:44 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
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
> This is verified using ftrace with the sample [1] application.
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
> And so this series only allows remote callbacks for target CPUs that
> share the cpufreq policy with the local CPU.
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

I don't have any problems with this series at this point, so you can add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the patches.

I can't apply them without ACKs from Peter or Ingo, though.

Thanks,
Rafael
