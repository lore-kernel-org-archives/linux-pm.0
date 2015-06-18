From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 1/6] clk: add CLK_RECALC_NEW_RATES clock flag for Exynos cpu
 clock support
Date: Thu, 18 Jun 2015 12:58:46 -0700
Message-ID: <20150618195846.9112.7144@quantum>
References: <'@samsung.com> <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
 <1428079429-4252-2-git-send-email-b.zolnierkie@samsung.com>
 <55535BF9.60609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36863 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbbFRT66 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 15:58:58 -0400
Received: by paceq1 with SMTP id eq1so43628797pac.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 12:58:58 -0700 (PDT)
In-Reply-To: <55535BF9.60609@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Quoting Sylwester Nawrocki (2015-05-13 07:13:13)
> On 03/04/15 18:43, Bartlomiej Zolnierkiewicz wrote:
> > This flag is needed to fix the issue with wrong dividers being setup
> > by Common Clock Framework when using the new Exynos cpu clock support.
> > 
> > The issue happens because clk_core_set_rate_nolock()  calls
> > clk_calc_new_rates(clk, rate) before both pre/post clock notifiers have
> > a chance to run.  In case of Exynos cpu clock support pre/post clock
> > notifiers are registered for mout_apll clock which is a parent of armclk
> > cpu clock and dividers are modified in both pre and post clock notifier.
> > This results in wrong dividers values being later programmed by
> > clk_change_rate(top).  To workaround the problem CLK_RECALC_NEW_RATES
> > flag is added and it is set for mout_apll clock later so the correct
> > divider values are re-calculated after both pre and post clock notifiers
> > had run.
> > 
> > For example when using "performance" governor on Exynos4210 Origen board
> > the cpufreq-dt driver requests to change the frequency from 1000MHz to
> > 1200MHz and after the change state of the relevant clocks is following:
> > 
> > Without use of CLK_GET_RATE_NOCACHE flag:
> > 
> >  fout_apll rate: 1200000000
> >          fout_apll_div_2 rate: 600000000
> >                  mout_clkout_cpu rate: 600000000
> >                          div_clkout_cpu rate: 600000000
> >                                  clkout_cpu rate: 600000000
> >          mout_apll rate: 1200000000
> >                  armclk rate: 1200000000
> >                  mout_hpm rate: 1200000000
> >                          div_copy rate: 300000000
> >                                  div_hpm rate: 300000000
> >                  mout_core rate: 1200000000
> >                          div_core rate: 1200000000
> >                                  div_core2 rate: 1200000000
> >                                          arm_clk_div_2 rate: 600000000
> >                                          div_corem0 rate: 300000000
> >                                          div_corem1 rate: 150000000
> >                                          div_periph rate: 300000000
> >                          div_atb rate: 300000000
> >                                  div_pclk_dbg rate: 150000000
> >                  sclk_apll rate: 1200000000
> >                          sclk_apll_div_2 rate: 600000000
> > 
> > 
> > With use of CLK_GET_RATE_NOCACHE flag:
> > 
> >  fout_apll rate: 1200000000
> >          fout_apll_div_2 rate: 600000000
> >                  mout_clkout_cpu rate: 600000000
> >                          div_clkout_cpu rate: 600000000
> >                                  clkout_cpu rate: 600000000
> >          mout_apll rate: 1200000000
> >                  armclk rate: 1200000000
> >                  mout_hpm rate: 1200000000
> >                          div_copy rate: 200000000
> >                                  div_hpm rate: 200000000
> >                  mout_core rate: 1200000000
> >                          div_core rate: 1200000000
> >                                  div_core2 rate: 1200000000
> >                                          arm_clk_div_2 rate: 600000000
> >                                          div_corem0 rate: 300000000
> >                                          div_corem1 rate: 150000000
> >                                          div_periph rate: 300000000
> >                          div_atb rate: 240000000
> >                                  div_pclk_dbg rate: 120000000
> >                  sclk_apll rate: 150000000
> >                          sclk_apll_div_2 rate: 75000000
> > 
> > Without this change cpufreq-dt driver showed ~10 mA larger energy
> > consumption when compared to cpufreq-exynos one when "performance"
> > cpufreq governor was used on Exynos4210 SoC based Origen board.
> > 
> > This issue was probably meant to be workarounded by use of
> > CLK_GET_RATE_NOCACHE and CLK_DIVIDER_READ_ONLY clock flags in
> > the original Exynos cpu clock patchset (in "[PATCH v12 6/6] clk:
> > samsung: remove unused clock aliases and update clock flags" patch)
> > but usage of these flags is not sufficient to fix the issue observed.
> > 
> > Cc: Thomas Abraham <thomas.ab@samsung.com>
> > Cc: Tomasz Figa <tomasz.figa@gmail.com>
> > Cc: Mike Turquette <mturquette@linaro.org>
> > Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/clk/clk.c            |    3 +++
> >  include/linux/clk-provider.h |    1 +
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index f85c8e2..97cc73e 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1771,6 +1771,9 @@ static void clk_change_rate(struct clk_core *clk)
> >       if (clk->notifier_count && old_rate != clk->rate)
> >               __clk_notify(clk, POST_RATE_CHANGE, old_rate, clk->rate);
> >  
> > +     if (clk->flags & CLK_RECALC_NEW_RATES)
> > +             (void)clk_calc_new_rates(clk, clk->new_rate);
> > +
> >       /*
> >        * Use safe iteration, as change_rate can actually swap parents
> >        * for certain clock types.
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 28abf1b..8d1aebe 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -31,6 +31,7 @@
> >  #define CLK_GET_RATE_NOCACHE BIT(6) /* do not use the cached clk rate */
> >  #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
> >  #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
> > +#define CLK_RECALC_NEW_RATES BIT(9) /* recalc rates after notifications */
> 
> Mike, Stephen, what do you think about this? I'm rather resistant to
> this new flag approach, it looks like a hack. I don't seem to have better
> ideas to address the missing rate recalculation issue though.

I also do not like it. The root of the problem is the use of clk
notifiers to change clk rates. This is also a hack and it points towards
some missing infrastructure in the clock framework.

> I thought about making the cpu clk notifier callback returning a specific
> error value, which would then trigger rate recalculation after
> __clk_notify() call in clk_change_rate() function. This way the trigger
> of the repeated rate recalculation would come from a notifier callback,
> rather than from a clock definition. But in general it would be difficult
> to handle multiple notification callbacks, each of which would attempt
> to trigger the rate recalculation.

The more complexity we add to the notifier callbacks the crazier things
will get. For now I'd like to see Exynos continue to use the
platform-specific CPUfreq drivers until the new coordinated clock rates
infrastructure makes it possible to do this type of stuff without
relying on the notifiers. I'm working on this feature Right Now. I never
like putting dates on upstream stuff but I'd like to see this feature in
4.3 if possible.

Regards,
Mike

> 
> -- 
> Regards,
> Sylwester
