From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: qoriq: Fix cooling device registration issue
 during suspend
Date: Tue, 19 Apr 2016 13:24:00 +0530
Message-ID: <20160419075400.GB2715@vireshk-i7>
References: <1461048206-23567-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33609 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbcDSHyE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2016 03:54:04 -0400
Received: by mail-pf0-f175.google.com with SMTP id 184so4350533pff.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2016 00:54:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461048206-23567-1-git-send-email-hongtao.jia@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com, yuantian.tang@nxp.com

On 19-04-16, 14:43, Jia Hongtao wrote:
> Cooling device is registered by ready callback. It's also invoked while
> system resuming from sleep (Enabling non-boot cpus). Thus cooling device
> may be multiple registered. Matchable unregistration is added to exit
> callback to fix this issue.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
> Changes for V2:
> * Using qoriq_cpufreq_cpu_exit() callback instead of adding stop_cpu().
> 
>  drivers/cpufreq/qoriq-cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index b23e525..0b85f90 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -301,10 +301,11 @@ err_np:
>  	return -ENODEV;
>  }
>  
> -static int __exit qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)

Yes, __exit should have been removed, but not in this patch to create confusion.
You should have submitted two separate patches for these changes.

>  {
>  	struct cpu_data *data = policy->driver_data;
>  
> +	cpufreq_cooling_unregister(data->cdev);
>  	kfree(data->pclk);
>  	kfree(data->table);
>  	kfree(data);
> @@ -348,7 +349,7 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
>  	.name		= "qoriq_cpufreq",
>  	.flags		= CPUFREQ_CONST_LOOPS,
>  	.init		= qoriq_cpufreq_cpu_init,
> -	.exit		= __exit_p(qoriq_cpufreq_cpu_exit),
> +	.exit		= qoriq_cpufreq_cpu_exit,
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= qoriq_cpufreq_target,
>  	.get		= cpufreq_generic_get,
> -- 
> 2.1.0.27.g96db324

-- 
viresh
