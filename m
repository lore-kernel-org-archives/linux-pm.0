From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq, intel_pstate, Fix limits->max_policy_pct
 rounding error
Date: Fri, 20 Nov 2015 18:48:33 +0530
Message-ID: <20151120131833.GD3957@ubuntu>
References: <1448022757-7856-1-git-send-email-prarit@redhat.com>
 <1448022757-7856-2-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34652 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759847AbbKTNSi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Nov 2015 08:18:38 -0500
Received: by padhx2 with SMTP id hx2so116761661pad.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2015 05:18:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448022757-7856-2-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>, Alexandra Yates <alexandra.yates@intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 20-11-15, 07:32, Prarit Bhargava wrote:
> I have a Intel (6,63) processor with a "marketing" frequency (from
> /proc/cpuinfo) of 2100MHz, and a max turbo frequency of 2600MHz.  I
> can execute
> 
> cpupower frequency-set -g powersave --min 1200MHz --max 2100MHz
> 
> and the max_freq_pct is set to 80.  When adding load to the system I noticed
> that the cpu frequency only reached 2000MHZ and not 2100MHz as expected.
> 
> This is because limits->max_policy_pct is calculated as 2100 * 100 /2600 = 80.7
> and is rounded down to 80 when it should be rounded up to 81.  This patch
> adds a DIV_ROUND_UP() which will return the correct value.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Alexandra Yates <alexandra.yates@intel.com>
> Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 001a532..6b63374 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1110,6 +1110,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
>  	limits->max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;

Forgot to remove this line ?

>  	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);

And put this after the later one ?

> +	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
> +					      policy->cpuinfo.max_freq);
>  
>  	/* Normalize user input to [min_policy_pct, max_policy_pct] */
>  	limits->min_perf_pct = max(limits->min_policy_pct,

Sure you tested it  ? :)

-- 
viresh
