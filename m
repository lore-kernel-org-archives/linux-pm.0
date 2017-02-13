From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: exynos: Remove parsing unused
 samsung,tmu_cal_mode property
Date: Mon, 13 Feb 2017 17:21:57 +0100
Message-ID: <2102886.NukhHEJKXL@amdc3058>
References: <CGME20170211201214epcas4p19f97c2392bf0af211a0de6b0639dfe88@epcas4p1.samsung.com>
 <20170211201200.27616-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170211201200.27616-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, February 11, 2017 10:12:00 PM Krzysztof Kozlowski wrote:
> The property samsung,tmu_cal_mode is not used and not used.  We can
> safely remove it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 1 -
>  drivers/thermal/samsung/exynos_tmu.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index ad1186dd6132..7b8ef09d2b3c 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1168,7 +1168,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
>  	pdata->default_temp_offset = (u8)value;
>  
>  	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
> -	of_property_read_u32(np, "samsung,tmu_cal_mode", &pdata->cal_mode);
>  
>  	of_node_put(np);
>  	return 0;
> diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
> index 440c7140b660..5149c2a3030c 100644
> --- a/drivers/thermal/samsung/exynos_tmu.h
> +++ b/drivers/thermal/samsung/exynos_tmu.h
> @@ -70,7 +70,6 @@ struct exynos_tmu_platform_data {
>  
>  	enum soc_type type;
>  	u32 cal_type;
> -	u32 cal_mode;
>  };
>  
>  #endif /* _EXYNOS_TMU_H */
