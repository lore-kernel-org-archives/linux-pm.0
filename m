From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/7] PM / Domains: Support IRQ safe PM domains
Date: Thu, 1 Oct 2015 23:11:56 +0200
Message-ID: <CAMuHMdVYsD7frMacrF0Y1+a+dCWZgZYpNGRn8ij4on4ir0BTuw@mail.gmail.com>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
	<1441310314-8857-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34152 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbJAVL4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 17:11:56 -0400
Received: by obbda8 with SMTP id da8so68180024obb.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2015 14:11:56 -0700 (PDT)
In-Reply-To: <1441310314-8857-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

Hi Lina,

On Thu, Sep 3, 2015 at 9:58 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> Generic Power Domains currently support turning on/off only in proces=
s
> context. This prevents the usage of PM domains for domains that could=
 be
> powered on/off in a context where IRQs are disabled. Many such domain=
s
> exist today and do not get powered off, when the IRQ safe devices in
> that domain are powered off, because of this limitation.
>
> However, not all domains can operate in IRQ safe contexts. Genpd
> therefore, has to support both cases where the domain may or may not
> operate in IRQ safe contexts. Configuring genpd to use an appropriate
> lock for that domain, would allow domains that have IRQ safe devices =
to
> runtime suspend and resume, in atomic context.
>
> To achieve domain specific locking, set the domain's ->flag to
> GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that ge=
npd
> should use a spinlock instead of a mutex for locking the domain. Lock=
ing
> is abstracted through genpd_lock() and genpd_unlock() functions that =
use
> the flag to determine the appropriate lock to be used for that domain=
=2E
> Domains that have lower latency to suspend and resume and can operate
> with IRQs disabled may now be able to save power, when the component
> devices and sub-domains are idle at runtime.
>
> The restriction this imposes on the domain hierarchy is that sub-doma=
ins
> and all devices in the IRQ safe domain's hierarchy also have to be IR=
Q
> safe, so that we dont try to lock a mutex, while holding a spinlock.
> Non-IRQ safe domains may continue to have devices and sub-domains tha=
t
> may or may not be IRQ safe.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

> @@ -394,8 +468,17 @@ static int pm_genpd_poweroff(struct generic_pm_d=
omain *genpd)
>                 if (stat > PM_QOS_FLAGS_NONE)
>                         return -EBUSY;
>
> -               if (!pm_runtime_suspended(pdd->dev) || pdd->dev->powe=
r.irq_safe)
> +               /*
> +                * We do not want to power off the domain if the devi=
ce is
> +                * not suspended or an IRQ safe device is part of thi=
s
> +                * non-IRQ safe domain.
> +                */
> +               if (!pm_runtime_suspended(pdd->dev) ||
> +                       irq_safe_dev_in_no_sleep_domain(pdd->dev, gen=
pd))
>                         not_suspended++;
> +               WARN_ONCE(irq_safe_dev_in_no_sleep_domain(pdd->dev, g=
enpd),
> +                               "PM domain %s will not be powered off=
\n",

Does this warrant a WARN_ON(), i.e. is this really something that shoul=
d not
happen?

This prints "PM domain %s" ...

> +                               genpd->name);

Please also print dev_name(pdd->dev), to make debugging easier.

> @@ -500,17 +583,21 @@ static int pm_genpd_runtime_suspend(struct devi=
ce *dev)
>         }
>
>         /*
> -        * If power.irq_safe is set, this routine will be run with in=
terrupts
> -        * off, so it can't use mutexes.
> +        * If power.irq_safe is set, this routine may be run with
> +        * IRQ disabled, so suspend only if the power domain is
> +        * irq_safe.
>          */
> -       if (dev->power.irq_safe)
> +       WARN_ONCE(irq_safe_dev_in_no_sleep_domain(dev, genpd),
> +                       "genpd %s will not be powered off\n", genpd->=
name);

Does this warrant a WARN_ON(), i.e. is this really something that shoul=
d not
happen?

=2E.. while this prints "genpd %s".

Please also print dev_name(pdd->dev), to make debugging easier.

> +       if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
>                 return 0;

> @@ -1280,11 +1370,18 @@ int __pm_genpd_add_device(struct generic_pm_d=
omain *genpd, struct device *dev,
>         if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
>                 return -EINVAL;
>
> +       if (genpd->irq_safe && !dev->power.irq_safe) {
> +               dev_err(dev,
> +                       "PM Domain %s is IRQ safe; device has to IRQ =
safe.\n",

=2E.. has to be IRQ safe

> +                       genpd->name);

The reason I'm asking about the WARN_ON()s is that both are triggered o=
n the
two systems I tried your series on:
  - r8a7740/armadillo has real hardware power domains and a clock domai=
n,
    using the renesas,sysc-rmobile PM Domain driver,
  - r8a7791/koelsch has a clock domain, using the renesas,cpg-mstp-cloc=
ks
    CPG/MSTP clock domain driver.

Both have renesas,cmt and/or renesas,tmu timers, which are one of the f=
ew
existing IRQ safe devices, causing the warnings.

Apart from the warnings, the system seems to work fine.

Making the PM resp. Clock Domain irqsafe by setting GENPD_FLAG_IRQ_SAFE=
 makes
matters worse, as you cannot attach non-irq safe devices to an irq safe=
 genpd,
which causes the system to fail to boot.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
