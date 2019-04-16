From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 15/19] PM / devfreq: tegra: Synchronize IRQ after
 masking it in hardware
Date: Tue, 16 Apr 2019 16:41:10 +0900
Message-ID: <81db3a75-2d17-5268-fea5-8b6ed650056f@samsung.com>
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145717epcas4p1647551d3a4c7bb2a0d9698707fa03f43@epcas4p1.samsung.com>
        <20190415145505.18397-16-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-16-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

In this patchset,
the patch11 adds new 'disable_interrupt' goto statement
and then patch15 removes 'disable_interrupt' goto statement again.
Actually, it is inefficient.

If you change the order of patches,
you could remove this stuff.

On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
> There is no guarantee that interrupt handling isn't running in parallel,
> hence it is necessary to synchronize IRQ in order to ensure that interrupt
> is indeed disabled.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 46c61af8ca33..cfbfbe28e7bf 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -171,6 +171,8 @@ struct tegra_devfreq {
>  	struct notifier_block	rate_change_nb;
>  
>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
> +
> +	int irq;
>  };
>  
>  struct tegra_actmon_emc_ratio {
> @@ -432,6 +434,8 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>  	}
>  
>  	actmon_write_barrier(tegra);
> +
> +	synchronize_irq(tegra->irq);
>  }
>  
>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
> @@ -603,7 +607,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	unsigned int i;
>  	unsigned long rate;
> -	int irq;
>  	int err;
>  
>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> @@ -659,18 +662,18 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		tegra_actmon_configure_device(tegra, dev);
>  	}
>  
> +	tegra->irq = platform_get_irq(pdev, 0);
> +	if (tegra->irq < 0) {
> +		err = tegra->irq;
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> +		return err;
> +	}
> +
>  	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
>  		rate = clk_round_rate(tegra->emc_clock, rate);
>  		dev_pm_opp_add(&pdev->dev, rate, 0);
>  	}
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		err = irq;
> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> -		goto remove_opps;
> -	}
> -
>  	platform_set_drvdata(pdev, tegra);
>  
>  	err = devfreq_add_governor(&tegra_devfreq_governor);
> @@ -689,10 +692,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		goto remove_governor;
>  	}
>  
> -	err = request_threaded_irq(irq, NULL, actmon_thread_isr, IRQF_ONESHOT,
> -				   "tegra-devfreq", tegra);
> +	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
> +					actmon_thread_isr, IRQF_ONESHOT,
> +					"tegra-devfreq", tegra);
>  	if (err) {
> -		dev_err(&pdev->dev, "Interrupt request failed\n");
> +		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
>  		goto remove_devfreq;
>  	}
>  
> @@ -701,14 +705,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	if (err) {
>  		dev_err(&pdev->dev,
>  			"Failed to register rate change notifier\n");
> -		goto disable_interrupt;
> +		goto remove_devfreq;
>  	}
>  
>  	return 0;
>  
> -disable_interrupt:
> -	free_irq(irq, tegra);
> -
>  remove_devfreq:
>  	devfreq_remove_device(tegra->devfreq);
>  
> @@ -727,10 +728,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  static int tegra_devfreq_remove(struct platform_device *pdev)
>  {
>  	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
> -	int irq = platform_get_irq(pdev, 0);
>  
>  	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
> -	free_irq(irq, tegra);
>  
>  	devfreq_remove_device(tegra->devfreq);
>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
