From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 17/18] thermal: exynos: remove unused defines for
 Exynos5433
Date: Tue, 1 May 2018 13:11:20 +0200
Message-ID: <20180501110434.GN27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115241epcas1p4472048bd1647d9151718f573e6f1025a@epcas1p4.samsung.com>
 <1524743493-28113-18-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524743493-28113-18-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:32PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Remove unused defines for Exynos5433.

I agree to remove these macros but is there a place with the documentation for
those values if we need to put them back ?
 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 9639acf..ed02b40 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -96,11 +96,6 @@
>  #define EXYNOS4412_MUX_ADDR_SHIFT          20
>  
>  /* Exynos5433 specific registers */
> -#define EXYNOS5433_TMU_REG_CONTROL1		0x024
> -#define EXYNOS5433_TMU_SAMPLING_INTERVAL	0x02c
> -#define EXYNOS5433_TMU_COUNTER_VALUE0		0x030
> -#define EXYNOS5433_TMU_COUNTER_VALUE1		0x034
> -#define EXYNOS5433_TMU_REG_CURRENT_TEMP1	0x044
>  #define EXYNOS5433_THD_TEMP_RISE3_0		0x050
>  #define EXYNOS5433_THD_TEMP_RISE7_4		0x054
>  #define EXYNOS5433_THD_TEMP_FALL3_0		0x060
> -- 
> 1.9.1
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
