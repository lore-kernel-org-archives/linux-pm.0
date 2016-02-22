From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: simplify for_each_suitable_policy() macro
Date: Mon, 22 Feb 2016 11:03:15 +0530
Message-ID: <20160222053315.GE28226@vireshk-i7>
References: <1456080792-22770-1-git-send-email-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34957 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbcBVFde (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 00:33:34 -0500
Received: by mail-pf0-f171.google.com with SMTP id c10so89419672pfc.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Feb 2016 21:33:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456080792-22770-1-git-send-email-ebiggers3@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 21-02-16, 12:53, Eric Biggers wrote:
> Signed-off-by: Eric Biggers <ebiggers3@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 44 +++-----------------------------------------
>  1 file changed, 3 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e979ec7..3aa7b2b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -38,48 +38,10 @@ static inline bool policy_is_inactive(struct cpufreq_policy *policy)
>  	return cpumask_empty(policy->cpus);
>  }
>  
> -static bool suitable_policy(struct cpufreq_policy *policy, bool active)
> -{
> -	return active == !policy_is_inactive(policy);
> -}
> -
> -/* Finds Next Acive/Inactive policy */
> -static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
> -					  bool active)
> -{
> -	do {
> -		/* No more policies in the list */
> -		if (list_is_last(&policy->policy_list, &cpufreq_policy_list))
> -			return NULL;
> -
> -		policy = list_next_entry(policy, policy_list);
> -	} while (!suitable_policy(policy, active));
> -
> -	return policy;
> -}
> -
> -static struct cpufreq_policy *first_policy(bool active)
> -{
> -	struct cpufreq_policy *policy;
> -
> -	/* No policies in the list */
> -	if (list_empty(&cpufreq_policy_list))
> -		return NULL;
> -
> -	policy = list_first_entry(&cpufreq_policy_list, typeof(*policy),
> -				  policy_list);
> -
> -	if (!suitable_policy(policy, active))
> -		policy = next_policy(policy, active);
> -
> -	return policy;
> -}
> -
>  /* Macros to iterate over CPU policies */
> -#define for_each_suitable_policy(__policy, __active)	\
> -	for (__policy = first_policy(__active);		\
> -	     __policy;					\
> -	     __policy = next_policy(__policy, __active))
> +#define for_each_suitable_policy(__policy, __active)			 \
> +	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
> +		if ((__active) == !policy_is_inactive(__policy))
>  
>  #define for_each_active_policy(__policy)		\
>  	for_each_suitable_policy(__policy, true)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
