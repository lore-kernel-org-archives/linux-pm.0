From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 02/13] thermal: qoriq: Add local struct device pointer
Date: Thu, 4 Apr 2019 05:11:42 +0200
Message-ID: <e748759e-66e6-4acc-ea23-1e337ed53535@linaro.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-3-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401041418.5999-3-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Use a local "struct device *dev" for brevity. No functional change
> intended.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  drivers/thermal/qoriq_thermal.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 7b364933bfb1..91f9f49d2776 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -192,8 +192,9 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	int ret;
>  	struct qoriq_tmu_data *data;
>  	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
>  
> -	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
> +	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
>  			    GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> @@ -204,7 +205,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  
>  	data->regs = of_iomap(np, 0);
>  	if (!data->regs) {
> -		dev_err(&pdev->dev, "Failed to get memory region\n");
> +		dev_err(dev, "Failed to get memory region\n");
>  		ret = -ENODEV;
>  		goto err_iomap;
>  	}
> @@ -217,7 +218,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  
>  	ret = qoriq_tmu_register_tmu_zone(pdev);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "Failed to register sensors\n");
> +		dev_err(dev, "Failed to register sensors\n");
>  		ret = -ENODEV;
>  		goto err_iomap;
>  	}
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
