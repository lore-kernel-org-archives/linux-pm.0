From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix incorrect usage of clamp_val()
Date: Wed, 1 Jun 2016 07:02:28 +0530
Message-ID: <20160601013228.GA3725@vireshk-i7>
References: <a5c21ebe773d364b49bc5df9c4f69ff2eb181dbb.1464693539.git.viresh.kumar@linaro.org>
 <20160531182308.GJ9864@graphite.smuckle.net>
 <4985583.nmytFqifgB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33631 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbcFABce (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 21:32:34 -0400
Received: by mail-pf0-f182.google.com with SMTP id b124so3767936pfb.0
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 18:32:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4985583.nmytFqifgB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 31-05-16, 22:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: Fix clamp_val() usage in cpufreq_driver_fast_switch()
> 
> The return value of clamp_val() has to be stored actually.
> 
> Fixes: b7898fda5bc7 (cpufreq: Support for fast frequency switching)
> Reported-by: Steve Muckle <steve.muckle@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1829,7 +1829,7 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
>  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  					unsigned int target_freq)
>  {
> -	clamp_val(target_freq, policy->min, policy->max);
> +	target_freq = clamp_val(target_freq, policy->min, policy->max);
>  
>  	return cpufreq_driver->fast_switch(policy, target_freq);
>  }

I should have at least grepped for it during my fix.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
