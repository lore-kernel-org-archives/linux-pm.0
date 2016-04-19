From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/2] cpufreq: qoriq: Fix cooling device registration
 issue during suspend
Date: Tue, 19 Apr 2016 14:42:00 +0530
Message-ID: <20160419091200.GB2905@vireshk-i7>
References: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
 <1461056407-22542-2-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34131 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbcDSJMD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2016 05:12:03 -0400
Received: by mail-pf0-f172.google.com with SMTP id c20so4983821pfc.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2016 02:12:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461056407-22542-2-git-send-email-hongtao.jia@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com, yuantian.tang@nxp.com

On 19-04-16, 17:00, Jia Hongtao wrote:
> Cooling device is registered by ready callback. It's also invoked while
> system resuming from sleep (Enabling non-boot cpus). Thus cooling device
> may be multiple registered. Matchable unregistration is added to exit
> callback to fix this issue.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 3a3fe39..0b85f90 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -305,6 +305,7 @@ static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct cpu_data *data = policy->driver_data;
>  
> +	cpufreq_cooling_unregister(data->cdev);
>  	kfree(data->pclk);
>  	kfree(data->table);
>  	kfree(data);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
