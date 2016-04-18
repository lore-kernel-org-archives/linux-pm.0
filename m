From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: qoriq: Fix cooling device registration
 issue during suspend
Date: Mon, 18 Apr 2016 16:02:54 +0530
Message-ID: <20160418103254.GD2322@vireshk-i7>
References: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35394 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbcDRKdN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 06:33:13 -0400
Received: by mail-pa0-f41.google.com with SMTP id fs9so59036960pac.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2016 03:33:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com, yuantian.tang@nxp.com

On 18-04-16, 15:59, Jia Hongtao wrote:
> Cooling device is registered by ready callback. It's also invoked while
> system resuming from sleep (Enabling non-boot cpus). Thus cooling device
> may be multiple registered. Stop_cpu callback is invoked during suspend
> (Disabling non-boot cpus). So matchable unregistration is added to fix
> this issue.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index b23e525..1c2fdc1 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -305,6 +305,7 @@ static int __exit qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct cpu_data *data = policy->driver_data;
>  
> +	cpufreq_cooling_unregister(data->cdev);
>  	kfree(data->pclk);
>  	kfree(data->table);
>  	kfree(data);
> @@ -323,6 +324,12 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
>  	return clk_set_parent(policy->clk, parent);
>  }
>  
> +static void qoriq_cpufreq_stop_cpu(struct cpufreq_policy *policy)
> +{
> +	struct cpu_data *cpud = policy->driver_data;
> +
> +	cpufreq_cooling_unregister(cpud->cdev);
> +}
>  
>  static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
>  {
> @@ -352,6 +359,7 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= qoriq_cpufreq_target,
>  	.get		= cpufreq_generic_get,
> +	.stop_cpu	= qoriq_cpufreq_stop_cpu,
>  	.ready		= qoriq_cpufreq_ready,
>  	.attr		= cpufreq_generic_attr,
>  };

You don't need to do it from stop_cpu(), please use
qoriq_cpufreq_cpu_exit() for this.

-- 
viresh
