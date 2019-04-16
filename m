From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 14/19] PM / devfreq: tegra: Move governor
 registration to driver's probe
Date: Tue, 16 Apr 2019 16:30:14 +0900
Message-ID: <cb398910-1137-dc6a-2609-0ac0ba580a6e@samsung.com>
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145727epcas1p4c97da1fb3e264bca828e982ef43c3fdf@epcas1p4.samsung.com>
        <20190415145505.18397-15-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-15-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
> There is no need to register the ACTMON's governor separately from
> the driver, hence let's move the registration into the driver's probe
> function for consistency and to make code cleaner a tad.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 44 +++++++++------------------------
>  1 file changed, 12 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 832e4f5aa11b..46c61af8ca33 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -673,6 +673,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, tegra);
>  
> +	err = devfreq_add_governor(&tegra_devfreq_governor);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
> +		goto remove_opps;
> +	}
> +
>  	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
>  	tegra->devfreq = devfreq_add_device(&pdev->dev,
>  					    &tegra_devfreq_profile,
> @@ -680,7 +686,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  					    NULL);
>  	if (IS_ERR(tegra->devfreq)) {
>  		err = PTR_ERR(tegra->devfreq);
> -		goto remove_opps;
> +		goto remove_governor;
>  	}
>  
>  	err = request_threaded_irq(irq, NULL, actmon_thread_isr, IRQF_ONESHOT,
> @@ -706,6 +712,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  remove_devfreq:
>  	devfreq_remove_device(tegra->devfreq);
>  
> +remove_governor:
> +	devfreq_remove_governor(&tegra_devfreq_governor);
> +
>  remove_opps:
>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>  
> @@ -729,7 +738,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>  	reset_control_reset(tegra->reset);
>  	clk_disable_unprepare(tegra->clock);
>  
> -	return 0;
> +	return devfreq_remove_governor(&tegra_devfreq_governor);
>  }
>  
>  static const struct of_device_id tegra_devfreq_of_match[] = {
> @@ -747,36 +756,7 @@ static struct platform_driver tegra_devfreq_driver = {
>  		.of_match_table = tegra_devfreq_of_match,
>  	},
>  };
> -
> -static int __init tegra_devfreq_init(void)
> -{
> -	int ret = 0;
> -
> -	ret = devfreq_add_governor(&tegra_devfreq_governor);
> -	if (ret) {
> -		pr_err("%s: failed to add governor: %d\n", __func__, ret);
> -		return ret;
> -	}
> -
> -	ret = platform_driver_register(&tegra_devfreq_driver);
> -	if (ret)
> -		devfreq_remove_governor(&tegra_devfreq_governor);
> -
> -	return ret;
> -}
> -module_init(tegra_devfreq_init)
> -
> -static void __exit tegra_devfreq_exit(void)
> -{
> -	int ret = 0;
> -
> -	platform_driver_unregister(&tegra_devfreq_driver);
> -
> -	ret = devfreq_remove_governor(&tegra_devfreq_governor);
> -	if (ret)
> -		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
> -}
> -module_exit(tegra_devfreq_exit)
> +module_platform_driver(tegra_devfreq_driver);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Tegra devfreq driver");
> 

Looks good to me.
Reviewed-by : Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
