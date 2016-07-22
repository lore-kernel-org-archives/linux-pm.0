From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: export cpufreq_driver_resolve_freq()
Date: Thu, 21 Jul 2016 20:30:44 -0700
Message-ID: <20160722033044.GO3122@ubuntu>
References: <1469154278-7373-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36731 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbcGVDaq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 23:30:46 -0400
Received: by mail-pa0-f47.google.com with SMTP id pp5so35068942pac.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2016 20:30:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1469154278-7373-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Steve Muckle <smuckle@linaro.org>

On 21-07-16, 19:24, Steve Muckle wrote:
> Export cpufreq_driver_resolve_freq() since governors may be compiled as
> modules.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b696baeb249d..fa0a92d6121e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -514,6 +514,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>  					       CPUFREQ_RELATION_L);
>  	return policy->freq_table[policy->cached_resolved_idx].frequency;
>  }
> +EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>  
>  /*********************************************************************
>   *                          SYSFS INTERFACE                          *

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
