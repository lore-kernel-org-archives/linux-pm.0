From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] cpufreq: don't call cpufreq_update_policy() on CPU
 addition
Date: Mon, 17 Feb 2014 14:13:26 +0530
Message-ID: <5301CBAE.3000102@linux.vnet.ibm.com>
References: <15ccc0609cb9ee3db0ad3a95b29bf69d11ea197c.1392375504.git.viresh.kumar@linaro.org> <8f2fc4d6240b567fdb69a0b47f073d174b7ef9b2.1392375504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:52238 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaBQIs7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2014 03:48:59 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 17 Feb 2014 14:18:54 +0530
In-Reply-To: <8f2fc4d6240b567fdb69a0b47f073d174b7ef9b2.1392375504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, pierre-list@ossman.eu

On 02/14/2014 04:30 PM, Viresh Kumar wrote:
> cpufreq_update_policy() is called from two places currently. From a workqueue
> handled queued from cpufreq_bp_resume() for boot CPU and from
> cpufreq_cpu_callback() whenever a CPU is added.
> 
> The first one makes sure that boot CPU is running on the frequency present in
> policy->cpu. But we don't really need a call from cpufreq_cpu_callback(),
> because we always call cpufreq_driver->init() (which will set policy->cur
> correctly) whenever first CPU of any policy is added back. And so every policy
> structure is guaranteed to have the right frequency in policy->cur.
>

This wording is slightly inaccurate. ->init() may or may not set policy->cur
(for example, powernowk8 driver doesn't set it in the init routine)..
But we set it for sure in __cpufreq_add_dev():

1117         if (cpufreq_driver->get) {
1118                 policy->cur = cpufreq_driver->get(policy->cpu);
1119                 if (!policy->cur) {
1120                         pr_err("%s: ->get() failed\n", __func__);
1121                         goto err_get_freq;
1122                 }
1123         }

 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

The reasoning and the code looks good to me.

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> ---
>  drivers/cpufreq/cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 383362b..b6eb4ed 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2194,7 +2194,6 @@ static int cpufreq_cpu_callback(struct notifier_block *nfb,
>  		switch (action & ~CPU_TASKS_FROZEN) {
>  		case CPU_ONLINE:
>  			__cpufreq_add_dev(dev, NULL, frozen);
> -			cpufreq_update_policy(cpu);
>  			break;
> 
>  		case CPU_DOWN_PREPARE:
> 

