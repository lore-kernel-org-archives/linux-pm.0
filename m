From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: mvebu: Free opp if registering failed
Date: Thu, 14 Dec 2017 08:29:32 +0530
Message-ID: <20171214025932.GP3322@vireshk-i7>
References: <20171213172914.6148-1-gregory.clement@free-electrons.com>
 <20171213172914.6148-3-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41497 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbdLNC7g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 21:59:36 -0500
Received: by mail-pg0-f67.google.com with SMTP id o2so2501753pgc.8
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 18:59:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171213172914.6148-3-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>

On 13-12-17, 18:29, Gregory CLEMENT wrote:
> Since the introduction of this driver, the functions to remove the opp
> were added. So stop claiming we can't remove opp and use one of them in
> case of failure.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/cpufreq/mvebu-cpufreq.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
> index c043aad8e3a0..31513bd42705 100644
> --- a/drivers/cpufreq/mvebu-cpufreq.c
> +++ b/drivers/cpufreq/mvebu-cpufreq.c
> @@ -76,12 +76,6 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  			return PTR_ERR(clk);
>  		}
>  
> -		/*
> -		 * In case of a failure of dev_pm_opp_add(), we don't
> -		 * bother with cleaning up the registered OPP (there's
> -		 * no function to do so), and simply cancel the
> -		 * registration of the cpufreq device.
> -		 */
>  		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk), 0);
>  		if (ret) {
>  			clk_put(clk);
> @@ -91,7 +85,8 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
>  		if (ret) {
>  			clk_put(clk);
> -			return ret;
> +			dev_err(cpu_dev, "Failed to register OPPs\n");
> +			goto opp_register_failed;
>  		}
>  
>  		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
> @@ -104,5 +99,11 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  
>  	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>  	return 0;
> +
> +opp_register_failed:
> +	/* As registering has failed remove all the opp for all cpus */
> +	dev_pm_opp_cpumask_remove_table(cpu_possible_mask);
> +
> +	return ret;
>  }
>  device_initcall(armada_xp_pmsu_cpufreq_init);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
