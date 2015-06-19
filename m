From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/6] clk: add CLK_RECALC_NEW_RATES clock flag for Exynos
 cpu clock support
Date: Fri, 19 Jun 2015 13:19:06 +0200
Message-ID: <15113828.ygxT0eaek9@amdc1976>
References: <'@samsung.com> <55535BF9.60609@samsung.com>
 <20150618195846.9112.7144@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51092 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbFSLT4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 07:19:56 -0400
In-reply-to: <20150618195846.9112.7144@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


Hi,

On Thursday, June 18, 2015 12:58:46 PM Michael Turquette wrote:
> Quoting Sylwester Nawrocki (2015-05-13 07:13:13)
> > On 03/04/15 18:43, Bartlomiej Zolnierkiewicz wrote:
> > > This flag is needed to fix the issue with wrong dividers being setup
> > > by Common Clock Framework when using the new Exynos cpu clock support.
> > > 
> > > The issue happens because clk_core_set_rate_nolock()  calls
> > > clk_calc_new_rates(clk, rate) before both pre/post clock notifiers have
> > > a chance to run.  In case of Exynos cpu clock support pre/post clock
> > > notifiers are registered for mout_apll clock which is a parent of armclk
> > > cpu clock and dividers are modified in both pre and post clock notifier.
> > > This results in wrong dividers values being later programmed by
> > > clk_change_rate(top).  To workaround the problem CLK_RECALC_NEW_RATES
> > > flag is added and it is set for mout_apll clock later so the correct
> > > divider values are re-calculated after both pre and post clock notifiers
> > > had run.
> > > 
> > > For example when using "performance" governor on Exynos4210 Origen board
> > > the cpufreq-dt driver requests to change the frequency from 1000MHz to
> > > 1200MHz and after the change state of the relevant clocks is following:
> > > 
> > > Without use of CLK_GET_RATE_NOCACHE flag:
> > > 
> > >  fout_apll rate: 1200000000
> > >          fout_apll_div_2 rate: 600000000
> > >                  mout_clkout_cpu rate: 600000000
> > >                          div_clkout_cpu rate: 600000000
> > >                                  clkout_cpu rate: 600000000
> > >          mout_apll rate: 1200000000
> > >                  armclk rate: 1200000000
> > >                  mout_hpm rate: 1200000000
> > >                          div_copy rate: 300000000
> > >                                  div_hpm rate: 300000000
> > >                  mout_core rate: 1200000000
> > >                          div_core rate: 1200000000
> > >                                  div_core2 rate: 1200000000
> > >                                          arm_clk_div_2 rate: 600000000
> > >                                          div_corem0 rate: 300000000
> > >                                          div_corem1 rate: 150000000
> > >                                          div_periph rate: 300000000
> > >                          div_atb rate: 300000000
> > >                                  div_pclk_dbg rate: 150000000
> > >                  sclk_apll rate: 1200000000
> > >                          sclk_apll_div_2 rate: 600000000
> > > 
> > > 
> > > With use of CLK_GET_RATE_NOCACHE flag:
> > > 
> > >  fout_apll rate: 1200000000
> > >          fout_apll_div_2 rate: 600000000
> > >                  mout_clkout_cpu rate: 600000000
> > >                          div_clkout_cpu rate: 600000000
> > >                                  clkout_cpu rate: 600000000
> > >          mout_apll rate: 1200000000
> > >                  armclk rate: 1200000000
> > >                  mout_hpm rate: 1200000000
> > >                          div_copy rate: 200000000
> > >                                  div_hpm rate: 200000000
> > >                  mout_core rate: 1200000000
> > >                          div_core rate: 1200000000
> > >                                  div_core2 rate: 1200000000
> > >                                          arm_clk_div_2 rate: 600000000
> > >                                          div_corem0 rate: 300000000
> > >                                          div_corem1 rate: 150000000
> > >                                          div_periph rate: 300000000
> > >                          div_atb rate: 240000000
> > >                                  div_pclk_dbg rate: 120000000
> > >                  sclk_apll rate: 150000000
> > >                          sclk_apll_div_2 rate: 75000000
> > > 
> > > Without this change cpufreq-dt driver showed ~10 mA larger energy
> > > consumption when compared to cpufreq-exynos one when "performance"
> > > cpufreq governor was used on Exynos4210 SoC based Origen board.
> > > 
> > > This issue was probably meant to be workarounded by use of
> > > CLK_GET_RATE_NOCACHE and CLK_DIVIDER_READ_ONLY clock flags in
> > > the original Exynos cpu clock patchset (in "[PATCH v12 6/6] clk:
> > > samsung: remove unused clock aliases and update clock flags" patch)
> > > but usage of these flags is not sufficient to fix the issue observed.
> > > 
> > > Cc: Thomas Abraham <thomas.ab@samsung.com>
> > > Cc: Tomasz Figa <tomasz.figa@gmail.com>
> > > Cc: Mike Turquette <mturquette@linaro.org>
> > > Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > ---
> > >  drivers/clk/clk.c            |    3 +++
> > >  include/linux/clk-provider.h |    1 +
> > >  2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index f85c8e2..97cc73e 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -1771,6 +1771,9 @@ static void clk_change_rate(struct clk_core *clk)
> > >       if (clk->notifier_count && old_rate != clk->rate)
> > >               __clk_notify(clk, POST_RATE_CHANGE, old_rate, clk->rate);
> > >  
> > > +     if (clk->flags & CLK_RECALC_NEW_RATES)
> > > +             (void)clk_calc_new_rates(clk, clk->new_rate);
> > > +
> > >       /*
> > >        * Use safe iteration, as change_rate can actually swap parents
> > >        * for certain clock types.
> > > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > > index 28abf1b..8d1aebe 100644
> > > --- a/include/linux/clk-provider.h
> > > +++ b/include/linux/clk-provider.h
> > > @@ -31,6 +31,7 @@
> > >  #define CLK_GET_RATE_NOCACHE BIT(6) /* do not use the cached clk rate */
> > >  #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
> > >  #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
> > > +#define CLK_RECALC_NEW_RATES BIT(9) /* recalc rates after notifications */
> > 
> > Mike, Stephen, what do you think about this? I'm rather resistant to
> > this new flag approach, it looks like a hack. I don't seem to have better
> > ideas to address the missing rate recalculation issue though.
> 
> I also do not like it. The root of the problem is the use of clk
> notifiers to change clk rates. This is also a hack and it points towards
> some missing infrastructure in the clock framework.

I'm very surprised by this.  Clock changes using clock notifiers in
Thomas' original patchset were Acked by you:

"[PATCH v12 1/6] clk: samsung: add infrastructure to register cpu clocks"
https://www.marc.info/?l=linux-arm-kernel&m=141657613203808&w=2

I've only fixed issues present within the original code (this 4 lines
workaround/hack change to clock subsystem is a result of this), I have
not changed it fundamentally.

> > I thought about making the cpu clk notifier callback returning a specific
> > error value, which would then trigger rate recalculation after
> > __clk_notify() call in clk_change_rate() function. This way the trigger
> > of the repeated rate recalculation would come from a notifier callback,
> > rather than from a clock definition. But in general it would be difficult
> > to handle multiple notification callbacks, each of which would attempt
> > to trigger the rate recalculation.
> 
> The more complexity we add to the notifier callbacks the crazier things
> will get. For now I'd like to see Exynos continue to use the
> platform-specific CPUfreq drivers until the new coordinated clock rates
> infrastructure makes it possible to do this type of stuff without
> relying on the notifiers. I'm working on this feature Right Now. I never
> like putting dates on upstream stuff but I'd like to see this feature in
> 4.3 if possible.

So after 2.5 months of waiting on your feedback you're saying that the
current patches (Acked by all other Maintainers and tested on affected
platforms) should be just abandoned and we should wait with re-doing
them on some not yet implemented feature of clock subsystem which would
be available 2 months from now (at earliest)?

Also what should I do about CPUfreq support for SoCs that don't have
platform specific CPUfreq drivers currently and that need current patches
to work (I mean Exynos542x, Exynos5800 and Exynos5433 in the future)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
