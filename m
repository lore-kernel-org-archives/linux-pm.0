From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/2] cpufreq: powernv: Ramp-down global pstate slower
 than local-pstate
Date: Mon, 18 Apr 2016 15:48:46 +0530
Message-ID: <20160418101846.GB2322@vireshk-i7>
References: <1460701739-31549-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460701739-31549-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36303 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbcDRKSt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 06:18:49 -0400
Received: by mail-pf0-f179.google.com with SMTP id e128so79379449pfe.3
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2016 03:18:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460701739-31549-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com

On 15-04-16, 11:58, Akshay Adiga wrote:
>  static int powernv_cpufreq_reboot_notifier(struct notifier_block *nb,
> -				unsigned long action, void *unused)
> +					   unsigned long action, void *unused)

Unrelated change.. better don't add such changes..

>  {
>  	int cpu;
>  	struct cpufreq_policy cpu_policy;
> @@ -603,15 +843,18 @@ static struct notifier_block powernv_cpufreq_opal_nb = {
>  static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>  {
>  	struct powernv_smp_call_data freq_data;
> -
> +	struct global_pstate_info *gpstates = policy->driver_data;

You removed a blank line here and I feel the code looks better with
that.

>  	freq_data.pstate_id = powernv_pstate_info.min;
> +	freq_data.gpstate_id = powernv_pstate_info.min;
>  	smp_call_function_single(policy->cpu, set_pstate, &freq_data, 1);
> +	del_timer_sync(&gpstates->timer);
>  }
>  
>  static struct cpufreq_driver powernv_cpufreq_driver = {
>  	.name		= "powernv-cpufreq",
>  	.flags		= CPUFREQ_CONST_LOOPS,
>  	.init		= powernv_cpufreq_cpu_init,
> +	.exit		= powernv_cpufreq_cpu_exit,
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= powernv_cpufreq_target_index,
>  	.get		= powernv_cpufreq_get,

None of the above comments are mandatory for you to fix..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
