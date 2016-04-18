From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 03/11] soc: renesas: rcar-sysc: Add DT support for SYSC
 PM domains
Date: Mon, 18 Apr 2016 14:21:45 +0200
Message-ID: <CAPDyKFrQtX3-7GodrXV2zp4wHBgbWBOVKyE0XoeWaaxhZ2kUuw@mail.gmail.com>
References: <1460558672-10290-1-git-send-email-geert+renesas@glider.be>
	<1460558672-10290-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33571 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbcDRMVr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 08:21:47 -0400
Received: by mail-wm0-f41.google.com with SMTP id f198so21395192wme.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2016 05:21:46 -0700 (PDT)
In-Reply-To: <1460558672-10290-4-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

[...]

> +
> +static bool rcar_sysc_active_wakeup(struct device *dev)
> +{
> +       return true;

I am interested to know why this is always returning true. Perhaps you
can elaborate a bit on that?

> +}
> +
> +static int rcar_sysc_pd_power_off(struct generic_pm_domain *genpd)
> +{
> +       struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
> +
> +       pr_debug("%s: %s\n", __func__, genpd->name);
> +
> +       if (pd->flags & PD_NO_CR) {
> +               pr_debug("%s: Cannot control %s\n", __func__, genpd->name);
> +               return -EBUSY;
> +       }
> +
> +       if (pd->flags & PD_BUSY) {
> +               pr_debug("%s: %s busy\n", __func__, genpd->name);
> +               return -EBUSY;
> +       }
> +
> +       return rcar_sysc_power_down(&pd->ch);
> +}
> +
> +static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
> +{
> +       struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
> +
> +       pr_debug("%s: %s\n", __func__, genpd->name);
> +
> +       if (pd->flags & PD_NO_CR) {
> +               pr_debug("%s: Cannot control %s\n", __func__, genpd->name);
> +               return 0;
> +       }
> +
> +       return rcar_sysc_power_up(&pd->ch);
> +}
> +
> +static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
> +{
> +       struct generic_pm_domain *genpd = &pd->genpd;
> +       const char *name = pd->genpd.name;
> +       struct dev_power_governor *gov = &simple_qos_governor;
> +
> +       if (pd->flags & PD_CPU) {
> +               /*
> +                * This domain contains a CPU core and therefore it should
> +                * only be turned off if the CPU is not in use.
> +                */
> +               pr_debug("PM domain %s contains %s\n", name, "CPU");
> +               pd->flags |= PD_BUSY;
> +               gov = &pm_domain_always_on_gov;
> +       } else if (pd->flags & PD_SCU) {
> +               /*
> +                * This domain contains an SCU and cache-controller, and
> +                * therefore it should only be turned off if the CPU cores are
> +                * not in use.
> +                */
> +               pr_debug("PM domain %s contains %s\n", name, "SCU");
> +               pd->flags |= PD_BUSY;
> +               gov = &pm_domain_always_on_gov;
> +       } else if (pd->flags & PD_NO_CR) {
> +               /*
> +                * This domain cannot be turned off.
> +                */
> +               pd->flags |= PD_BUSY;
> +               gov = &pm_domain_always_on_gov;
> +       }
> +
> +       pm_genpd_init(genpd, gov, false);

This seems weird. I don't think it correct to initialize genpd and
then continue with the below changes (assigning callbacks and power up
the domain).

I would recommend doing this in the reverse order.

> +       genpd->dev_ops.active_wakeup = rcar_sysc_active_wakeup;
> +       genpd->power_off = rcar_sysc_pd_power_off;
> +       genpd->power_on = rcar_sysc_pd_power_on;
> +
> +       if (pd->flags & (PD_CPU | PD_NO_CR)) {
> +               /* Skip CPUs (handled by SMP code) and areas without control */
> +               pr_debug("%s: Not touching %s\n", __func__, genpd->name);
> +               return;
> +       }
> +
> +       if (!rcar_sysc_power_is_off(&pd->ch)) {
> +               pr_debug("%s: %s is already powered\n", __func__, genpd->name);
> +               return;
> +       }
> +
> +       rcar_sysc_power_up(&pd->ch);
> +}

Kind regards
Uffe
