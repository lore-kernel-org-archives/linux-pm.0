From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: ondemand: Simplify od_update() slightly
Date: Wed, 17 Feb 2016 10:42:18 +0530
Message-ID: <20160217051218.GI2454@vireshk-i7>
References: <76641630.CimCW8476L@vostro.rjw.lan>
 <4864381.Sc603abrG6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33102 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbcBQFM3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 00:12:29 -0500
Received: by mail-pf0-f170.google.com with SMTP id q63so4719810pfb.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2016 21:12:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4864381.Sc603abrG6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 16-02-16, 21:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop some lines of code from od_update() by arranging the statements
> in there in a more logical way.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c |   11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
> +++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> @@ -175,14 +175,11 @@ static void od_update(struct cpufreq_pol
>  		/* No longer fully busy, reset rate_mult */
>  		policy_dbs->rate_mult = 1;
>  
> -		if (!od_tuners->powersave_bias) {
> -			__cpufreq_driver_target(policy, freq_next,
> -					CPUFREQ_RELATION_C);
> -			return;
> -		}
> +		if (od_tuners->powersave_bias)
> +			freq_next = od_ops.powersave_bias_target(policy,
> +								 freq_next,
> +								 CPUFREQ_RELATION_L);
>  
> -		freq_next = od_ops.powersave_bias_target(policy, freq_next,
> -					CPUFREQ_RELATION_L);
>  		__cpufreq_driver_target(policy, freq_next, CPUFREQ_RELATION_C);
>  	}
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
