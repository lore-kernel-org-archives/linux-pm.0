From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 211/228] cpufreq: tegra: remove calls to cpufreq_notify_transition()
Date: Fri, 13 Sep 2013 16:52:25 -0600
Message-ID: <52339729.7030309@wwwdotorg.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org> <69073c98beae28a6a75103dd202ec2a6b8b1a674.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <69073c98beae28a6a75103dd202ec2a6b8b1a674.1379063063.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 09/13/2013 07:02 AM, Viresh Kumar wrote:
> Most of the drivers do following in their ->target_index() routines:
> 
> 	struct cpufreq_freqs freqs;
> 	freqs.old = old freq...
> 	freqs.new = new freq...
> 
> 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> 
> 	/* Change rate here */
> 
> 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> 
> This is replicated over all cpufreq drivers today and there doesn't exists a
> good enough reason why this shouldn't be moved to cpufreq core instead.
> 
> Earlier patches have added support in cpufreq core to do cpufreq notification on
> frequency change, this one removes it from this driver.
> 
> Some related minor cleanups are also done along with it.

> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c

> @@ -121,21 +117,10 @@ static int tegra_update_cpu_speed(struct cpufreq_policy *policy,
>  	else
>  		clk_set_rate(emc_clk, 100000000);  /* emc 50Mhz */
>  
> -	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
...
> -	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);

I wonder if this series is bisectable? Perhaps I should just go and read
the rest of the series, but I presume there's a patch somewhere else
that adds those two cpufreq_notify_transition() to the cpufreq core.
Either that happens before this patch (in which case listeners will get
two notifications each time; perhaps that is safe?), or after this patch
(in which case with just this patch applied, no notifications will be
sent until a later patch!

Aside from that, all the Tegra-specific patches in this series,
Acked-by: Stephen Warren <swarren@nvidia.com>

