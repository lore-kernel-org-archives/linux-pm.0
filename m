From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] PM / Domains: Restrict "samsung,power-domain" checks to
 ARCH_EXYNOS
Date: Fri, 21 Oct 2016 16:58:03 +0300
Message-ID: <20161021135803.GB3289@kozik-lap>
References: <1477049656-27535-1-git-send-email-geert+renesas@glider.be>
 <CAJZ5v0iOQyCwCuMBVcJjX1mMHFb=NkfXFf6yBNdswRw1HMYC=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32931 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754584AbcJUN6J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 09:58:09 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iOQyCwCuMBVcJjX1mMHFb=NkfXFf6yBNdswRw1HMYC=Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, q@kozik-lap
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>

On Fri, Oct 21, 2016 at 02:29:05PM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 21, 2016 at 1:34 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Currently the generic PM Domain code code checks for the presence of
> > both (generic) "power-domains" and (Samsung Exynos legacy)
> > "samsung,power-domain" properties in all device tree nodes representing
> > devices.
> >
> > There are two issues with this:
> >   1. This imposes a small boot-time penalty on all platforms using DT,
> >   2. Platform-specific checks do not really belong in core framework
> >      code.
> >
> > While moving the check from platform-agnostic code to Samsung-specific
> > code is non-trivial, the runtime overhead can be restricted to kernels
> > including support for 32-bit Samsung Exynos platforms.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > "samsung,power-domain" was only ever used in:
> >   - arch/arm/boot/dts/exynos4415.dtsi: Unused?
> >   - arch/arm/boot/dts/exynos3250.dtsi: CONFIG_ARCH_EXYNOS3
> >   - arch/arm/boot/dts/exynos4.dtsi:    CONFIG_ARCH_EXYNOS4
> >   - arch/arm/boot/dts/exynos4x12.dtsi: CONFIG_ARCH_EXYNOS4
> >                                        exynos4212.dtsi is unused?
> >   - arch/arm/boot/dts/exynos5250.dtsi: CONFIG_ARCH_EXYNOS5
> >   - arch/arm/boot/dts/exynos5420.dtsi: CONFIG_ARCH_EXYNOS5
> > ---
> >  drivers/base/power/domain.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index e023066e421547c5..d94d6a4b9b527108 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1853,7 +1853,8 @@ int genpd_dev_pm_attach(struct device *dev)
> >         ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
> >                                         "#power-domain-cells", 0, &pd_args);
> >         if (ret < 0) {
> > -               if (ret != -ENOENT)
> > +               if (ret != -ENOENT || !IS_ENABLED(CONFIG_ARCH_EXYNOS) ||
> 
> Please don't check things like CONFIG_ARCH_EXYNOS in the core.
> 
> If you need to put checks like that here, there is a design problem somewhere.
> 
> And imagine someone 5 years ahead from now looking at this code and
> wondering why on Earth the check is here.

I don't find the argument of performance penalty such important but for
the sake of design, the samsung-specific code could be moved to
drivers/soc/samsung/pm_domains.c, called "legacy_pm_parse" and exported
through a header. Thus with !ARCH_EXYNOS that would be 'static inline
{}'.  However that is not a nice solution - there will be still
direct call to platform-specific code in the core. I am not sure if it
is worth the effort.

The samsung,power-domain was made deprecated (although not explicitly)
in January 2015 (0da658704136 ("ARM: dts: convert to generic power
domain bindings for exynos DT")) so how about:
1. Printing a dev_warn() about usage of deprecated bindings.
2. Complete removal in January 2017?

Best regards,
Krzysztof
