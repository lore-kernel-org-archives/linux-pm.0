From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/4] Documentation: cpu-freq: update setpolicy
 documentation
Date: Wed, 9 Dec 2015 07:49:10 +0530
Message-ID: <20151209021910.GS3692@ubuntu>
References: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1449613890-10403-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34836 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbbLICTO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 21:19:14 -0500
Received: by pfu207 with SMTP id 207so21626121pfu.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 18:19:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449613890-10403-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, prarit@redhat.com, trenn@suse.de

On 08-12-15, 14:31, Srinivas Pandruvada wrote:
> Updated documentation for usage of setpolicy interface.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/cpu-freq/cpu-drivers.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.txt
> index 14f4e63..144e0ad 100644
> --- a/Documentation/cpu-freq/cpu-drivers.txt
> +++ b/Documentation/cpu-freq/cpu-drivers.txt
> @@ -195,8 +195,13 @@ argument. You need to set the lower limit of the in-processor or
>  in-chipset dynamic frequency switching to policy->min, the upper limit
>  to policy->max, and -if supported- select a performance-oriented
>  setting when policy->policy is CPUFREQ_POLICY_PERFORMANCE, and a
> -powersaving-oriented setting when CPUFREQ_POLICY_POWERSAVE. Also check
> -the reference implementation in drivers/cpufreq/longrun.c
> +powersaving-oriented setting when CPUFREQ_POLICY_POWERSAVE, and a
> +optional on demand frequency scaling setting when
> +CPUFREQ_POLICY_ONDEMAND. The default supported policies are
> +CPUFREQ_POLICY_PERFORMANCE and CPUFREQ_POLICY_POWERSAVE. To change or
> +add supported policies set policy->available_policies with a mask of
> +supported policies. Also check the reference implementation in
> +drivers/cpufreq/longrun.c and intel_pstate.c.
>  
>  1.7 get_intermediate and target_intermediate
>  --------------------------------------------

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
