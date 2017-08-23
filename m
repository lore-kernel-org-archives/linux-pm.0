From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/2] cpufreq: dt-platdev: Drop few entries from whitelist
Date: Wed, 23 Aug 2017 12:33:31 +0900
Message-ID: <CAK7LNAStx37ExGUErCz1WDJKA=tjX4D4_FfMQwprLMGG7bib6w@mail.gmail.com>
References: <e93c74a19ebf6d7ee687ef8b71b3150a96527f7c.1502861444.git.viresh.kumar@linaro.org>
 <7182e308a552d37064f61e724c709667a6fa098d.1502861444.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7182e308a552d37064f61e724c709667a6fa098d.1502861444.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Wei Xu <xuwei5@hisilicon.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jun Nie <jun.nie@linaro.org>, baoyou.xie@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,


2017-08-16 14:37 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> Drop few ARM (32 and 64 bit) platforms from the whitelist which always
> use "operating-points-v2" property from their DT. They should continue
> to work after this patch.
>
> Tested on Hikey platform (only the "hisilicon,hi6220" entry).
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 061b468512a2..45f2ec3b7f7a 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -27,7 +27,6 @@ static const struct of_device_id whitelist[] __initconst = {
>         { .compatible = "allwinner,sun6i-a31s", },
>         { .compatible = "allwinner,sun7i-a20", },
>         { .compatible = "allwinner,sun8i-a23", },
> -       { .compatible = "allwinner,sun8i-a33", },
>         { .compatible = "allwinner,sun8i-a83t", },
>         { .compatible = "allwinner,sun8i-h3", },
>
> @@ -37,7 +36,6 @@ static const struct of_device_id whitelist[] __initconst = {
>         { .compatible = "arm,integrator-cp", },
>
>         { .compatible = "hisilicon,hi3660", },
> -       { .compatible = "hisilicon,hi6220", },
>
>         { .compatible = "fsl,imx27", },
>         { .compatible = "fsl,imx51", },
> @@ -51,11 +49,8 @@ static const struct of_device_id whitelist[] __initconst = {
>         { .compatible = "samsung,exynos3250", },
>         { .compatible = "samsung,exynos4210", },
>         { .compatible = "samsung,exynos4212", },
> -       { .compatible = "samsung,exynos4412", },
>         { .compatible = "samsung,exynos5250", },
>  #ifndef CONFIG_BL_SWITCHER
> -       { .compatible = "samsung,exynos5420", },
> -       { .compatible = "samsung,exynos5433", },
>         { .compatible = "samsung,exynos5800", },
>  #endif
>
> @@ -87,11 +82,7 @@ static const struct of_device_id whitelist[] __initconst = {
>         { .compatible = "rockchip,rk3368", },
>         { .compatible = "rockchip,rk3399", },
>
> -       { .compatible = "socionext,uniphier-pro5", },
> -       { .compatible = "socionext,uniphier-pxs2", },
>         { .compatible = "socionext,uniphier-ld6b", },
> -       { .compatible = "socionext,uniphier-ld11", },
> -       { .compatible = "socionext,uniphier-ld20", },


Please remove "socionext,uniphier-ld6b" as well.

It includes the same silicon die
of "socionext,uniphier-pxs2".



-- 
Best Regards
Masahiro Yamada
