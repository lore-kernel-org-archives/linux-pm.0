From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: exynos: Reduce severity of too early
 temperature read
Date: Mon, 14 May 2018 18:48:58 +0200
Message-ID: <5680419.dyeeL7KHIb@amdc3058>
References: <CGME20180513175436epcas1p1475e12e647ec135d0fedd29e5992c152@epcas1p1.samsung.com>
        <20180513175402.28887-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180513175402.28887-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, May 13, 2018 07:54:02 PM Krzysztof Kozlowski wrote:
> Thermal core tries to read temperature during sensor registering in
> thermal_zone_of_sensor_register().  In that time Exynos TMU driver and
> hardware are not yet initialized.  Commit 0eb875d88aaa ("thermal:
> exynos: Reading temperature makes sense only when TMU is turned on")
> added a boolean flag to prevent reading bogus temperature in such
> case but it exposed warning message during boot:
> 	[    3.864913] thermal thermal_zone0: failed to read out thermal zone (-22)
> 
> Return EAGAIN in such case to skip omitting such message because it
> might mislead user.

Hi Krzysztof,

I've fixed this in generic way a month ago:

	https://lkml.org/lkml/2018/4/10/376

(there has been not much feedback on it yet)

However since my patchset is not v4.17 material:

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Eduardo, please queue it for v4.17 if possible, thanks.

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 3b20309789e3..c24969d740d1 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -666,8 +666,14 @@ static int exynos_get_temp(void *p, int *temp)
>  	struct exynos_tmu_data *data = p;
>  	int value, ret = 0;
>  
> -	if (!data || !data->tmu_read || !data->enabled)
> +	if (!data || !data->tmu_read)
>  		return -EINVAL;
> +	else if (!data->enabled)
> +		/*
> +		 * Called too early, probably
> +		 * from thermal_zone_of_sensor_register().
> +		 */
> +		return -EAGAIN;
>  
>  	mutex_lock(&data->lock);
>  	clk_enable(data->clk);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
