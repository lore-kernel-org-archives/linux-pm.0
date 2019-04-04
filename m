From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 01/13] thermal: qoriq: Remove unnecessary DT node is
 NULL check
Date: Thu, 4 Apr 2019 05:21:15 +0200
Message-ID: <22f0c6d4-842e-bb91-a684-6edb6345e036@linaro.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-2-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401041418.5999-2-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> This driver is meant to be used with Device Tree and there's no
> use-case where device's DT node is going to be NULL. Remove code
> protecting against that.

May be elaborate why is never going to be NULL?

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

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/qoriq_thermal.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 3b5f5b3fb1bc..7b364933bfb1 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -193,11 +193,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	struct qoriq_tmu_data *data;
>  	struct device_node *np = pdev->dev.of_node;
>  
> -	if (!np) {
> -		dev_err(&pdev->dev, "Device OF-Node is NULL");
> -		return -ENODEV;
> -	}
> -
>  	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
>  			    GFP_KERNEL);
>  	if (!data)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
