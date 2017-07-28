From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 04/10] cpufreq: dt: invoke frequency-invariance setter
 function
Date: Fri, 28 Jul 2017 13:55:37 +0530
Message-ID: <20170728082537.GB352@vireshk-i7>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
 <20170727193312.9849-5-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33538 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbdG1IZk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2017 04:25:40 -0400
Received: by mail-pg0-f49.google.com with SMTP id c14so15890867pgn.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Jul 2017 01:25:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170727193312.9849-5-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>

On 27-07-17, 20:33, Dietmar Eggemann wrote:
> Call the frequency-invariance setter function arch_set_freq_scale()
> if the new frequency has been successfully set which is indicated by
> dev_pm_opp_set_rate() returning 0.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index fef3c2160691..cbac8a7dbc50 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -43,9 +43,17 @@ static struct freq_attr *cpufreq_dt_attr[] = {
>  static int set_target(struct cpufreq_policy *policy, unsigned int index)
>  {
>  	struct private_data *priv = policy->driver_data;
> +	unsigned long freq = policy->freq_table[index].frequency;
> +	int ret;
> +
> +	ret = dev_pm_opp_set_rate(priv->cpu_dev, freq * 1000);
>  
> -	return dev_pm_opp_set_rate(priv->cpu_dev,
> -				   policy->freq_table[index].frequency * 1000);
> +	if (!ret) {
> +		arch_set_freq_scale(policy->related_cpus, freq,
> +				    policy->cpuinfo.max_freq);
> +	}
> +
> +	return ret;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
