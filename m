From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Wed, 26 Jul 2017 19:42:01 +0200
Message-ID: <4472861.L87TWDhBo0@aspire.rjw.lan>
References: <cover.1501060871.git.viresh.kumar@linaro.org> <8797d4993baa6580e3af741d081be492032ce9dd.1501060871.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62385 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750921AbdGZRuB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 13:50:01 -0400
In-Reply-To: <8797d4993baa6580e3af741d081be492032ce9dd.1501060871.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org

On Wednesday, July 26, 2017 02:52:32 PM Viresh Kumar wrote:
> We do not call cpufreq callbacks from scheduler core for remote
> (non-local) CPUs currently. But there are cases where such remote
> callbacks are useful, specially in the case of shared cpufreq policies.
> 
> This patch updates the scheduler core to call the cpufreq callbacks for
> remote CPUs as well.
> 
> For now, all the registered utilization update callbacks are updated to
> return early if remote callback is detected. That is, this patch just
> moves the decision making down in the hierarchy.
> 
> Later patches would enable remote callbacks for shared policies.
> 
> Based on initial work from Steve Muckle.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c |  4 ++++
>  drivers/cpufreq/intel_pstate.c     |  8 ++++++++
>  include/linux/sched/cpufreq.h      |  1 +
>  kernel/sched/cpufreq.c             |  1 +
>  kernel/sched/cpufreq_schedutil.c   | 11 ++++++++---
>  kernel/sched/deadline.c            |  2 +-
>  kernel/sched/fair.c                |  8 +++++---
>  kernel/sched/rt.c                  |  2 +-
>  kernel/sched/sched.h               | 10 ++--------
>  9 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index eed069ecfd5e..5499796cf9a8 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -272,6 +272,10 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
>  	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
>  	u64 delta_ns, lst;
>  
> +	/* Don't allow remote callbacks */
> +	if (smp_processor_id() != data->cpu)
> +		return;
> +
>  	/*
>  	 * The work may not be allowed to be queued up right now.
>  	 * Possible reasons:
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 89bbc0c11b22..0dd14c8edd2d 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1747,6 +1747,10 @@ static void intel_pstate_update_util_pid(struct update_util_data *data,
>  	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
>  	u64 delta_ns = time - cpu->sample.time;
>  
> +	/* Don't allow remote callbacks */
> +	if (smp_processor_id() != data->cpu)
> +		return;

You can do this check against cpu->cpu, however.

> +
>  	if ((s64)delta_ns < pid_params.sample_rate_ns)
>  		return;
>  
> @@ -1764,6 +1768,10 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
>  	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
>  	u64 delta_ns;
>  
> +	/* Don't allow remote callbacks */
> +	if (smp_processor_id() != data->cpu)
> +		return;

And same here.

> +
>  	if (flags & SCHED_CPUFREQ_IOWAIT) {
>  		cpu->iowait_boost = int_tofp(1);
>  	} else if (cpu->iowait_boost) {
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index d2be2ccbb372..8256a8f35f22 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -16,6 +16,7 @@
>  #ifdef CONFIG_CPU_FREQ
>  struct update_util_data {
>         void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
> +       unsigned int cpu;

So it looks like you don't need this.

schedutil doesn't need it as per patch [2/3].

ondemand/conservative don't need it as per patch [3/3]

intel_pstate doesn't need this too, because of the above.

Thanks,
Rafael
