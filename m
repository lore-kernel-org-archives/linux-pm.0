From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 14/15] PM / Domains: Remove default_stop_ok() API
Date: Wed, 3 Sep 2014 15:15:59 +0200
Message-ID: <CAMuHMdUEfAdpUgEtOQfdG1gbZjVo3bfAAmhm0-miFGbQ8ckHgA@mail.gmail.com>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
	<1409741551-16437-15-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1409741551-16437-15-git-send-email-ulf.hansson@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Kevin Hilman <khilman@linaro.org>, Philipp Zabel <philipp.zabel@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On Wed, Sep 3, 2014 at 12:52 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c

> @@ -229,10 +229,7 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
>
>  #else /* !CONFIG_PM_RUNTIME */
>
> -bool default_stop_ok(struct device *dev)
> -{
> -       return false;
> -}
> +static inline bool default_stop_ok(struct device *dev) { return false; }

The "inline" doesn't make much sense here. This function is only
referenced from places that need its address:

struct dev_power_governor simple_qos_governor = {
        .stop_ok = default_stop_ok,
        .power_down_ok = default_power_down_ok,
};

and

struct dev_power_governor pm_domain_always_on_gov = {
        .power_down_ok = always_on_power_down_ok,
        .stop_ok = default_stop_ok,
};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
