From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/4] cpufreq: Add configurable generic policies
Date: Wed, 9 Dec 2015 07:48:04 +0530
Message-ID: <20151209021804.GR3692@ubuntu>
References: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1449613890-10403-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35369 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbbLICSI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 21:18:08 -0500
Received: by pfu207 with SMTP id 207so21611650pfu.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 18:18:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449613890-10403-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, prarit@redhat.com, trenn@suse.de

On 08-12-15, 14:31, Srinivas Pandruvada wrote:
> For drivers using cpufreq_driver->setpolicy callback, by default two
> policies are available (performance and powersave). The client drivers
> can't change them, even if there is no support for a policy.
> This change adds a new field "available_policies" in the struct
> cpufreq_policy. The client driver can optionally set this field during
> init() callback. If the client driver doesn't set this field then the
> default policies are "performance powersave" matching current
> implementation.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/cpufreq.c | 9 ++++++++-
>  include/linux/cpufreq.h   | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 8412ce5..286eaec 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -688,7 +688,10 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
>  	struct cpufreq_governor *t;
>  
>  	if (!has_target()) {
> -		i += sprintf(buf, "performance powersave");
> +		if (policy->available_policies & CPUFREQ_POLICY_PERFORMANCE)
> +			i += sprintf(buf, "performance ");
> +		if (policy->available_policies & CPUFREQ_POLICY_POWERSAVE)
> +			i += sprintf(&buf[i], "powersave ");
>  		goto out;
>  	}
>  
> @@ -966,6 +969,10 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  
>  	memcpy(&new_policy, policy, sizeof(*policy));
>  
> +	if (!policy->available_policies)
> +		policy->available_policies = CPUFREQ_POLICY_PERFORMANCE |
> +						CPUFREQ_POLICY_POWERSAVE;
> +
>  	/* Update governor of new_policy to the governor used before hotplug */
>  	gov = find_governor(policy->last_governor);
>  	if (gov)
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 177c768..7cc17df 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -76,6 +76,7 @@ struct cpufreq_policy {
>  	unsigned int		restore_freq; /* = policy->cur before transition */
>  	unsigned int		suspend_freq; /* freq to set during suspend */
>  
> +	u8			available_policies;
>  	unsigned int		policy; /* see above */
>  	unsigned int		last_policy; /* policy before unplug */
>  	struct cpufreq_governor	*governor; /* see below */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
