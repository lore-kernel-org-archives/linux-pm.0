From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Sun, 01 Sep 2013 15:28:44 +0200
Message-ID: <11222156.oKTjYXFZjG@vostro.rjw.lan>
References: <085013f4e584e3fef97187bcb349c3fa76942e19.1378012620.git.viresh.kumar@linaro.org> <80c4bd8c577e5da0aa63342671773be5cdc26a9a.1378012620.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:49729 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753410Ab3IANRz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 1 Sep 2013 09:17:55 -0400
In-Reply-To: <80c4bd8c577e5da0aa63342671773be5cdc26a9a.1378012620.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday, September 01, 2013 10:56:02 AM Viresh Kumar wrote:
> We can't take a big lock around __cpufreq_governor() as this causes recursive
> locking for some cases. But calls to this routine must be serialized for every
> policy.

Care to explain here why it must be serialized?

> Lets introduce another variable which would guarantee serialization here.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 7 ++++++-
>  include/linux/cpufreq.h   | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f320a20..4d5723db 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1692,13 +1692,15 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  						policy->cpu, event);
>  
>  	mutex_lock(&cpufreq_governor_lock);
> -	if ((policy->governor_enabled && (event == CPUFREQ_GOV_START)) ||
> +	if (policy->governor_busy ||
> +		(policy->governor_enabled && (event == CPUFREQ_GOV_START)) ||

Again, broken white space, but I can fix it up.

>  		(!policy->governor_enabled && ((event == CPUFREQ_GOV_LIMITS) ||
>  					       (event == CPUFREQ_GOV_STOP)))) {
>  		mutex_unlock(&cpufreq_governor_lock);
>  		return -EBUSY;
>  	}
>  
> +	policy->governor_busy = true;
>  	if (event == CPUFREQ_GOV_STOP)
>  		policy->governor_enabled = false;
>  	else if (event == CPUFREQ_GOV_START)
> @@ -1727,6 +1729,9 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  			((event == CPUFREQ_GOV_POLICY_EXIT) && !ret))
>  		module_put(policy->governor->owner);
>  
> +	mutex_lock(&cpufreq_governor_lock);
> +	policy->governor_busy = false;
> +	mutex_unlock(&cpufreq_governor_lock);
>  	return ret;
>  }
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d568f39..cca885d 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -76,6 +76,7 @@ struct cpufreq_policy {
>  	struct cpufreq_governor	*governor; /* see below */
>  	void			*governor_data;
>  	bool			governor_enabled; /* governor start/stop flag */
> +	bool			governor_busy;
>  
>  	struct work_struct	update; /* if update_policy() needs to be
>  					 * called, but you're in IRQ context */
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
