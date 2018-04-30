From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 07/18] thermal: exynos: remove threshold_code checking
 from exynos4210_tmu_initialize()
Date: Mon, 30 Apr 2018 17:37:03 +0200
Message-ID: <20180430153703.GC27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115216epcas1p3ed61f0fd8563e7ea72f3d7d17c9c039f@epcas1p3.samsung.com>
 <1524743493-28113-8-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524743493-28113-8-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:22PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Exynos4210 one-point trimming is always used and data->temp_error1
> is equal to 75. Therefore temp_to_code() will never return negative
> value for the reference temperature conversion.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 6 +-----
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
