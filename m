From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 01/12] soc: samsung: pmu: Use common device name to let
 others to find it easily
Date: Tue, 17 Jan 2017 13:39:46 +0900
Message-ID: <CA+Ln22F6Lnm6LkOO-X9ceqYknxXmuwCBowJzDGACmZzQCBj13w@mail.gmail.com>
References: <CGME20170116064523eucas1p18a55f951566df5ddd978364486154931@eucas1p1.samsung.com>
 <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com> <1484549107-5957-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35065 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdAQEjr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 23:39:47 -0500
In-Reply-To: <1484549107-5957-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Marek,

2017-01-16 15:44 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> This patch always set device name to "exynos-pmu" to let other drivers to
> find PMU device easily. This is done mainly to get regmap to access PMU
> registers from other drivers. This way it can be avoided to add phandle to
> the PMU node to almost all drivers in the SoC just to get a regmap access
> in the drivers. PMU is something like a SoC wide service, so there is no
> point modeling it as hardware dependency for all devices in device tree.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/soc/samsung/exynos-pmu.c       |  1 +
>  include/linux/soc/samsung/exynos-pmu.h | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index 0acdfd82e751..63bb471845cb 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -120,6 +120,7 @@ static int exynos_pmu_probe(struct platform_device *pdev)
>                 pmu_context->pmu_data->pmu_init();
>
>         platform_set_drvdata(pdev, pmu_context);
> +       dev_set_name(dev, EXYNOS_PMU_DEV_NAME);
>
>         dev_dbg(dev, "Exynos PMU Driver probe done\n");
>         return 0;
> diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
> index e2e9de1acc5b..90d9205805ea 100644
> --- a/include/linux/soc/samsung/exynos-pmu.h
> +++ b/include/linux/soc/samsung/exynos-pmu.h
> @@ -12,6 +12,10 @@
>  #ifndef __LINUX_SOC_EXYNOS_PMU_H
>  #define __LINUX_SOC_EXYNOS_PMU_H
>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
>  enum sys_powerdown {
>         SYS_AFTR,
>         SYS_LPA,
> @@ -21,4 +25,19 @@ enum sys_powerdown {
>
>  extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
>
> +#define EXYNOS_PMU_DEV_NAME "exynos-pmu"
> +
> +static inline struct regmap *exynos_get_pmu_regs(void)
> +{
> +       struct device *dev = bus_find_device_by_name(&platform_bus_type, NULL,
> +                                                    EXYNOS_PMU_DEV_NAME);
> +       if (dev) {
> +               struct regmap *regs = syscon_node_to_regmap(dev->of_node);
> +               put_device(dev);
> +               if (!IS_ERR(regs))
> +                       return regs;
> +       }
> +       return NULL;

As discussed offline, since this function relies on the PMU driver
probing, we need to defer here if someone calls this function before
that. Since PMU is something that should be assumed to be available in
any Exynos system (it controls to many critical aspects of the SoC), I
think we can simply return ERR_PTR(-EDEFER_PROBE) here instead of
NULL. Maybe also a pr_debug() before deferring could be useful to
debug PMU probe failures.

Best regards,
Tomasz
