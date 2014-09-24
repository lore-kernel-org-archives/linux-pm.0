From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: ppc-corenet: remove duplicate update of cpu_data
Date: Thu, 25 Sep 2014 01:45:40 +0200
Message-ID: <28824009.MYR6qnPOLR@vostro.rjw.lan>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49517 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750793AbaIXXZv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 19:25:51 -0400
In-Reply-To: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: yuantian.tang@freescale.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, hongbo.zhang@freescale.com, leoli@freescale.com

On Tuesday, September 02, 2014 09:11:24 AM Viresh Kumar wrote:
> 'cpu_data' is updated for policy->cpu first and then for all CPUs in
> policy->cpus. policy->cpus is guaranteed to contain policy->cpu as well and so
> the first write to 'cpu_data' for policy->cpu is redundant. Remove it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I'm not sure about the status here?

> ---
> Hi Yuantian,
> 
> I was looking into this driver due to issues reported by Hongtao (cc'd) and
> found that we can live without some code. These aren't fixing any bugs and are
> just cleanups.
> 
> I didn't had a compiler for this and so this isn't even compiled. It would be
> great if you can please review/test these patches.
> 
>  drivers/cpufreq/ppc-corenet-cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
> index 3607070..bee5df7 100644
> --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> +++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
> @@ -199,7 +199,6 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  
>  	data->table = table;
> -	per_cpu(cpu_data, cpu) = data;
>  
>  	/* update ->cpus if we have cluster, no harm if not */
>  	cpumask_copy(policy->cpus, per_cpu(cpu_mask, cpu));
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
