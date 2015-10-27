From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 1/6] PM / Domains: prepare for multiple states
Date: Tue, 27 Oct 2015 15:33:43 +0100
Message-ID: <CAPDyKFpk+beHDp4JPdNLFb5RqJfBJCu-mKpk5B0OM6WH8-SUPQ@mail.gmail.com>
References: <1445347589-5626-1-git-send-email-ahaslam@baylibre.com>
	<1445347589-5626-2-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36198 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338AbbJ0Odq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 10:33:46 -0400
Received: by ykba4 with SMTP id a4so213909296ykb.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2015 07:33:45 -0700 (PDT)
In-Reply-To: <1445347589-5626-2-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Kevin Hilman <khilman@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, geert@glider.be, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Axel Haslam <ahaslam+renesas@baylibre.com>

On 20 October 2015 at 15:26,  <ahaslam@baylibre.com> wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
> prepare generic power domain init function parameters to accept a pointer
> to the states structure that describes the possible states that a power
> domain can enter.
>
> Also, as most platforms are not initializing states or latencies, add
> pm_genpd_init_simple that allows platfroms to use a default single OFF
> state with initial latencies set to 0.
>
> There is no functional change, as support for multiple domains will be
> added in subsequent patches.
>
> Suggested-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>

Hi Axel,

Apologize for the delay in providing feedback.

> ---
>  arch/arm/mach-exynos/pm_domains.c     |  2 +-
>  arch/arm/mach-imx/gpc.c               |  2 +-
>  arch/arm/mach-s3c64xx/pm.c            |  4 ++--
>  arch/arm/mach-shmobile/pm-rmobile.c   |  2 +-
>  arch/arm/mach-ux500/pm_domains.c      |  2 +-
>  arch/arm/mach-zx/zx296702-pm-domain.c |  2 +-

You don't need to make above changes.

Instead of inventing pm_genpd_init_simple(), I would rather see that
you add a new __pm_genpd_init() API. Let's make it take *only* a
"struct generic_pm_domain *genpd" parameter.
Moreover, to prevent code duplication, adopt the code in
pm_genpd_init() so it can invoke __pm_genpd_init().

Then, piece by piece we can convert users from the legacy
pm_genpd_init() to the __pm_genpd_init().

