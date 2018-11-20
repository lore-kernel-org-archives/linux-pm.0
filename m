From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v9 15/15] OPTIONAL: cpufreq: dt: Register an Energy Model
Date: Tue, 20 Nov 2018 11:49:25 +0530
Message-ID: <20181120061925.t6j5jjepziq2gcsh@vireshk-i7>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-16-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119141857.8625-16-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 19-11-18, 14:18, Quentin Perret wrote:
>  static int cpufreq_init(struct cpufreq_policy *policy)
>  {
> +	struct em_data_callback em_cb = EM_DATA_CB(of_est_power);
>  	struct cpufreq_frequency_table *freq_table;
>  	struct opp_table *opp_table = NULL;
>  	struct private_data *priv;
> @@ -160,7 +203,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	unsigned int transition_latency;
>  	bool fallback = false;
>  	const char *name;
> -	int ret;
> +	int ret, nr_opp;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -237,6 +280,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  		ret = -EPROBE_DEFER;
>  		goto out_free_opp;
>  	}
> +	nr_opp = ret;
>  
>  	if (fallback) {
>  		cpumask_setall(policy->cpus);
> @@ -280,6 +324,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  
> +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
> +
>  	return 0;
>  
>  out_free_cpufreq_table:

I haven't gone deep into the series, but why don't we need something
like em_unregister_perf_domain()? That can be used if the cpufreq
driver goes away. Else loading/unloading/loading the cpufreq driver
may register the perf-domain callback again.

-- 
viresh
