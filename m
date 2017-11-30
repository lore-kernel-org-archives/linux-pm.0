From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] PM / Domains: Remove obsolete "samsung,power-domain" check
Date: Thu, 30 Nov 2017 14:21:42 +0100
Message-ID: <CAPDyKFqnY6KCvhNM3WwGZRcUdyPyzs3PqLJ7LwKSnC7jQBVxEw@mail.gmail.com>
References: <1512042868-23017-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512042868-23017-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30 November 2017 at 12:54, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Currently the generic PM Domain code code checks for the presence of
> both (generic) "power-domains" and (Samsung Exynos legacy)
> "samsung,power-domain" properties in all device tree nodes representing
> devices.
>
> There are two issues with this:
>   1. This imposes a small boot-time penalty on all platforms using DT,
>   2. Platform-specific checks do not really belong in core framework
>      code.
>
> Remove the platform-specific check, as the last user of
> "samsung,power-domain" was removed in commit 46dcf0ff0de35da8 ("ARM:
> dts: exynos: Remove exynos4415.dtsi").  All other users were converted
> before in commit 0da6587041363033 ("ARM: dts: convert to generic power
> domain bindings for exynos DT").
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> This is v2 of 'PM / Domains: Restrict "samsung,power-domain" checks to
> ARCH_EXYNOS'.
>
> "samsung,power-domain" was only ever used in:
>   - arch/arm/boot/dts/exynos4415.dtsi: Removed
>   - arch/arm/boot/dts/exynos3250.dtsi: CONFIG_ARCH_EXYNOS3
>   - arch/arm/boot/dts/exynos4.dtsi:    CONFIG_ARCH_EXYNOS4
>   - arch/arm/boot/dts/exynos4x12.dtsi: CONFIG_ARCH_EXYNOS4
>   - arch/arm/boot/dts/exynos5250.dtsi: CONFIG_ARCH_EXYNOS5
>   - arch/arm/boot/dts/exynos5420.dtsi: CONFIG_ARCH_EXYNOS5
>
> v2:
>   - Remove the check completely instead of restricting it to
>     ARCH_EXYNOS, as suggested Javier Martinez Canillas one year ago
>     ("Removing the support for the deprecated property sound sensible to me",
>     http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/462868.html).
> ---
>  drivers/base/power/domain.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0c80bea05bcb92be..f9dcc981b6b9328c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2199,20 +2199,8 @@ int genpd_dev_pm_attach(struct device *dev)
>
>         ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>                                         "#power-domain-cells", 0, &pd_args);
> -       if (ret < 0) {
> -               if (ret != -ENOENT)
> -                       return ret;
> -
> -               /*
> -                * Try legacy Samsung-specific bindings
> -                * (for backwards compatibility of DT ABI)
> -                */
> -               pd_args.args_count = 0;
> -               pd_args.np = of_parse_phandle(dev->of_node,
> -                                               "samsung,power-domain", 0);
> -               if (!pd_args.np)
> -                       return -ENOENT;
> -       }
> +       if (ret < 0)
> +               return ret;
>
>         mutex_lock(&gpd_list_lock);
>         pd = genpd_get_from_provider(&pd_args);
> --
> 2.7.4
>
