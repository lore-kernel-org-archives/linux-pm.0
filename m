From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: conservative: Decrease frequency faster when
 the update deferred
Date: Mon, 14 Nov 2016 12:34:02 +0530
Message-ID: <20161114070402.GC4178@vireshk-i7>
References: <691e286d-249b-e450-2df1-8421d83e6a46@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34617 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932656AbcKNHEF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 02:04:05 -0500
Received: by mail-pf0-f181.google.com with SMTP id c4so16019512pfb.1
        for <linux-pm@vger.kernel.org>; Sun, 13 Nov 2016 23:04:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <691e286d-249b-e450-2df1-8421d83e6a46@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 12-11-16, 23:04, Stratos Karafotis wrote:
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index fa5ece3..d787772 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -73,7 +73,19 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>  	 */
>  	if (cs_tuners->freq_step == 0)
>  		goto out;
> -
> +	/*
> +	 * Decrease requested_freq for each idle period that we didn't
> +	 * update the frequency

Add a full stop (.) here.

> +	 */

I am wondering if we should be adding this code after the below 'if' block where
we check if the policy->min/max have changed ?

> +	if (policy_dbs->idle_periods < UINT_MAX) {
> +		unsigned int freq_target = policy_dbs->idle_periods *
> +				get_freq_target(cs_tuners, policy);

I get confused every time I look at this routine (get_freq_target()). I have
sent an update to this file just now to get that fixed. If Rafael applies that
one, please rebase over it.

> +		if (requested_freq > freq_target)
> +			requested_freq -= freq_target;
> +		else
> +			requested_freq = policy->min;
> +		policy_dbs->idle_periods = UINT_MAX;
> +	}

Need a blank line here.

-- 
viresh
