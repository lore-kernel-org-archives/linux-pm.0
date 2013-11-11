From: Prasanna Kumar <prasannapadubidri@gmail.com>
Subject: Re: [PATCH 1/1] ARM: EXYNOS: Add default latency values for Device
 and Power Domain
Date: Mon, 11 Nov 2013 10:19:40 +0530
Message-ID: <CAPmaG0t++EtdGmVg_JOZt-MU1Su=BDAe7L-tv-un3qkQRkebfg@mail.gmail.com>
References: <1383892025-14759-1-git-send-email-sachin.kamat@linaro.org>
	<9546263.JaCWNRjo5C@flatron>
	<CAK9yfHz-iUfOXEHwJ_QaF=YXudqiUMY0MMpNY4mh-f+ABAx-Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:46647 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab3KKEtl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Nov 2013 23:49:41 -0500
In-Reply-To: <CAK9yfHz-iUfOXEHwJ_QaF=YXudqiUMY0MMpNY4mh-f+ABAx-Xg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prathyush <prathyush.k@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Prasanna Kumar <prasanna.ps@samsung.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Mon, Nov 11, 2013 at 8:52 AM, Sachin Kamat <sachin.kamat@linaro.org>
wrote:
>
> Hi Tomasz,
>
> Thanks for reviewing.
>
> On 10 November 2013 22:25, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > Hi Sachin, Prasanna,
> >
> > [CCing Rafael and respective mailing lists]
> >
> > Please see my comments inline. Also please always remember to add all
> > appropriate recipients on CC list. More reviewers means higher chance of
> > spotting (and so eliminating) potential issues.
>
> Indeed. Thanks for adding. get_maintainers somehow did not list PM
> related folks.
> So missed this.
>
> >
> > On Friday 08 of November 2013 11:57:05 Sachin Kamat wrote:
> >> From: Prasanna Kumar <prasanna.ps@samsung.com>
> >>
> >> Power domain and device timing data are intialized with default
> >> values to avoid dump of warnings from various power domains
> >> during power gating.
> >>
> >> Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
> >> Signed-off-by: Prathyush K <prathyush.k@samsung.com>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> ---
> >>  arch/arm/mach-exynos/pm_domains.c |   15 ++++++++++++++-
> >>  1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/mach-exynos/pm_domains.c
> >> b/arch/arm/mach-exynos/pm_domains.c
> >> index 84e0483a0500..9bbb4ac23980 100644
> >> --- a/arch/arm/mach-exynos/pm_domains.c
> >> +++ b/arch/arm/mach-exynos/pm_domains.c
> >> @@ -25,6 +25,10 @@
> >>  #include <mach/regs-pmu.h>
> >>  #include <plat/devs.h>
> >>
> >> +#define DEFAULT_DEV_LATENCY_NS                       1000000UL
> >> +#define DEFAULT_PD_PWRON_LATENCY_NS          10000000UL
> >> +#define DEFAULT_PD_PWROFF_LATENCY_NS         10000000UL
> >
> > Is there any rationale behind choosing these particular values?
>
> IMO, these values were obtained more from experimentation. Prasanna,
> please comment.
As Sachin mentioned, the values are obtained from experimentation to avoid
latency warning messages. These values can be changed when the
information becomes available from the specs.
As of now , this seems to be good set of values.
>
> >
> >> +
> >>  /*
> >>   * Exynos specific wrapper around the generic power domain
> >>   */
> >> @@ -36,6 +40,13 @@ struct exynos_pm_domain {
> >>       u32 enable;
> >>  };
> >>
> >> +static struct gpd_timing_data dev_latencies = {
> >> +     .stop_latency_ns = DEFAULT_DEV_LATENCY_NS,
> >> +     .start_latency_ns = DEFAULT_DEV_LATENCY_NS,
> >> +     .save_state_latency_ns = DEFAULT_DEV_LATENCY_NS,
> >> +     .restore_state_latency_ns = DEFAULT_DEV_LATENCY_NS,
> >
> > I don't think that stop, start, save and restore latencies should be all
> > the same.
>
> They could be different. But again as I said it was based on
> experimentation rather than reference.
>
> >
> >> +};
> >> +
> >>  static int exynos_pd_power(struct generic_pm_domain *domain, bool
> >> power_on)
> >>  {
> >>       struct exynos_pm_domain *pd;
> >> @@ -83,7 +94,7 @@ static void exynos_add_device_to_domain(struct
> >> exynos_pm_domain *pd,
> >>       dev_dbg(dev, "adding to power domain %s\n", pd->pd.name);
> >>
> >>       while (1) {
> >> -             ret = pm_genpd_add_device(&pd->pd, dev);
> >> +             ret = __pm_genpd_add_device(&pd->pd, dev,
> >> &dev_latencies);
> >
> > The double underscore prefix scares me a bit. Is this function really
> > supposed to be used like this?
>
> We did not find a wrapper/helper function to set this. Hence had to
> use this. In fact I did not
> find any other users of this function (pm_genpd_add_device) too.
>
> >
> >>               if (ret != -EAGAIN)
> >>                       break;
> >>               cond_resched();
> >> @@ -173,6 +184,8 @@ static __init int
> >> exynos4_pm_init_power_domain(void)
> >>               pd->base = of_iomap(np, 0);
> >>               pd->pd.power_off = exynos_pd_power_off;
> >>               pd->pd.power_on = exynos_pd_power_on;
> >> +             pd->pd.power_off_latency_ns =
> >> DEFAULT_PD_PWROFF_LATENCY_NS;
> >> +             pd->pd.power_on_latency_ns = DEFAULT_PD_PWRON_LATENCY_NS;
> >
> > It might be worth to set up the latencies indeed, but wrong values can
> > do
> > more harm than good.
>
> Right. As of this now, this is a well tested set of values.
>
> --
regards,
Prasanna
