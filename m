From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v6 1/4] clk: Add support for runtime PM
Date: Thu, 30 Mar 2017 10:11:13 -0700
Message-ID: <149089387341.31513.7531874072502656432@resonance>
References: <1490182543-28550-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170322113554eucas1p27471f0de278c55d5dce7fdf120395e09@eucas1p2.samsung.com>
 <1490182543-28550-2-git-send-email-m.szyprowski@samsung.com>
 <149081897388.31513.7062843004022908296@resonance>
 <75509e0f-26cd-52e7-8c71-b004ab6abc81@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34608 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933024AbdC3RLX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 13:11:23 -0400
Received: by mail-pg0-f54.google.com with SMTP id 21so45816128pgg.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2017 10:11:22 -0700 (PDT)
In-Reply-To: <75509e0f-26cd-52e7-8c71-b004ab6abc81@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Quoting Marek Szyprowski (2017-03-30 00:24:15)
> Hi Michael,
> =

> On 2017-03-29 22:22, Michael Turquette wrote:
> > Quoting Marek Szyprowski (2017-03-22 04:35:40)
> >> Registers for some clocks might be located in the SOC area, which are =
under the
> >> power domain. To enable access to those registers respective domain ha=
s to be
> >> turned on. Additionally, registers for such clocks will usually loose =
its
> >> contents when power domain is turned off, so additional saving and res=
toring of
> >> them might be needed in the clock controller driver.
> >>
> >> This patch adds basic infrastructure in the clocks core to allow imple=
menting
> >> driver for such clocks under power domains. Clock provider can supply a
> >> struct device pointer, which is the used by clock core for tracking an=
d managing
> >> clock's controller runtime pm state. Each clk_prepare() operation
> >> will first call pm_runtime_get_sync() on the supplied device, while
> >> clk_unprepare() will do pm_runtime_put_sync() at the end.
> >>
> >> Additional calls to pm_runtime_get/put functions are required to ensur=
e that any
> >> register access (like calculating/changing clock rates and unpreparing=
/disabling
> >> unused clocks on boot) will be done with clock controller in runtime r=
esumend
> >> state.
> > The above is a bit confusing. Is clk_prepare really special? It seems to
> > me that every single clk_ops callback will need this?
> =

> clk_prepare/unprepare are special, because they allow sleeping, so they =

> are natural
> candidates for the place for calling runtime PM operations. =

> clk_enable()/disable()
> is called under a spinlock, so runtime pm cannot be called efficiently =

> there, but
> core guarantees that they are called after clk_prepare(), so accessing =

> hw registers
> is safe. The only remaining calls are not guaranteed to be called always =

> after
> clk_prepare(), so those additional calls and checks in runtime pm are =

> needed there.

Right, so any call that holds prepare_lock and might touch the hardware
needs to first call pm_runtime_get_sync.

> =

> > That leads to my second question: why put this in the clk core? Can the
> > clk provider driver simply add pm_runtime_{get,put} calls into its
> > clk_ops callbacks instead? The clk core does not directly touch hardware
> > (e.g. reading registers) so putting the pm runtime calls into the
> > provider callbacks should be sufficient.
> =

> In theory is should be possible to duplicate all kind of clock build bloc=
ks
> (gates, muxes, dividers, ...) with additional runtime pm calls. This =

> would however
> end in much more code and a bit more complicated locking. Implementing =

> it in clk
> core made the code simpler. It also turned out that runtime pm =

> integration is
> needed for more that a single clock provider: besides Samsung SoCs =

> (Exynos 5433
> and newer, Exynos 4412 ISP, Exynos Audio Subsystem, hacks in Exynos 542x =

> can be
> also replaced by runtime PM calls), Ulf mentioned that exactly similar =

> pattern
> is used for some UX500 SoCs (STE). More will probably come once the =

> feature is
> in, because for now such drivers simply forces runtime active state as a
> workaround or don't instantiate related power domains at all.

I agree with the above, but I'm also wondering about the folks that use
regmap internally to their own clock provider drivers. I guess they will
have the option to either do their own thing or use this framework-level
solution.

I've started reviewing the code itself and will respond to those mails
separately.

Thanks,
Mike

> =

> It is not that uncommon to have runtime PM integrated in the framework =

> (examples:
> mmc, scsi). Please not that this is optional for clock providers - if =

> they don't
> enable runtime PM for the provided clock controller device during clock
> registration, the clock core will behave exactly the same way as now.
> =

> >> When one wants to register clock controller, which make use of this fe=
ature, he
> >> has to:
> >> 1. Provide a struct device to the core when registering the provider.
> >> 2. Ensure to enable runtime PM for that device before registering cloc=
ks.
> >> 3. Make sure that the runtime PM status of the controller device refle=
cts
> >>     the HW state.
> > Third question: is there a case where more than one device is required?
> > Is is possible that a single pm_runtime_get call against a single device
> > will not be enough for some clk provider drivers? If so then this
> > solution does not scale very well and the clk provider driver will have
> > to implement this in the clk_ops callbacks (as I mentioned above in my
> > second question).
> =

> This is a generic question about runtime PM. There are various methods to
> model hardware relations to control pm/runtime pm state of a set of devic=
es:
> child-parent-bus relations (setting child to active state also activates a
> parent), gen_pd power domains and sub-domains and recently merged device =
pm
> links, which allows to model relations across the typical child-parent tr=
ee
> hierarchy. IMHO device core pm related framework provides enough features=
 to
> solve the case when one needs to control more than one device - what is
> worth to mention - in all cases the client only need to call pm_runtime
> funtions on the ONE leaf device, everything else will be handled by pm co=
re.
> =

> > Fourth & final question: I'm under the impression that pm runtime calls
> > be be nested and re-enter, but I want to make sure (Ulf?). For instance
> > it is highly likely that this new feature would cause something like:
> >
> > pm_runtime_get()              - called by random driver
> > -> clk_prepare_enable()       - genpd enables functioal clocks
> >     -> pm_runtime_get()        - called by clk_pm_runtime_get in clk co=
re
> >        -> clk_prepare_enable() - genpd enables interface or bus clocks
> >
> > I guess this is safe from the pm_runtime_get/genpd perspective, but want
> > to make sure first.
> =

> Yes, this will work fine after recent fixes. Tested with Exynos IIS ASoC
> driver (which is also a clock provider), which in turn is a client for
> Exynos Audio Subsystem clock provider.
> =

> > Thanks,
> =

>  >> [...]
> =

> Best regards
> -- =

> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>=20
