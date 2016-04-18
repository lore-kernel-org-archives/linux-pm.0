From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: qoriq: Don't show cooling device messages
 if THERMAL_OF undefined
Date: Mon, 18 Apr 2016 16:03:45 +0530
Message-ID: <20160418103345.GE2322@vireshk-i7>
References: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
 <1460966372-4877-2-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36617 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbcDRKds (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 06:33:48 -0400
Received: by mail-pa0-f46.google.com with SMTP id er2so49254506pad.3
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2016 03:33:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460966372-4877-2-git-send-email-hongtao.jia@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com, yuantian.tang@nxp.com

On 18-04-16, 15:59, Jia Hongtao wrote:
> When THERMAL_OF is undefined the cooling device messages should not be
> shown. -ENOSYS is returned from of_cpufreq_cooling_register() when
> THERMAL_OF is undefined.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 1c2fdc1..ff8da83 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -340,8 +340,8 @@ static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
>  		cpud->cdev = of_cpufreq_cooling_register(np,
>  							 policy->related_cpus);
>  
> -		if (IS_ERR(cpud->cdev)) {
> -			pr_err("Failed to register cooling device cpu%d: %ld\n",
> +		if (IS_ERR(cpud->cdev) && PTR_ERR(cpud->cdev) != -ENOSYS) {
> +			pr_err("cpu%d is not running as cooling device: %ld\n",
>  					policy->cpu, PTR_ERR(cpud->cdev));
>  
>  			cpud->cdev = NULL;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
