From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix incorrect usage of clamp_val()
Date: Tue, 31 May 2016 11:23:08 -0700
Message-ID: <20160531182308.GJ9864@graphite.smuckle.net>
References: <a5c21ebe773d364b49bc5df9c4f69ff2eb181dbb.1464693539.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36644 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbcEaSXM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 14:23:12 -0400
Received: by mail-pf0-f173.google.com with SMTP id f144so64187250pfa.3
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 11:23:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a5c21ebe773d364b49bc5df9c4f69ff2eb181dbb.1464693539.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Tue, May 31, 2016 at 04:49:42PM +0530, Viresh Kumar wrote:
> clamp_val() doesn't change anything by itself, rather it returns the
> clamped value.
> 
> Fix it.
> 
> Fixes: 0ac587b32f49 ("cpufreq: Use clamp_val() in __cpufreq_driver_target()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Rafael,
> 
> Please merge this with the offending commit if you are fine with rebase,
> else apply this one as well.
> 
> Sorry for blindly copying code.
> 
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d0c02a7eec0f..c6a14ba239a2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1927,7 +1927,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>  		return -ENODEV;
>  
>  	/* Make sure that target_freq is within supported range */
> -	clamp_val(target_freq, policy->min, policy->max);
> +	target_freq = clamp_val(target_freq, policy->min, policy->max);
>  
>  	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
>  		 policy->cpu, target_freq, relation, old_target_freq);

As mentioned in the other thread cpufreq_driver_fast_switch() has this
problem as well, might as well fix it in this patch also.

thanks,
Steve
