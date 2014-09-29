From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 6/6] ARM: imx53: add cpufreq support
Date: Mon, 29 Sep 2014 10:33:48 +0200
Message-ID: <1411979628.2625.5.camel@pengutronix.de>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
	 <1411738864-26549-6-git-send-email-l.stach@pengutronix.de>
	 <20140928041513.GI12999@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35957 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbaI2Idz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 04:33:55 -0400
In-Reply-To: <20140928041513.GI12999@dragon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Am Sonntag, den 28.09.2014, 12:15 +0800 schrieb Shawn Guo:
> On Fri, Sep 26, 2014 at 03:41:04PM +0200, Lucas Stach wrote:
> > Instanciate device for the generic cpufreq-dt driver.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> I assume that I should only apply this patch after the cpufreq-dt change
> gets merged and shows up on my base.
> 
> Shawn
> 
I would think its safe to merge this patch. The cpufreq-dt change will
be merged with 3.18. Until then the worst that could happen is that the
cpufreq driver doesn't bind to the mx5 cpu device.

> > ---
> > v2:
> > - new patch, split out from DTS changes and rebased
> >   with new name for cpufreq driver
> > ---
> >  arch/arm/mach-imx/mach-imx53.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> > index 03dd6ea13acc..7587cf0cba3e 100644
> > --- a/arch/arm/mach-imx/mach-imx53.c
> > +++ b/arch/arm/mach-imx/mach-imx53.c
> > @@ -41,6 +41,8 @@ static void __init imx53_dt_init(void)
> >  static void __init imx53_init_late(void)
> >  {
> >  	imx53_pm_init();
> > +
> > +	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> >  }
> >  
> >  static const char * const imx53_dt_board_compat[] __initconst = {
> > -- 
> > 2.1.0
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

