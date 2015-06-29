From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFC v2 03/16] PM / Domains: Support IRQ safe PM domains
Date: Mon, 29 Jun 2015 15:06:53 +0200
Message-ID: <CAMuHMdXmH6idtZNm0cBuV4HQSQjYenxiwFJ9qya=PiOVZ9Cr4A@mail.gmail.com>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
	<1435374156-19214-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34738 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbbF2NGy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 09:06:54 -0400
Received: by obbkm3 with SMTP id km3so104356822obb.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2015 06:06:53 -0700 (PDT)
In-Reply-To: <1435374156-19214-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, agross@codeaurora.org

Hi Lina,

On Sat, Jun 27, 2015 at 5:02 AM, Lina Iyer <lina.iyer@linaro.org> wrote:
> Generic Power Domains currently support turning on/off only in process
> context. This prevents the usage of PM domains for domains that could be
> powered on/off in a context where IRQs are disabled. Many such domains
> exist today and do not get powered off, when the IRQ safe devices in
> that domain are powered off, because of this limitation.

[...]

Thanks for your patch!

> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt
> @@ -600,7 +600,16 @@ individually.  Instead, a set of devices sharing a power resource can be put
>  into a low-power state together at the same time by turning off the shared
>  power resource.  Of course, they also need to be put into the full-power state
>  together, by turning the shared power resource on.  A set of devices with this
> -property is often referred to as a power domain.
> +property is often referred to as a power domain. A power domain may also be
> +nested inside another domain.

"... another power domain"?

> +Devices, by default, operate in process context and if a device can operate in
> +IRQ safe context, has to be explicitly set as IRQ safe. PM domains by default,

This isn't exactly your fault, but this section is the only one inside this
document that talks about "power domains". All other sections talk about
"PM domains".
You're adding a paragraph about "PM domains" inside this section.

> +operate in process context but could have devices that are IRQ safe. Such PM
> +domains cannot be powered on/off during runtime PM. On the other hand, an IRQ
> +safe PM domain that can be powered on/off and suspend or resumed in an atomic
> +context, may contain IRQ safe devices. Such domain may only contain only IRQ
> +safe devices or IRQ safe sub-domains.
>
>  Support for power domains is provided through the pm_domain field of struct
>  device.  This field is a pointer to an object of type struct dev_pm_domain,
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e9b7cfb..42ffb8b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -50,6 +50,74 @@
>  static LIST_HEAD(gpd_list);
>  static DEFINE_MUTEX(gpd_list_lock);
>
> +static inline int genpd_lock_noirq(struct generic_pm_domain *genpd,
> +                                       unsigned int subclass)
> +       __acquires(&genpd->slock)
> +{
> +       unsigned long flags;
> +
> +       if (unlikely(subclass > 0))

In general, using "unlikely" is frowned upon.
And in this case, the compiler already knows the exact value of subclass,
as it's passed as a constant from one of the functions below.

> +static inline int genpd_lock_irq(struct generic_pm_domain *genpd,
> +                                       unsigned int subclass)
> +       __acquires(&genpd->mlock)
> +{
> +       if (unlikely(subclass > 0))

Same here.

> @@ -1277,11 +1356,18 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>         if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
>                 return -EINVAL;
>
> +       /* Devices in an IRQ safe PM domain have to be IRQ safe too */

Do you really need this comment? It's identical to the error message below.

> +       if (genpd->irq_safe && !dev->power.irq_safe) {
> +               dev_err(dev,
> +                       "Devices in an IRQ safe domain have to be IRQ safe.\n");

> @@ -1385,12 +1471,23 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>             || genpd == subdomain)
>                 return -EINVAL;
>
> +       /*
> +        * If the domain can be powered on/off in an IRQ safe
> +        * context, ensure that the subdomain can also be
> +        * powered on/off in that context.
> +        */
> +       if (genpd->irq_safe && !subdomain->irq_safe) {
> +               WARN("Incompatible sub-domain %s of IRQ safe domain %s\n",
> +                               subdomain->name, genpd->name);

If you change the error message to "Subdomains in an IRQ safe domain have
to be IRQ safe", it's (a) consistent with the one for devices, and (b) you
can remove the comment.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
