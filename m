From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 2/2] Thermal: exynos: Add compatible string for exynos4412
Date: Mon, 22 Apr 2013 14:27:13 -0400
Message-ID: <51758101.8040507@ti.com>
References: <1366285079-10395-1-git-send-email-sachin.kamat@linaro.org> <1366285079-10395-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44176 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542Ab3DVS1b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Apr 2013 14:27:31 -0400
In-Reply-To: <1366285079-10395-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com, kgene.kim@samsung.com, patches@linaro.org, Amit Daniel Kachhap <amit.daniel@samsung.com>

Rui,

On 18-04-2013 07:37, Sachin Kamat wrote:
> Added compatible string for Exynos4412 SoC.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>

Please add my acked for this patch:

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>   drivers/thermal/exynos_thermal.c |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
> index 9df96e5..d20ce9e 100644
> --- a/drivers/thermal/exynos_thermal.c
> +++ b/drivers/thermal/exynos_thermal.c
> @@ -855,6 +855,10 @@ static const struct of_device_id exynos_tmu_match[] = {
>   		.data = (void *)EXYNOS4210_TMU_DRV_DATA,
>   	},
>   	{
> +		.compatible = "samsung,exynos4412-tmu",
> +		.data = (void *)EXYNOS_TMU_DRV_DATA,
> +	},
> +	{
>   		.compatible = "samsung,exynos5250-tmu",
>   		.data = (void *)EXYNOS_TMU_DRV_DATA,
>   	},
>

Please send a patch to include the documentation for this too.
