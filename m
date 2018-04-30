From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 01/18] thermal: exynos: fix setting rising_threshold for
 Exynos5433
Date: Mon, 30 Apr 2018 16:36:56 +0200
Message-ID: <20180430143656.GH11457@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115201epcas2p17e5cdb0f79927903880e58c290b663e6@epcas2p1.samsung.com>
 <1524743493-28113-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524743493-28113-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:16PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Add missing clearing of the previous value when setting rising
> temperature threshold.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index cda716c..523d26e 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -577,6 +577,7 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
>  		threshold_code = temp_to_code(data, temp);
>  
>  		rising_threshold = readl(data->base + rising_reg_offset);
> +		rising_threshold &= ~(0xff << j * 8);
>  		rising_threshold |= (threshold_code << j * 8);

Bartlomiej,

I see this code is duplicated all around the driver, so I can't blame you to
fix it in the same way it is written today but this is not how to deal with
fields in a register mapping. Can you fix it by adding correct macros with
masks?

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
