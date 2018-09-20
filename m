From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 08/12] cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
Date: Thu, 20 Sep 2018 09:59:25 +0200
Message-ID: <1645527.R4f0u0jryK@aspire.rjw.lan>
References: <cover.1537394233.git.viresh.kumar@linaro.org> <883071c4bd9a6e45bf0b5e45575d110eaeb2e6d0.1537394233.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <883071c4bd9a6e45bf0b5e45575d110eaeb2e6d0.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, September 20, 2018 12:20:27 AM CEST Viresh Kumar wrote:
> dev_pm_opp_cpumask_remove_table() is going to change in the next commit
> and will not remove dynamic OPPs automatically. They must be removed
> with a call to dev_pm_opp_remove().
> 
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/mvebu-cpufreq.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
> index 31513bd42705..6d33a639f902 100644
> --- a/drivers/cpufreq/mvebu-cpufreq.c
> +++ b/drivers/cpufreq/mvebu-cpufreq.c
> @@ -84,9 +84,10 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  
>  		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
>  		if (ret) {
> +			dev_pm_opp_remove(cpu_dev, clk_get_rate(clk));
>  			clk_put(clk);
>  			dev_err(cpu_dev, "Failed to register OPPs\n");
> -			goto opp_register_failed;
> +			return ret;
>  		}
>  
>  		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
> @@ -99,11 +100,5 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  
>  	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>  	return 0;
> -
> -opp_register_failed:
> -	/* As registering has failed remove all the opp for all cpus */
> -	dev_pm_opp_cpumask_remove_table(cpu_possible_mask);
> -
> -	return ret;
>  }
>  device_initcall(armada_xp_pmsu_cpufreq_init);
> 

Please feel free to take this one via OPP.
