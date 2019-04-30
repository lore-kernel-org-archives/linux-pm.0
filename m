From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 08/16] PM / devfreq: tegra: Clean up driver's probe /
 remove
Date: Tue, 30 Apr 2019 09:16:03 +0900
Message-ID: <236a553b-ccb5-f8fd-d404-af78f04d6985@samsung.com>
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224114epcas4p14b20e269f10a3e3bfea4c8ec4c3300b3@epcas4p1.samsung.com>
        <20190417222925.5815-9-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417222925.5815-9-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> Reset hardware, disable ACTMON clock, release OPP's and handle all
> possible error cases correctly, maintaining the correct tear down
> order. Also use devm_platform_ioremap_resource() which is now available
> in the kernel.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 83 +++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index ce1eb97a2090..70946e432d3c 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -610,7 +610,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  {
>  	struct tegra_devfreq *tegra;
>  	struct tegra_devfreq_device *dev;
> -	struct resource *res;
>  	unsigned int i;
>  	unsigned long rate;
>  	int err;
> @@ -619,9 +618,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	if (!tegra)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	tegra->regs = devm_ioremap_resource(&pdev->dev, res);
> +	tegra->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(tegra->regs))
>  		return PTR_ERR(tegra->regs);
>  
> @@ -643,11 +640,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		return PTR_ERR(tegra->emc_clock);
>  	}
>  
> -	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
> -	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
> -	if (err) {
> -		dev_err(&pdev->dev,
> -			"Failed to register rate change notifier\n");
> +	tegra->irq = platform_get_irq(pdev, 0);
> +	if (tegra->irq < 0) {
> +		err = tegra->irq;
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
>  		return err;
>  	}
>  
> @@ -678,54 +674,69 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
>  		rate = clk_round_rate(tegra->emc_clock, rate);
> -		dev_pm_opp_add(&pdev->dev, rate, 0);
> -	}
>  
> -	tegra->irq = platform_get_irq(pdev, 0);
> -	if (tegra->irq < 0) {
> -		err = tegra->irq;
> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> -		return err;
> +		err = dev_pm_opp_add(&pdev->dev, rate, 0);
> +		if (err) {
> +			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
> +			goto remove_opps;
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, tegra);
>  
> +	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
> +	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Failed to register rate change notifier\n");
> +		goto remove_opps;
> +	}
> +
> +	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
> +	tegra->devfreq = devfreq_add_device(&pdev->dev,
> +					    &tegra_devfreq_profile,
> +					    "tegra_actmon",
> +					    NULL);
> +	if (IS_ERR(tegra->devfreq)) {
> +		err = PTR_ERR(tegra->devfreq);
> +		goto unreg_notifier;
> +	}
> +
>  	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
>  					actmon_thread_isr, IRQF_ONESHOT,
>  					"tegra-devfreq", tegra);
>  	if (err) {
> -		dev_err(&pdev->dev, "Interrupt request failed\n");
> -		return err;
> +		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
> +		goto remove_devfreq;
>  	}
>  
> -	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
> -	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
> -						 &tegra_devfreq_profile,
> -						 "tegra_actmon",
> -						 NULL);
> -
>  	return 0;
> +
> +remove_devfreq:
> +	devfreq_remove_device(tegra->devfreq);
> +
> +unreg_notifier:
> +	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
> +
> +remove_opps:
> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> +
> +	reset_control_reset(tegra->reset);
> +	clk_disable_unprepare(tegra->clock);
> +
> +	return err;
>  }
>  
>  static int tegra_devfreq_remove(struct platform_device *pdev)
>  {
>  	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
> -	int irq = platform_get_irq(pdev, 0);
> -	u32 val;
> -	unsigned int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
> -		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
> -		val &= ~ACTMON_DEV_CTRL_ENB;
> -		device_writel(&tegra->devices[i], val, ACTMON_DEV_CTRL);
> -	}
> -
> -	actmon_write_barrier(tegra);
>  
> -	devm_free_irq(&pdev->dev, irq, tegra);
> +	devfreq_remove_device(tegra->devfreq);
> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>  
>  	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);

nitpick: the probe function  has following call sequence if error case,
First, clk_notifier_unregister()
Second, dev_pm_opp_remove_all_dynamic()

If possible, you better to keep the same sequence
in the tegra_devfreq_remove(). But, it is just opinion.
If you think that it doesn't break the routine of device removal,
jut keep this code.

>  
> +	reset_control_reset(tegra->reset);
>  	clk_disable_unprepare(tegra->clock);
>  
>  	return 0;
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
