From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 07/12] PM / OPP: Update OPP users to put reference
Date: Wed, 07 Dec 2016 22:23:53 +0900
Message-ID: <58480D69.9030801@samsung.com>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <CGME20161207104429epcas4p1ceff82170121e22ab2a14715fa80050a@epcas4p1.samsung.com>
 <059cb0d754593a1bbe82e67990729678ce8cef78.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58705 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbcLGNX4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 08:23:56 -0500
In-reply-to: <059cb0d754593a1bbe82e67990729678ce8cef78.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

Hi Viresh,

[snip]

> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b0de42972b74..89add0d7c017 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -111,18 +111,16 @@ static void devfreq_set_freq_table(struct devfreq *devfreq)
>  		return;
>  	}
>  
> -	rcu_read_lock();
>  	for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
>  		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
> +		dev_pm_opp_put(opp);

I think that the dev_pm_opp_put(opp) should be called after if statement
If dev_pm_opp_find_freq_ceil() return error, I think the calling of
dev_pm_opp_put(opp) is not necessary.

>  		if (IS_ERR(opp)) {
>  			devm_kfree(devfreq->dev.parent, profile->freq_table);
>  			profile->max_state = 0;
> -			rcu_read_unlock();
>  			return;
>  		}
>  		profile->freq_table[i] = freq;
>  	}
> -	rcu_read_unlock();
>  }
>  
>  /**
> @@ -1107,9 +1105,9 @@ static ssize_t available_frequencies_show(struct device *d,
>  	ssize_t count = 0;
>  	unsigned long freq = 0;
>  
> -	rcu_read_lock();
>  	do {
>  		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> +		dev_pm_opp_put(opp);

ditto.

>  		if (IS_ERR(opp))
>  			break;
>  
> @@ -1117,7 +1115,6 @@ static ssize_t available_frequencies_show(struct device *d,
>  				   "%lu ", freq);
>  		freq++;
>  	} while (1);
> -	rcu_read_unlock();
>  
>  	/* Truncate the trailing space */
>  	if (count)
> @@ -1219,11 +1216,8 @@ subsys_initcall(devfreq_init);
>   * @freq:	The frequency given to target function
>   * @flags:	Flags handed from devfreq framework.
>   *
> - * Locking: This function must be called under rcu_read_lock(). opp is a rcu
> - * protected pointer. The reason for the same is that the opp pointer which is
> - * returned will remain valid for use with opp_get_{voltage, freq} only while
> - * under the locked area. The pointer returned must be used prior to unlocking
> - * with rcu_read_unlock() to maintain the integrity of the pointer.
> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> + * use.
>   */
>  struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>  					   unsigned long *freq,
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index a8ed7792ece2..49ce38cef460 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -103,18 +103,17 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>  	int ret = 0;
>  
>  	/* Get new opp-bus instance according to new bus clock */
> -	rcu_read_lock();
>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(new_opp)) {
>  		dev_err(dev, "failed to get recommended opp instance\n");
> -		rcu_read_unlock();
>  		return PTR_ERR(new_opp);
>  	}
>  
>  	new_freq = dev_pm_opp_get_freq(new_opp);
>  	new_volt = dev_pm_opp_get_voltage(new_opp);
> +	dev_pm_opp_put(new_opp);
> +
>  	old_freq = bus->curr_freq;
> -	rcu_read_unlock();
>  
>  	if (old_freq == new_freq)
>  		return 0;
> @@ -214,17 +213,16 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
>  	int ret = 0;
>  
>  	/* Get new opp-bus instance according to new bus clock */
> -	rcu_read_lock();
>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(new_opp)) {
>  		dev_err(dev, "failed to get recommended opp instance\n");
> -		rcu_read_unlock();
>  		return PTR_ERR(new_opp);
>  	}
>  
>  	new_freq = dev_pm_opp_get_freq(new_opp);
> +	dev_pm_opp_put(new_opp);
> +
>  	old_freq = bus->curr_freq;
> -	rcu_read_unlock();
>  
>  	if (old_freq == new_freq)
>  		return 0;
> @@ -358,16 +356,14 @@ static int exynos_bus_parse_of(struct device_node *np,
>  
>  	rate = clk_get_rate(bus->clk);
>  
> -	rcu_read_lock();
>  	opp = devfreq_recommended_opp(dev, &rate, 0);
>  	if (IS_ERR(opp)) {
>  		dev_err(dev, "failed to find dev_pm_opp\n");
> -		rcu_read_unlock();
>  		ret = PTR_ERR(opp);
>  		goto err_opp;
>  	}
>  	bus->curr_freq = dev_pm_opp_get_freq(opp);
> -	rcu_read_unlock();
> +	dev_pm_opp_put(opp);
>  
>  	return 0;
>  
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 9ef46e2592c4..671a1e0afc6e 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -59,9 +59,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	 * list of parent device. Because in this case, *freq is temporary
>  	 * value which is decided by ondemand governor.
>  	 */
> -	rcu_read_lock();
>  	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> -	rcu_read_unlock();
> +	dev_pm_opp_put(opp);

ditto.

> +
>  	if (IS_ERR(opp)) {
>  		ret = PTR_ERR(opp);
>  		goto out;
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 27d2f349b53c..40a2499730fc 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -91,17 +91,13 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  	unsigned long target_volt, target_rate;
>  	int err;
>  
> -	rcu_read_lock();
>  	opp = devfreq_recommended_opp(dev, freq, flags);
> -	if (IS_ERR(opp)) {
> -		rcu_read_unlock();
> +	if (IS_ERR(opp))
>  		return PTR_ERR(opp);
> -	}
>  
>  	target_rate = dev_pm_opp_get_freq(opp);
>  	target_volt = dev_pm_opp_get_voltage(opp);
> -
> -	rcu_read_unlock();
> +	dev_pm_opp_put(opp);
>  
>  	if (dmcfreq->rate == target_rate)
>  		return 0;
> @@ -422,15 +418,13 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  
>  	data->rate = clk_get_rate(data->dmc_clk);
>  
> -	rcu_read_lock();
>  	opp = devfreq_recommended_opp(dev, &data->rate, 0);
> -	if (IS_ERR(opp)) {
> -		rcu_read_unlock();
> +	if (IS_ERR(opp))
>  		return PTR_ERR(opp);
> -	}
> +
>  	data->rate = dev_pm_opp_get_freq(opp);
>  	data->volt = dev_pm_opp_get_voltage(opp);
> -	rcu_read_unlock();
> +	dev_pm_opp_put(opp);
>  
>  	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
>  
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index fe9dce0245bf..214fff96fa4a 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -487,15 +487,13 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  	struct dev_pm_opp *opp;
>  	unsigned long rate = *freq * KHZ;
>  
> -	rcu_read_lock();
>  	opp = devfreq_recommended_opp(dev, &rate, flags);
>  	if (IS_ERR(opp)) {
> -		rcu_read_unlock();
>  		dev_err(dev, "Failed to find opp for %lu KHz\n", *freq);
>  		return PTR_ERR(opp);
>  	}
>  	rate = dev_pm_opp_get_freq(opp);
> -	rcu_read_unlock();
> +	dev_pm_opp_put(opp);
>  
>  	clk_set_min_rate(tegra->emc_clock, rate);
>  	clk_set_rate(tegra->emc_clock, 0);

[snip]

Best Regards,
Chanwoo Choi
