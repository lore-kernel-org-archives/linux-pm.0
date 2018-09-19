From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 07/11] cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
Date: Wed, 19 Sep 2018 17:20:16 +0200
Message-ID: <87o9ctjyz3.fsf@bootlin.com>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
        <b6e58baec5ee4cf56f82c4b14dad7320cf01ce7f.1536736872.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b6e58baec5ee4cf56f82c4b14dad7320cf01ce7f.1536736872.git.viresh.kumar@linaro.org>
        (Viresh Kumar's message of "Wed, 12 Sep 2018 13:58:46 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: niklas.cassel@linaro.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,
 
 On mer., sept. 12 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> dev_pm_opp_cpumask_remove_table() is going to change in the next commit
> and will not remove dynamic OPPs automatically. They must be removed
> with a call to dev_pm_opp_remove().

So now that mean when adding more than 2 OPPs, we should have the list
of them available in the driver to be able to remove them, right?

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Gregory

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
> -- 
> 2.18.0.rc1.242.g61856ae69a2c
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
