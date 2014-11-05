From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/4] PM / Domains: Improve error handling while
 adding/removing devices
Date: Wed, 5 Nov 2014 08:47:50 +0100
Message-ID: <CAMuHMdWMEaC3=ibf9E8dLcG=zceU5+oE9NnKyRfAM0O36cBAjg@mail.gmail.com>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
	<1414507090-516-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1414507090-516-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 28, 2014 at 3:38 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1358,25 +1358,81 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
>
>  #endif /* CONFIG_PM_SLEEP */
>
> -static struct generic_pm_domain_data *__pm_genpd_alloc_dev_data(struct device *dev)
> +static int genpd_alloc_dev_data(struct generic_pm_domain *genpd,
> +                               struct device *dev, struct gpd_timing_data *td)
>  {

[...]

> +       if (genpd->attach_dev)
> +               genpd->attach_dev(dev);

Note that dev->pm_domain is not yet set at this point, so the callee
can no longer
know to which domain the device is being attached.
Should we re-add the parameter, or move the attach_dev() back to
__pm_genpd_add_device(), like Kevin suggested.

[...]

>  }

>  /**
> @@ -1388,7 +1444,7 @@ static void __pm_genpd_free_dev_data(struct device *dev,
>  int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>                           struct gpd_timing_data *td)
>  {

[...]

> -       ret = dev_pm_get_subsys_data(dev);
> +       ret = genpd_alloc_dev_data(genpd, dev, td);

[...]

>         dev->pm_domain = &genpd->domain;
> -
> +       gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
>         spin_unlock_irq(&dev->power.lock);
>
> -       if (genpd->attach_dev)
> -               genpd->attach_dev(dev);
> -

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
