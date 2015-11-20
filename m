From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH v6 8/9] ARM: EXYNOS: rearrange static and non-static
 functions of PMU driver
Date: Fri, 20 Nov 2015 10:16:38 +0530
Message-ID: <CAKDJKT5etUJFqZe1Xzhfnepu7VUWZptBr=DwvhX4gtNftE51Wg@mail.gmail.com>
References: <1447740351-14246-1-git-send-email-pankaj.dubey@samsung.com>
	<1447740351-14246-9-git-send-email-pankaj.dubey@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1447740351-14246-9-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, k.kozlowski@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 17, 2015 at 11:35 AM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> This patch moves exynos_sys_powerdown_conf function above all
> static functions, to avoid confusion causing due to mixing of
> static-nonstatic-static functions and to improve readability of this
> driver.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/mach-exynos/pmu.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
> index 01cb649..a7741d4 100644
> --- a/arch/arm/mach-exynos/pmu.c
> +++ b/arch/arm/mach-exynos/pmu.c
> @@ -39,23 +39,6 @@ u32 pmu_raw_readl(u32 offset)
>         return readl_relaxed(pmu_base_addr + offset);
>  }
>
> -static void exynos_power_off(void)
> -{
> -       unsigned int tmp;
> -
> -       pr_info("Power down.\n");
> -       tmp = pmu_raw_readl(EXYNOS_PS_HOLD_CONTROL);
> -       tmp ^= (1 << 8);
> -       pmu_raw_writel(tmp, EXYNOS_PS_HOLD_CONTROL);
> -
> -       /* Wait a little so we don't give a false warning below */
> -       mdelay(100);
> -
> -       pr_err("Power down failed, please power off system manually.\n");
> -       while (1)
> -               ;
> -}
> -
>  void exynos_sys_powerdown_conf(enum sys_powerdown mode)
>  {
>         unsigned int i;
> @@ -85,6 +68,23 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
>         }
>  }
>
> +static void exynos_power_off(void)
> +{
> +       unsigned int tmp;
> +
> +       pr_info("Power down.\n");
> +       tmp = pmu_raw_readl(EXYNOS_PS_HOLD_CONTROL);
> +       tmp ^= (1 << 8);
Can we have some define over here? to operate this bit.

> +       pmu_raw_writel(tmp, EXYNOS_PS_HOLD_CONTROL);
> +
> +       /* Wait a little so we don't give a false warning below */
> +       mdelay(100);
> +
> +       pr_err("Power down failed, please power off system manually.\n");
> +       while (1)
> +               ;
> +}
> +
>  static int pmu_restart_notify(struct notifier_block *this,
>                 unsigned long code, void *unused)
>  {
> --
> 2.4.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
