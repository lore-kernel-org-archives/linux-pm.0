From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating
 cpufreq table
Date: Tue, 25 Nov 2014 11:56:35 +0100
Message-ID: <20141125115635.14a3a900@amdc2363>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:65135 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666AbaKYK4n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 05:56:43 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NFL00JWVD2HFC70@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 25 Nov 2014 19:56:41 +0900 (KST)
In-reply-to: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, edubezval@gmail.com

Hi Viresh,

> of_cpufreq_cooling_register() can use frequency values from
> policy->min/max/cpuinfo.min_freq/cpuinfo.max_freq, which are
> available only after calling cpufreq_table_validate_and_show().
> 
> The right order of calling should be:
> cpufreq_table_validate_and_show() followed by
> of_cpufreq_cooling_register(). Fix it.
> 
> Reported-by: Lukasz Majewski <l.majewski@samsung.com>
> Reported-by: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> ---
> For 3.18.
> ---
>  drivers/cpufreq/cpufreq-dt.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c
> b/drivers/cpufreq/cpufreq-dt.c index 8cba13d..22eb6e5 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -186,7 +186,6 @@ static int cpufreq_init(struct cpufreq_policy
> *policy) {
>  	struct cpufreq_dt_platform_data *pd;
>  	struct cpufreq_frequency_table *freq_table;
> -	struct thermal_cooling_device *cdev;
>  	struct device_node *np;
>  	struct private_data *priv;
>  	struct device *cpu_dev;
> @@ -269,20 +268,6 @@ static int cpufreq_init(struct cpufreq_policy
> *policy) goto out_free_priv;
>  	}
>  
> -	/*
> -	 * For now, just loading the cooling device;
> -	 * thermal DT code takes care of matching them.
> -	 */
> -	if (of_find_property(np, "#cooling-cells", NULL)) {
> -		cdev = of_cpufreq_cooling_register(np,
> cpu_present_mask);
> -		if (IS_ERR(cdev))
> -			dev_err(cpu_dev,
> -				"running cpufreq without cooling
> device: %ld\n",
> -				PTR_ERR(cdev));
> -		else
> -			priv->cdev = cdev;
> -	}
> -
>  	priv->cpu_dev = cpu_dev;
>  	priv->cpu_reg = cpu_reg;
>  	policy->driver_data = priv;
> @@ -292,7 +277,22 @@ static int cpufreq_init(struct cpufreq_policy
> *policy) if (ret) {
>  		dev_err(cpu_dev, "%s: invalid frequency table:
> %d\n", __func__, ret);
> -		goto out_cooling_unregister;
> +		goto out_free_cpufreq_table;
> +	}
> +
> +	/*
> +	 * For now, just loading the cooling device;
> +	 * thermal DT code takes care of matching them.
> +	 */
> +	if (of_find_property(np, "#cooling-cells", NULL)) {
> +		priv->cdev = of_cpufreq_cooling_register(np,
> cpu_present_mask);
> +		if (IS_ERR(priv->cdev)) {
> +			dev_err(cpu_dev,
> +				"running cpufreq without cooling
> device: %ld\n",
> +				PTR_ERR(priv->cdev));
> +
> +			priv->cdev = NULL;
> +		}
>  	}
>  
>  	policy->cpuinfo.transition_latency = transition_latency;
> @@ -305,8 +305,7 @@ static int cpufreq_init(struct cpufreq_policy
> *policy) 
>  	return 0;
>  
> -out_cooling_unregister:
> -	cpufreq_cooling_unregister(priv->cdev);
> +out_free_cpufreq_table:
>  	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
>  out_free_priv:
>  	kfree(priv);

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
