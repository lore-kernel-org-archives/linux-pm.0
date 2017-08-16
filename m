From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/2] cpufreq: dt-platdev: Drop few entries from whitelist
Date: Wed, 16 Aug 2017 16:53:58 +0800
Message-ID: <CAGb2v65DokoXaJp=hdFpg0GgTs50ZMR=JrZB7zNwQntH14zj3Q@mail.gmail.com>
References: <e93c74a19ebf6d7ee687ef8b71b3150a96527f7c.1502861444.git.viresh.kumar@linaro.org>
 <7182e308a552d37064f61e724c709667a6fa098d.1502861444.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:42308 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbdHPIyW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2017 04:54:22 -0400
In-Reply-To: <7182e308a552d37064f61e724c709667a6fa098d.1502861444.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Wei Xu <xuwei5@hisilicon.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, jun.nie@linaro.org, Baoyou Xie <baoyou.xie@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, Aug 16, 2017 at 1:37 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
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

Acked-by: Chen-Yu Tsai <wens@csie.org>

In fact, we can drop all the sun8i entries. Of them, only sun8i-a33 has
cpufreq implemented. All the other ones are missing thermal sensor support,
and no OPP tables have been added yet.

ChenYu
