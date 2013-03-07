From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH V2] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
Date: Thu, 7 Mar 2013 22:56:54 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1303072248560.20470@axis700.grange>
References: <6cba8f153cfd4b0d3075a34a6dfe287bdec2eb06.1362676407.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <6cba8f153cfd4b0d3075a34a6dfe287bdec2eb06.1362676407.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, Steve.Bannister@arm.com, linux@arm.linux.org.uk, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, devicetree-discuss@lists.ozlabs.org, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, robin.randhawa@arm.com, linux-arm-kernel@lists.infradead.org, mark.hambleton@broadcom.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

Hi Viresh

On Fri, 8 Mar 2013, Viresh Kumar wrote:

> big LITTLE is ARM's new Architecture focussing power/performance needs of modern
> world. More information about big LITTLE can be found here:
> 
> http://www.arm.com/products/processors/technologies/biglittleprocessing.php
> http://lwn.net/Articles/481055/
> 
> In order to keep cpufreq support for all big LITTLE platforms simple/generic,
> this patch tries to add a generic cpufreq driver layer for all big LITTLE
> platforms.

I like generic drivers :) cpufreq-cpu0 is yet another such generic 
(cpufreq) driver. Now, comparing the functionality of the two:

[snip]

> +/* Set clock frequency */
> +static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
> +		unsigned int target_freq, unsigned int relation)
> +{
> +	struct cpufreq_freqs freqs;
> +	u32 cpu = policy->cpu, freq_tab_idx, cur_cluster;
> +	int ret = 0;
> +
> +	cur_cluster = cpu_to_cluster(policy->cpu);
> +
> +	freqs.old = bL_cpufreq_get(policy->cpu);
> +
> +	/* Determine valid target frequency using freq_table */
> +	cpufreq_frequency_table_target(policy, freq_table[cur_cluster],
> +			target_freq, relation, &freq_tab_idx);
> +	freqs.new = freq_table[cur_cluster][freq_tab_idx].frequency;
> +
> +	freqs.cpu = policy->cpu;
> +
> +	pr_debug("%s: cpu: %d, cluster: %d, oldfreq: %d, target freq: %d, new freq: %d\n",
> +			__func__, cpu, cur_cluster, freqs.old, target_freq,
> +			freqs.new);
> +
> +	if (freqs.old == freqs.new)
> +		return 0;
> +
> +	for_each_cpu(freqs.cpu, policy->cpus)
> +		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
> +	ret = clk_set_rate(clk[cur_cluster], freqs.new * 1000);

we see, that this driver "only" switches CPU clock frequencies. Whereas 
the cpufreq-cpu0 driver also manipulates a regulator (if available) 
directly. I understand, power-saving is also an important consideration 
for big.LITTLE systems. So, I presume, you plan to implement voltage 
switching in cpufreq notifiers? Now, my question is: is this (notifier) 
actually the preferred method and the cpufreq-cpu0 driver is doing it 
"wrongly?"

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
