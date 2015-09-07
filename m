From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][rfc] intel_pstate: Fix user input of min/max to legal policy region
Date: Mon, 07 Sep 2015 23:47:29 +0200
Message-ID: <1972415.RSWZSVEEko@vostro.rjw.lan>
References: <1439351359-29532-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50706 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751162AbbIGVTk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 17:19:40 -0400
In-Reply-To: <1439351359-29532-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>, kristen@linux.intel.com
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, lenb@kernel.org

On Wednesday, August 12, 2015 11:49:19 AM Chen Yu wrote:
> In current code, if system is using performance policy, user can
> modify the max_perf_pct to any values lower than 100:
> 
> $ grep . /sys/devices/system/cpu/intel_pstate/m*_perf_pct
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:100
> 
> $ echo 80 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
> 
> $ grep . /sys/devices/system/cpu/intel_pstate/m*_perf_pct
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:80
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:100
> 
> the max_perf_pct above is lower than min_perf_pct, which
> is not reasonable.
> 
> This patch solves this problem by clamping min_perf_pct and max_perf_pct
> to be strictly inside [min_policy_pct,max_policy_pct].
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Looks reasonable to me.

Kristen, any objections?


> ---
>  drivers/cpufreq/intel_pstate.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index fcb929e..3702c5a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -423,6 +423,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
>  
>  	limits.max_sysfs_pct = clamp_t(int, input, 0 , 100);
>  	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
> +	limits.max_perf_pct = max(limits.min_policy_pct, limits.max_perf_pct);
>  	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
>  
>  	if (hwp_active)
> @@ -442,6 +443,7 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
>  
>  	limits.min_sysfs_pct = clamp_t(int, input, 0 , 100);
>  	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
> +	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
>  	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
>  
>  	if (hwp_active)
> @@ -985,12 +987,14 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  
>  	limits.min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
>  	limits.min_policy_pct = clamp_t(int, limits.min_policy_pct, 0 , 100);
> -	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
> -	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
> -
>  	limits.max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
>  	limits.max_policy_pct = clamp_t(int, limits.max_policy_pct, 0 , 100);
> +
> +	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
> +	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
> +	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
>  	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
> +	limits.max_perf_pct = max(limits.min_policy_pct, limits.max_perf_pct);
>  	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
>  
>  	if (hwp_active)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
