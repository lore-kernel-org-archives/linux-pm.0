From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 4/6] thermal: Support for TMU regulator defined at device
 tree
Date: Fri, 19 Apr 2013 13:23:21 -0400
Message-ID: <51717D89.3090303@ti.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com> <1366389493-8239-5-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38994 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab3DSRXn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Apr 2013 13:23:43 -0400
In-Reply-To: <1366389493-8239-5-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, eduardo.valentin@ti.com

On 19-04-2013 12:38, Lukasz Majewski wrote:
> TMU probe function now checks for a device tree defined regulator.
> For compatibility reasons it is allowed to probe driver even without
> this regulator defined.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   drivers/thermal/exynos_thermal.c |   19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
> index ba6094c..e922fa4 100644
> --- a/drivers/thermal/exynos_thermal.c
> +++ b/drivers/thermal/exynos_thermal.c
> @@ -38,6 +38,7 @@
>   #include <linux/cpufreq.h>
>   #include <linux/cpu_cooling.h>
>   #include <linux/of.h>
> +#include <linux/regulator/consumer.h>
>
>   #include <plat/cpu.h>
>
> @@ -119,6 +120,8 @@
>
>   #define EXYNOS_ZONE_COUNT	3
>
> +#define EXYNOS_TMU_REGULATOR "vdd_ts"
> +
>   struct exynos_tmu_data {
>   	struct exynos_tmu_platform_data *pdata;
>   	struct resource *mem;
> @@ -944,6 +947,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>   {
>   	struct exynos_tmu_data *data;
>   	struct exynos_tmu_platform_data *pdata = pdev->dev.platform_data;
> +	struct regulator *reg;
>   	int ret, i;
>
>   	if (!pdata)
> @@ -953,6 +957,21 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "No platform init data supplied.\n");
>   		return -ENODEV;
>   	}
> +
> +	reg = regulator_get(&pdev->dev, EXYNOS_TMU_REGULATOR);
> +	if (!IS_ERR(reg)) {
> +		ret = regulator_enable(reg);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Regulator %s not enabled.\n",
> +				EXYNOS_TMU_REGULATOR);
> +			return ret;
> +		}
> +	} else {
> +		dev_info(&pdev->dev,
> +			 "Regulator %s not defined at device tree.\n",
> +			 EXYNOS_TMU_REGULATOR);
Maybe a dev_warn would fit better?

> +	}
> +
>   	data = devm_kzalloc(&pdev->dev, sizeof(struct exynos_tmu_data),
>   					GFP_KERNEL);
>   	if (!data) {
>

