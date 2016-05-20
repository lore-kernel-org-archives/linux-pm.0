From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU
 offline/online locked
Date: Fri, 20 May 2016 07:52:47 +0530
Message-ID: <20160520022247.GS32001@vireshk-i7>
References: <19792191.esL3UuyORb@vostro.rjw.lan>
 <2278154.xyiFOocWfq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36000 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059AbcETCWy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 22:22:54 -0400
Received: by mail-pf0-f174.google.com with SMTP id c189so37212833pfb.3
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 19:22:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2278154.xyiFOocWfq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 20-05-16, 03:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Loops over online CPUs in cpufreq_stats_init() and cpufreq_stats_exit()
> should be carried out with CPU offline/online locked or races are
> possible otherwise, so make that happen.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: On a second thought, add the policy notifier in cpufreq_stats_init()
>   with CPU offline/online locked too.
> 
> ---
>  drivers/cpufreq/cpufreq_stats.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_stats.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_stats.c
> +++ linux-pm/drivers/cpufreq/cpufreq_stats.c
> @@ -317,10 +317,13 @@ static int __init cpufreq_stats_init(voi
>  	unsigned int cpu;
>  
>  	spin_lock_init(&cpufreq_stats_lock);
> +
> +	get_online_cpus();
> +
>  	ret = cpufreq_register_notifier(&notifier_policy_block,
>  				CPUFREQ_POLICY_NOTIFIER);

Why is this required to be protected ?

>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	for_each_online_cpu(cpu)
>  		cpufreq_stats_create_table(cpu);
> @@ -332,21 +335,28 @@ static int __init cpufreq_stats_init(voi
>  				CPUFREQ_POLICY_NOTIFIER);
>  		for_each_online_cpu(cpu)
>  			cpufreq_stats_free_table(cpu);

Maybe we can make this for_each_possible_cpu() then, and so getting a
policy will fail for CPUs which aren't online.

And we wouldn't need to use get_online_cpus() then ?

-- 
viresh
