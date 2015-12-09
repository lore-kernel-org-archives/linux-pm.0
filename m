From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq, intel_pstate, minor cleanup for FRAC_BITS
Date: Wed, 9 Dec 2015 07:23:14 +0530
Message-ID: <20151209015314.GM3692@ubuntu>
References: <1449600299-4647-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33620 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbbLIBxT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 20:53:19 -0500
Received: by pabur14 with SMTP id ur14so21181114pab.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 17:53:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449600299-4647-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 08-12-15, 13:44, Prarit Bhargava wrote:
> 785ee27 ("cpufreq: intel_pstate: Fix limits->max_perf rounding error")
> hardcodes the value of FRAC_BITS.  This patch fixes that minor issue.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  drivers/cpufreq/intel_pstate.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 4d07cbd..98fb882 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1123,7 +1123,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  				   limits->max_sysfs_pct);
>  	limits->max_perf_pct = max(limits->min_policy_pct,
>  				   limits->max_perf_pct);
> -	limits->max_perf = round_up(limits->max_perf, 8);
> +	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
>  
>  	/* Make sure min_perf_pct <= max_perf_pct */
>  	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
