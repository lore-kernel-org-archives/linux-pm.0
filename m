From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 8/8] PM / devfreq: exynos-bus: Register cooling
 device
Date: Thu, 21 Sep 2017 13:57:51 +0900
Message-ID: <59C346CF.6010105@samsung.com>
References: <1505954032-3327-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170921003356epcas1p34bf88ccd1b9630577a83f14f0c291b1d@epcas1p3.samsung.com>
        <1505954032-3327-9-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1505954032-3327-9-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dear all,

Please ignore this patch. It has some problem.
I'll fix and resend this patch on v2.

Chanwoo Choi
Samsung Electronics

On 2017년 09월 21일 09:33, Chanwoo Choi wrote:
> This patch registers the Exynos Bus-Frequency scaling device
> as a cooling device of thermal management.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/devfreq/Kconfig      |  1 +
>  drivers/devfreq/exynos-bus.c | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 6a172d338f6d..eb8128e08b2c 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -81,6 +81,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select DEVFREQ_GOV_PASSIVE
>  	select DEVFREQ_EVENT_EXYNOS_PPMU
> +	select DEVFREQ_THERMAL
>  	select PM_DEVFREQ_EVENT
>  	select PM_OPP
>  	help
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index c25658b26598..200ca0d11834 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -15,6 +15,7 @@
>  #include <linux/clk.h>
>  #include <linux/devfreq.h>
>  #include <linux/devfreq-event.h>
> +#include <linux/devfreq_cooling.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> @@ -41,6 +42,8 @@ struct exynos_bus {
>  	struct clk *clk;
>  	unsigned int voltage_tolerance;
>  	unsigned int ratio;
> +
> +	struct thermal_cooling_device *cdev;
>  };
>  
>  /*
> @@ -468,6 +471,14 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> +	/* Register devfreq cooling device */
> +	bus->cdev = of_devfreq_cooling_register(np, bus->devfreq);
> +	if (IS_ERR(bus->cdev) < 0) {
> +		dev_err(dev, "failed to register cooling device\n");
> +		ret = PTR_ERR(bus->cdev);
> +		goto err;
> +	}
> +
>  	goto out;
>  passive:
>  	/* Initialize the struct profile and governor data for passive device */
> 
