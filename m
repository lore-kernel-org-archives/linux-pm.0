From: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
Subject: Re: [PATCH] [v2] intel_pstate: Fix user input of min/max to legal
 policy region
Date: Wed, 9 Sep 2015 20:12:01 +0900
Message-ID: <55F01401.10004@jp.fujitsu.com>
References: <1441794451-29979-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:27106 "EHLO
	mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbbIILQt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 07:16:49 -0400
In-Reply-To: <1441794451-29979-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: kristen@linux.intel.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Yu

On 2015-09-09 19:27, Chen Yu wrote:
> In current code, max_perf_pct might be smaller than min_perf_pct
> by improper user input:
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
> Fix this problem by 2 steps:
> 1.Normalize the user input to [min_policy, max_policy].
> 2.Make sure max_perf_pct>=min_perf_pct, suggested by Seiichi Ikarashi.
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2:
>  - Add logic to ensure max_perf_pct>=min_perf_pct.
> ---
>  drivers/cpufreq/intel_pstate.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index fcb929e..a0b935f 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -423,6 +423,8 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
>  
>  	limits.max_sysfs_pct = clamp_t(int, input, 0 , 100);
>  	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
> +	limits.max_perf_pct = max(limits.min_policy_pct, limits.max_perf_pct);
> +	limits.max_perf_pct = max(limits.min_perf_pct, limits.max_perf_pct);
>  	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
>  
>  	if (hwp_active)
> @@ -442,6 +444,8 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
>  
>  	limits.min_sysfs_pct = clamp_t(int, input, 0 , 100);
>  	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
> +	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
> +	limits.min_perf_pct = min(limits.max_perf_pct, limits.min_perf_pct);
>  	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
>  
>  	if (hwp_active)
> @@ -985,12 +989,19 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  
>  	limits.min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
>  	limits.min_policy_pct = clamp_t(int, limits.min_policy_pct, 0 , 100);
> -	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
> -	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
> -
>  	limits.max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
>  	limits.max_policy_pct = clamp_t(int, limits.max_policy_pct, 0 , 100);
> +
> +	/* Normalize user input to [min_policy_pct, max_policy_pct] */
> +	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
> +	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
>  	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
> +	limits.max_perf_pct = max(limits.min_policy_pct, limits.max_perf_pct);
> +
> +	/* Make sure min_perf_pct <= max_perf_pct */
> +	limits.min_perf_pct = min(limits.max_perf_pct, limits.min_perf_pct);

You chose max_perf_pct prior to min_perf_pct here.
I agree.

> +
> +	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
>  	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
>  
>  	if (hwp_active)
> 

I think this patch is what it should be. Good job.

Regards,
Seiichi

