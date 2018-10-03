From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 08/14] sched/topology: Disable EAS on inappropriate
 platforms
Date: Wed, 3 Oct 2018 18:27:19 +0200
Message-ID: <20181003162719.GB19252@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-9-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912091309.7551-9-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 12, 2018 at 10:13:03AM +0100, Quentin Perret wrote:
> @@ -288,6 +321,21 @@ static void build_perf_domains(const struct cpumask *cpu_map)
>  			goto free;
>  		tmp->next = pd;
>  		pd = tmp;
> +
> +		/*
> +		 * Count performance domains and capacity states for the
> +		 * complexity check.
> +		 */
> +		nr_pd++;
> +		nr_cs += em_pd_nr_cap_states(pd->obj);
> +	}
> +
> +	/* Bail out if the Energy Model complexity is too high. */
> +	if (nr_pd * (nr_cs + nr_cpus) > EM_MAX_COMPLEXITY) {
> +		if (sched_debug())
> +			pr_info("rd %*pbl: EM complexity is too high\n ",
> +						cpumask_pr_args(cpu_map));
> +		goto free;
>  	}

I would make than an unconditional WARN, we do not really expect that to
trigger, but then it does, we really don't want to hide it.
