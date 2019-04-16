From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 06/12] thermal: qoriq: Pass data to
 qoriq_tmu_calibration() directly
Date: Tue, 16 Apr 2019 18:51:50 +0200
Message-ID: <74c4f677-c586-45de-3a38-feb627757193@linaro.org>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-7-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190413082748.29990-7-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
> We can simplify error cleanup code if instead of passing a "struct
> platform_device *" to qoriq_tmu_calibration() and deriving a bunch of
> pointers from it, we pass those pointers directly. This way we won't
> be force to call platform_set_drvdata() as early in qoriq_tmu_probe()
> and consequently would be able to drop the "err_iomap" error path.
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
>  drivers/thermal/qoriq_thermal.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 3419505a2f0a..0b6937bbc7d0 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -122,16 +122,16 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
>  	return 0;
>  }
>  
> -static int qoriq_tmu_calibration(struct platform_device *pdev)
> +static int qoriq_tmu_calibration(struct device *dev,
> +				 struct qoriq_tmu_data *data)
>  {
>  	int i, val, len;
>  	u32 range[4];
>  	const u32 *calibration;
> -	struct device_node *np = pdev->dev.of_node;
> -	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
> +	struct device_node *np = dev->of_node;
>  
>  	if (of_property_read_u32_array(np, "fsl,tmu-range", range, 4)) {
> -		dev_err(&pdev->dev, "missing calibration range.\n");
> +		dev_err(dev, "missing calibration range.\n");
>  		return -ENODEV;
>  	}
>  
> @@ -143,7 +143,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
>  
>  	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
>  	if (calibration == NULL || len % 8) {
> -		dev_err(&pdev->dev, "invalid calibration data.\n");
> +		dev_err(dev, "invalid calibration data.\n");
>  		return -ENODEV;
>  	}
>  
> @@ -181,20 +181,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, data);
> -
>  	data->little_endian = of_property_read_bool(np, "little-endian");
>  
>  	data->regs = of_iomap(np, 0);
>  	if (!data->regs) {
>  		dev_err(dev, "Failed to get memory region\n");
> -		ret = -ENODEV;
> -		goto err_iomap;
> +		return -ENODEV;
>  	}
>  
>  	qoriq_tmu_init_device(data);	/* TMU initialization */
>  
> -	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
> +	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
>  	if (ret < 0)
>  		goto err_tmu;
>  
> @@ -202,17 +199,16 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to register sensors\n");
>  		ret = -ENODEV;
> -		goto err_iomap;
> +		goto err_tmu;
>  	}
>  
> +	platform_set_drvdata(pdev, data);
> +
>  	return 0;
>  
>  err_tmu:
>  	iounmap(data->regs);
>  
> -err_iomap:
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return ret;
>  }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