>  drivers/base/power/domain.c           | 19 ++++++++++++++++++-
>  drivers/clk/qcom/gdsc.c               |  2 +-
>  drivers/clk/shmobile/clk-mstp.c       |  2 +-
>  drivers/soc/dove/pmu.c                |  2 +-
>  drivers/soc/mediatek/mtk-scpsys.c     |  2 +-
>  drivers/soc/rockchip/pm_domains.c     |  2 +-
>  include/linux/pm_domain.h             | 27 ++++++++++++++++++++++++++-
>  13 files changed, 56 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index 7c21760..dc36723 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -187,7 +187,7 @@ static __init int exynos4_pm_init_power_domain(void)
>  no_clk:
>                 on = __raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN;
>
> -               pm_genpd_init(&pd->pd, NULL, !on);
> +               pm_genpd_init_simple(&pd->pd, NULL, !on);
>                 of_genpd_add_provider_simple(np, &pd->pd);
>         }
>
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index 10bf715..aefe92d 100644
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
> @@ -422,7 +422,7 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
>         if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS))
>                 return 0;
>
> -       pm_genpd_init(&imx6q_pu_domain.base, NULL, false);
> +       pm_genpd_init_simple(&imx6q_pu_domain.base, NULL, false);
>         return of_genpd_add_provider_onecell(dev->of_node,
>                                              &imx_gpc_onecell_data);
>
> diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
> index 75b14e7..d68a45c 100644
> --- a/arch/arm/mach-s3c64xx/pm.c
> +++ b/arch/arm/mach-s3c64xx/pm.c
> @@ -316,11 +316,11 @@ int __init s3c64xx_pm_init(void)
>         s3c_pm_init();
>
>         for (i = 0; i < ARRAY_SIZE(s3c64xx_always_on_pm_domains); i++)
> -               pm_genpd_init(&s3c64xx_always_on_pm_domains[i]->pd,
> +               pm_genpd_init_simple(&s3c64xx_always_on_pm_domains[i]->pd,
>                               &pm_domain_always_on_gov, false);
>
>         for (i = 0; i < ARRAY_SIZE(s3c64xx_pm_domains); i++)
> -               pm_genpd_init(&s3c64xx_pm_domains[i]->pd, NULL, false);
> +               pm_genpd_init_simple(&s3c64xx_pm_domains[i]->pd, NULL, false);
>
>  #ifdef CONFIG_S3C_DEV_FB
>         if (dev_get_platdata(&s3c_device_fb.dev))
> diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
> index 46d0a1d..906a2eb 100644
> --- a/arch/arm/mach-shmobile/pm-rmobile.c
> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
> @@ -131,7 +131,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
>         struct dev_power_governor *gov = rmobile_pd->gov;
>
>         genpd->flags = GENPD_FLAG_PM_CLK;
> -       pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
> +       pm_genpd_init_simple(genpd, gov ? : &simple_qos_governor, false);
>         genpd->dev_ops.active_wakeup    = rmobile_pd_active_wakeup;
>         genpd->power_off                = rmobile_pd_power_down;
>         genpd->power_on                 = rmobile_pd_power_up;
> diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
> index 4d71c90..208e784 100644
> --- a/arch/arm/mach-ux500/pm_domains.c
> +++ b/arch/arm/mach-ux500/pm_domains.c
> @@ -72,7 +72,7 @@ int __init ux500_pm_domains_init(void)
>         genpd_data->num_domains = ARRAY_SIZE(ux500_pm_domains);
>
>         for (i = 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
> -               pm_genpd_init(ux500_pm_domains[i], NULL, false);
> +               pm_genpd_init_simple(ux500_pm_domains[i], NULL, false);
>
>         of_genpd_add_provider_onecell(np, genpd_data);
>         return 0;
> diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
> index e08574d..0ec8f0c 100644
> --- a/arch/arm/mach-zx/zx296702-pm-domain.c
> +++ b/arch/arm/mach-zx/zx296702-pm-domain.c
> @@ -175,7 +175,7 @@ static int zx296702_pd_probe(struct platform_device *pdev)
>         }
>
>         for (i = 0; i < ARRAY_SIZE(zx296702_pm_domains); ++i)
> -               pm_genpd_init(zx296702_pm_domains[i], NULL, false);
> +               pm_genpd_init_simple(zx296702_pm_domains[i], NULL, false);
>
>         of_genpd_add_provider_onecell(pdev->dev.of_node, genpd_data);
>         return 0;
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b0b5c43..e0b5229 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1447,10 +1447,14 @@ static int pm_genpd_default_restore_state(struct device *dev)
>   * pm_genpd_init - Initialize a generic I/O PM domain object.
>   * @genpd: PM domain object to initialize.
>   * @gov: PM domain governor to associate with the domain (may be NULL).
> + * @states: Array of possible low power states when powering off.
> + * @state_count: Number of low power states.
>   * @is_off: Initial value of the domain's power_is_off field.
>   */
>  void pm_genpd_init(struct generic_pm_domain *genpd,
> -                  struct dev_power_governor *gov, bool is_off)
> +                  struct dev_power_governor *gov,
> +                  const struct genpd_power_state *states,
> +                  unsigned int state_count, bool is_off)
>  {
>         if (IS_ERR_OR_NULL(genpd))
>                 return;
> @@ -1502,6 +1506,19 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>
> +/**
> + * pm_genpd_init_simple - Initialize a generic I/O PM domain object.
> + * @genpd: PM domain object to initialize.
> + * @gov: PM domain governor to associate with the domain (may be NULL).
> + * @is_off: Initial value of the domain's power_is_off field.
> + */
> +void pm_genpd_init_simple(struct generic_pm_domain *genpd,
> +                  struct dev_power_governor *gov, bool is_off)
> +{
> +       pm_genpd_init(genpd, gov, NULL, 0, is_off);
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_init_simple);
> +
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>  /*
>   * Device Tree based PM domain providers.
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index da9fad8..b709bf3 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -196,7 +196,7 @@ static int gdsc_init(struct gdsc *sc)
>
>         sc->pd.power_off = gdsc_disable;
>         sc->pd.power_on = gdsc_enable;
> -       pm_genpd_init(&sc->pd, NULL, !on);
> +       pm_genpd_init_simple(&sc->pd, NULL, !on);
>
>         return 0;
>  }
> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
> index 3b09716..1f18474 100644
> --- a/drivers/clk/shmobile/clk-mstp.c
> +++ b/drivers/clk/shmobile/clk-mstp.c
> @@ -320,7 +320,7 @@ void __init cpg_mstp_add_clk_domain(struct device_node *np)
>         pd->name = np->name;
>
>         pd->flags = GENPD_FLAG_PM_CLK;
> -       pm_genpd_init(pd, &simple_qos_governor, false);
> +       pm_genpd_init_simple(pd, &simple_qos_governor, false);
>         pd->attach_dev = cpg_mstp_attach_dev;
>         pd->detach_dev = cpg_mstp_detach_dev;
>
> diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
> index abd0879..42adc16 100644
> --- a/drivers/soc/dove/pmu.c
> +++ b/drivers/soc/dove/pmu.c
> @@ -215,7 +215,7 @@ static void __pmu_domain_register(struct pmu_domain *domain,
>         domain->base.power_off = pmu_domain_power_off;
>         domain->base.power_on = pmu_domain_power_on;
>
> -       pm_genpd_init(&domain->base, NULL, !(val & domain->pwr_mask));
> +       pm_genpd_init_simple(&domain->base, NULL, !(val & domain->pwr_mask));
>
>         if (np)
>                 of_genpd_add_provider_simple(np, &domain->base);
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 164a7d8..adf364f 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -443,7 +443,7 @@ static int __init scpsys_probe(struct platform_device *pdev)
>                  */
>                 genpd->power_on(genpd);
>
> -               pm_genpd_init(genpd, NULL, false);
> +               pm_genpd_init_simple(genpd, NULL, false);
>         }
>
>         /*
> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
> index 534c589..617e219 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -299,7 +299,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>         pd->genpd.attach_dev = rockchip_pd_attach_dev;
>         pd->genpd.detach_dev = rockchip_pd_detach_dev;
>         pd->genpd.flags = GENPD_FLAG_PM_CLK;
> -       pm_genpd_init(&pd->genpd, NULL, false);
> +       pm_genpd_init_simple(&pd->genpd, NULL, false);
>
>         pmu->genpd_data.domains[id] = &pd->genpd;
>         return 0;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f4dd810..f37faec 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -37,6 +37,17 @@ struct gpd_dev_ops {
>         bool (*active_wakeup)(struct device *dev);
>  };
>
> +struct gpd_cpuidle_data {
> +       unsigned int saved_exit_latency;
> +       struct cpuidle_state *idle_state;
> +};

This is probably some leftover from an old version, right?

> +
> +struct genpd_power_state {
> +       char *name;

I am wondering a bit about the char *name. Do we really need it and if
so, what's do you intend to use it for?

> +       s64 power_off_latency_ns;
> +       s64 power_on_latency_ns;
> +};
> +
>  struct generic_pm_domain {
>         struct dev_pm_domain domain;    /* PM domain operations */
>         struct list_head gpd_list_node; /* Node in the global PM domains list */
> @@ -124,7 +135,14 @@ extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>  extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>                                      struct generic_pm_domain *target);
>  extern void pm_genpd_init(struct generic_pm_domain *genpd,
> +                         struct dev_power_governor *gov,
> +                         const struct genpd_power_state *states,
> +                         unsigned int state_count, bool is_off);
> +extern void pm_genpd_init_simple(struct generic_pm_domain *genpd,
>                           struct dev_power_governor *gov, bool is_off);
> +extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
> +extern int pm_genpd_name_poweron(const char *domain_name);
> +extern void pm_genpd_poweroff_unused(void);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -160,7 +178,14 @@ static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>         return -ENOSYS;
>  }
>  static inline void pm_genpd_init(struct generic_pm_domain *genpd,
> -                                struct dev_power_governor *gov, bool is_off)
> +                                struct dev_power_governor *gov,
> +                                const struct genpd_power_state *states,
> +                                unsigned int state_count, bool is_off)
> +{
> +}
> +static inline void pm_genpd_init_simple(struct generic_pm_domain *genpd,
> +                                       struct dev_power_governor *gov,
> +                                       bool is_off)
>  {
>  }
>  #endif
> --
> 2.4.5
>

Kind regards
Uffe
