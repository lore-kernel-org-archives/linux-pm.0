From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 1/4] cpufreq: governor: support scheduler cpufreq callbacks on remote CPUs
Date: Wed, 20 Apr 2016 14:26:06 +0200
Message-ID: <1975350.dnmiS2ECMV@vostro.rjw.lan>
References: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 19, 2016 07:39:26 PM Steve Muckle wrote:

You could have added a cover [0/4] message which would have made it easier
to reply to the entire series in general.  Let me do it here.

Doing it the way it is done in this series would be fine by me in general
(up to a few more or less minor comments), but it is still unclear to me
how much of a difference these changes would make in terms of improved
response times etc.

> In preparation for the scheduler cpufreq callback happening
> on remote CPUs, add support for this in the dbs governors.
> The dbs governors make assumptions about the callback occurring
> on the CPU being updated.

While the above is generally correct, it would be nice to say more about what
happens in the patch.  Like:

"To that end, add a CPU number field to struct cpu_dbs_info and modify
dbs_update_util_handler() to schedule IRQ works on target CPUs rather than on
the local one only."

> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 21 +++++++++++++++++++--
>  drivers/cpufreq/cpufreq_governor.h |  1 +
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 20f0a4e114d1..429d3a5b9866 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -248,6 +248,20 @@ static void dbs_irq_work(struct irq_work *irq_work)
>  	schedule_work_on(smp_processor_id(), &policy_dbs->work);
>  }
>  
> +#ifdef CONFIG_SMP
> +static inline void dbs_irq_work_queue(struct policy_dbs_info *policy_dbs,
> +				      int cpu)
> +{
> +	irq_work_queue_on(&policy_dbs->irq_work, cpu);
> +}
> +#else
> +static inline void dbs_irq_work_queue(struct policy_dbs_info *policy_dbs,
> +				      int cpu)
> +{
> +	irq_work_queue(&policy_dbs->irq_work);
> +}
> +#endif
> +
>  static void dbs_update_util_handler(struct update_util_data *data, u64 time,
>  				    unsigned long util, unsigned long max)
>  {
> @@ -295,7 +309,7 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
>  
>  	policy_dbs->last_sample_time = time;
>  	policy_dbs->work_in_progress = true;
> -	irq_work_queue(&policy_dbs->irq_work);
> +	dbs_irq_work_queue(policy_dbs, cdbs->cpu);
>  }
>  
>  static void gov_set_update_util(struct policy_dbs_info *policy_dbs,
> @@ -384,7 +398,7 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
>  	struct dbs_data *dbs_data;
>  	struct policy_dbs_info *policy_dbs;
>  	unsigned int latency;
> -	int ret = 0;
> +	int j, ret = 0;
>  
>  	/* State should be equivalent to EXIT */
>  	if (policy->governor_data)
> @@ -394,6 +408,9 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
>  	if (!policy_dbs)
>  		return -ENOMEM;
>  
> +	for_each_cpu(j, policy->cpus)
> +		per_cpu(cpu_dbs, j).cpu = j;
> +
>  	/* Protect gov->gdbs_data against concurrent updates. */
>  	mutex_lock(&gov_dbs_data_mutex);
>  
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 3e0eb7c54903..1d5f4857ff80 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -122,6 +122,7 @@ struct cpu_dbs_info {
>  	unsigned int prev_load;
>  	struct update_util_data update_util;
>  	struct policy_dbs_info *policy_dbs;
> +	int cpu;
>  };

Wouldn't it be better to add the cpu field to struct update_util_data and set
it from cpufreq_add_update_util_hook()?

That would allow you to avoid adding the cpu field to struct sugov_cpu in the
second patch at least.

Thanks,
Rafael
