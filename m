From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 07/12] thermal: qoriq: Convert driver to use
 devm_ioremap()
Date: Tue, 16 Apr 2019 18:52:38 +0200
Message-ID: <0d8055cb-61d8-ba45-4b21-6dd4d82584d9@linaro.org>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-8-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190413082748.29990-8-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
> Convert driver to use devm_ioremap() to simplify memory deallocation
> and error handling code. No functional change intended.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/qoriq_thermal.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 0b6937bbc7d0..64cad6d4c1d7 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -175,6 +175,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	struct qoriq_tmu_data *data;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device *dev = &pdev->dev;
> +	struct resource *io;
>  
>  	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
>  			    GFP_KERNEL);
> @@ -183,7 +184,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  
>  	data->little_endian = of_property_read_bool(np, "little-endian");
>  
> -	data->regs = of_iomap(np, 0);
> +	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!io) {
> +		dev_err(dev, "Failed to get memory region\n");
> +		return -ENODEV;
> +	}
> +
> +	data->regs = devm_ioremap(dev, io->start, resource_size(io));
>  	if (!data->regs) {
>  		dev_err(dev, "Failed to get memory region\n");
>  		return -ENODEV;
> @@ -193,23 +200,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  
>  	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
>  	if (ret < 0)
> -		goto err_tmu;
> +		return ret;
>  
>  	ret = qoriq_tmu_register_tmu_zone(dev, data);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to register sensors\n");
> -		ret = -ENODEV;
> -		goto err_tmu;
> +		return -ENODEV;
>  	}
>  
>  	platform_set_drvdata(pdev, data);
>  
>  	return 0;
> -
> -err_tmu:
> -	iounmap(data->regs);
> -
> -	return ret;
>  }
>  
>  static int qoriq_tmu_remove(struct platform_device *pdev)
> @@ -219,7 +220,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
>  	/* Disable monitoring */
>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
>  
> -	iounmap(data->regs);
>  	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
