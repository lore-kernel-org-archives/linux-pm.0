From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 3/9] cpufreq: Add dvfs_possible_from_any_cpu policy flag
Date: Wed, 29 Mar 2017 23:22:20 +0200
Message-ID: <9819718.SkTYBzvS8V@aspire.rjw.lan>
References: <cover.1489058244.git.viresh.kumar@linaro.org> <4f57e9a7dddcd7e0f821c127cd4e9d87c5807c6c.1489058244.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4f57e9a7dddcd7e0f821c127cd4e9d87c5807c6c.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thursday, March 09, 2017 05:15:13 PM Viresh Kumar wrote:
> On many platforms any CPU (from any cpufreq policy) can perform DVFS on
> behalf of other CPUs. Add a flag to identify such cpufreq policies.
> 
> Also enable it for cpufreq-dt driver which is used only on ARM platforms
> currently.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 1 +
>  include/linux/cpufreq.h      | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index c943787d761e..e57b45f20544 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -274,6 +274,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  		transition_latency = CPUFREQ_ETERNAL;
>  
>  	policy->cpuinfo.transition_latency = transition_latency;
> +	policy->dvfs_possible_from_any_cpu = true;
>  
>  	return 0;
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 87165f06a307..9490a314c515 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -120,6 +120,15 @@ struct cpufreq_policy {
>  	bool			fast_switch_possible;
>  	bool			fast_switch_enabled;
>  
> +	/*
> +	 * Remote DVFS flag (Not added to the driver structure as we don't want
> +	 * to access another structure from scheduler hotpath).
> +	 *
> +	 * Should be set if any CPU (from same or different policy) can do DVFS
> +	 * on behalf of any other CPU.
> +	 */
> +	bool			dvfs_possible_from_any_cpu;

We rely on the assumption that any CPU in a policy can do DVFS in there already.

Why is this flag necessary at all?

> +
>  	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
>  	unsigned int cached_target_freq;
>  	int cached_resolved_idx;
> 

Thanks,
Rafael
