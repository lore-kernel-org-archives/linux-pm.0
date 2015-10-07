From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: prevent lockup on reading
 scaling_available_frequencies
Date: Thu, 8 Oct 2015 00:02:00 +0530
Message-ID: <20151007183200.GJ4557@linux>
References: <1443738182-4077-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1443738182-4077-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36715 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbbJGScF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 14:32:05 -0400
Received: by pablk4 with SMTP id lk4so28488667pab.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 11:32:04 -0700 (PDT)
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
