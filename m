From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 07/16] PM / devfreq: tegra: Properly disable
 interrupts
Date: Tue, 30 Apr 2019 09:05:45 +0900
Message-ID: <87b5a3df-a0c2-3a6e-7e93-f1c89b0a789e@samsung.com>
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224252epcas5p43248bf8dbebdf687c466d6985233c4e8@epcas5p4.samsung.com>
        <20190417222925.5815-8-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417222925.5815-8-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> There is no guarantee that interrupt handling isn't running in parallel
> with tegra_actmon_disable_interrupts(), hence it is necessary to protect
> DEV_CTRL register accesses and clear IRQ status with ACTMON's IRQ being
> disabled in the Interrupt Controller in order to ensure that device
> interrupt is indeed being disabled.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index b65313fe3c2e..ce1eb97a2090 100644
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
> @@ -417,6 +419,8 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>  	u32 val;
>  	unsigned int i;
>  
> +	disable_irq(tegra->irq);
> +
>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>  		dev = &tegra->devices[i];
>  
> @@ -427,9 +431,14 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>  		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>  
>  		device_writel(dev, val, ACTMON_DEV_CTRL);
> +
> +		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
> +			      ACTMON_DEV_INTR_STATUS);
>  	}
>  
>  	actmon_write_barrier(tegra);
> +
> +	enable_irq(tegra->irq);
>  }
>  
>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
> @@ -604,7 +613,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	unsigned int i;
>  	unsigned long rate;
> -	int irq;
>  	int err;
>  
>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> @@ -673,15 +681,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		dev_pm_opp_add(&pdev->dev, rate, 0);
>  	}
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> -		return irq;
> +	tegra->irq = platform_get_irq(pdev, 0);
> +	if (tegra->irq < 0) {
> +		err = tegra->irq;
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> +		return err;
>  	}
>  
>  	platform_set_drvdata(pdev, tegra);
>  
> -	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
>  					actmon_thread_isr, IRQF_ONESHOT,
>  					"tegra-devfreq", tegra);
>  	if (err) {
> 

It is ok to disable the hardware interrupt line
before completing the some operation about registers
in order to protect the interrupt occur.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
