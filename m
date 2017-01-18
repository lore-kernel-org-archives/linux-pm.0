From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v2 01/13] soc: samsung: pmu: Provide global function to
 get PMU regmap
Date: Wed, 18 Jan 2017 17:31:17 +0900
Message-ID: <CA+Ln22F8JPcL35XO9sN6C+HPOeh==gm28Lt2WttW74CFQsoFLg@mail.gmail.com>
References: <CGME20170117124456eucas1p1d42d11aa2117caed8d89faa8c09e6218@eucas1p1.samsung.com>
 <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <1484657084-26227-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484657084-26227-2-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Marek,

2017-01-17 21:44 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> PMU is something like a SoC wide service, so add a helper function to get
> PMU regmap. This will be used by other Exynos device drivers. This way it
> can be avoided to model this dependency in device tree (as phandles to PMU
> node) for almost every device in the SoC.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/soc/samsung/exynos-pmu.c       | 11 +++++++++++
>  include/linux/soc/samsung/exynos-pmu.h |  7 +++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index 0acdfd82e751..5c269bf23210 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -11,6 +11,7 @@
>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
>
> @@ -92,6 +93,16 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
>         { /*sentinel*/ },
>  };
>
> +struct regmap *exynos_get_pmu_regmap(void)
> +{
> +       struct device_node *np = of_find_matching_node(NULL,
> +                                                     exynos_pmu_of_device_ids);
> +       if (np)
> +               return syscon_node_to_regmap(np);
> +       return ERR_PTR(-ENODEV);
> +}
> +EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
> +
>  static int exynos_pmu_probe(struct platform_device *pdev)
>  {
>         const struct of_device_id *match;
> diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
> index e2e9de1acc5b..2a841a474684 100644
> --- a/include/linux/soc/samsung/exynos-pmu.h
> +++ b/include/linux/soc/samsung/exynos-pmu.h
> @@ -12,6 +12,8 @@
>  #ifndef __LINUX_SOC_EXYNOS_PMU_H
>  #define __LINUX_SOC_EXYNOS_PMU_H
>
> +#include <linux/regmap.h>
> +

nit: It would save some compilation time to just add a forward
declaration of struct regmap here instead, in case of files that
include this header, but don't need regmap functionality.

>  enum sys_powerdown {
>         SYS_AFTR,
>         SYS_LPA,
> @@ -20,5 +22,10 @@ enum sys_powerdown {
>  };
>
>  extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
> +#ifdef CONFIG_EXYNOS_PMU
> +extern struct regmap *exynos_get_pmu_regmap(void);
> +#else
> +static inline struct regmap *exynos_get_pmu_regmap(void) { return NULL; }

Shouldn't be some ERR_PTR() instead?

Best regards,
Tomasz
