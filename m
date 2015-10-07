From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: prevent lockup on reading
 scaling_available_frequencies
Date: Wed, 7 Oct 2015 18:15:08 +0530
Message-ID: <20151007124508.GG902@linux>
References: <1443738182-4077-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1443738182-4077-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35419 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbbJGMpO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 08:45:14 -0400
Received: by pacfv12 with SMTP id fv12so21232440pac.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 05:45:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443738182-4077-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On 01-10-15, 15:23, Srinivas Pandruvada wrote:
> When scaling_available_frequencies is read on an offlined cpu, then
> either lockup or junk values are displayed. This is caused by
> freed freq_table, which policy is using.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index ef5ed94..25c4c15 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1436,8 +1436,10 @@ static void cpufreq_offline_finish(unsigned int cpu)
>  	 * since this is a core component, and is essential for the
>  	 * subsequent light-weight ->init() to succeed.
>  	 */
> -	if (cpufreq_driver->exit)
> +	if (cpufreq_driver->exit) {
>  		cpufreq_driver->exit(policy);
> +		policy->freq_table = NULL;
> +	}
>  }

freq_table was set from the ->init() callbacks and only they should
set it to NULL, isn't it?

-- 
viresh
