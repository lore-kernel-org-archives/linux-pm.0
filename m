From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH resend] cpufreq: ppc-corenet: remove duplicate update of cpu_data
Date: Tue, 30 Sep 2014 22:19:31 +0200
Message-ID: <1831940.KHFBbLhnL0@vostro.rjw.lan>
References: <5714b9e8a37bd5aea5f77676b75d9e7773e0f0e2.1412048958.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52539 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753053AbaI3T7e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 15:59:34 -0400
In-Reply-To: <5714b9e8a37bd5aea5f77676b75d9e7773e0f0e2.1412048958.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: yuantian.tang@freescale.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Tuesday, September 30, 2014 09:19:57 AM Viresh Kumar wrote:
> 'cpu_data' is updated for policy->cpu first and then for all CPUs in
> policy->cpus. policy->cpus is guaranteed to contain policy->cpu as well and so
> the first write to 'cpu_data' for policy->cpu is redundant. Remove it.
> 
> Acked-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 3.18, thanks!

> ---
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
