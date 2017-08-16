From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] cpufreq: dt-platdev: Drop few entries from whitelist
Date: Wed, 16 Aug 2017 08:51:04 +0200
Message-ID: <CAMuHMdW-_3_p_sv_B0dx1R_0YiwkY0MtgG1Kv1-4_qXb6eiTqA@mail.gmail.com>
References: <e93c74a19ebf6d7ee687ef8b71b3150a96527f7c.1502861444.git.viresh.kumar@linaro.org>
 <7182e308a552d37064f61e724c709667a6fa098d.1502861444.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7182e308a552d37064f61e724c709667a6fa098d.1502861444.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Wei Xu <xuwei5@hisilicon.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, baoyou.xie@linaro.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On Wed, Aug 16, 2017 at 7:37 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
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

I think "renesas,r8a7795" can be removed again, too.
Simon?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
