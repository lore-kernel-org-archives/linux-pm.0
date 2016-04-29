From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 1/4] cpufreq: governor: support scheduler cpufreq
 callbacks on remote CPUs
Date: Fri, 29 Apr 2016 16:08:16 +0530
Message-ID: <20160429103816.GC2927@vireshk-i7>
References: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 19-04-16, 19:39, Steve Muckle wrote:
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

Any clue, why we don't have a non-SMP version of irq_work_queue_on(), Which can
simply call irq_work_queue() ?

-- 
viresh
