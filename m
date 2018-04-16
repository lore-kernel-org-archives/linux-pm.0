From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 12/14] thermal: exynos: remove separate exynos_tmu.h
 header file
Date: Mon, 16 Apr 2018 15:24:57 +0200
Message-ID: <fa04dbd9-fdb4-26e4-ac1d-2aa3a5840465@linaro.org>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101422epcas2p34c80b64c6c762b98ae4fecfe6a4db4f8@epcas2p3.samsung.com>
 <1523873525-23718-13-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523873525-23718-13-git-send-email-b.zolnierkie@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16/04/2018 12:12, Bartlomiej Zolnierkiewicz wrote:
> exynos_tmu.h is used only by exynos_tmu.c so there is no need
> for a separate include file.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 18 +++++++++++++++-
>  drivers/thermal/samsung/exynos_tmu.h | 41 ------------------------------------
>  2 files changed, 17 insertions(+), 42 deletions(-)
>  delete mode 100644 drivers/thermal/samsung/exynos_tmu.h
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 7975f33..197f267 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -34,8 +34,10 @@
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/cpu_cooling.h>
> +

This one should go away, no ?

Apart this.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
