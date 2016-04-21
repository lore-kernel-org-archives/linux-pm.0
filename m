From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/8] cpufreq: imx: Use generic platdev driver
Date: Thu, 21 Apr 2016 12:17:07 +0200
Message-ID: <8137134.6Dsv9n3KFK@wuerfel>
References: <cover.1461228081.git.viresh.kumar@linaro.org> <18756925.NSB5aJaqC9@wuerfel> <20160421095032.GD29799@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64152 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbcDUKRs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 06:17:48 -0400
In-Reply-To: <20160421095032.GD29799@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, arnd.bergmann@linaro.org, Shawn Guo <shawnguo@kernel.org>

On Thursday 21 April 2016 15:20:32 Viresh Kumar wrote:
> > > diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
> > > index bd42d1bd10af..90c62bf01f9e 100644
> > > --- a/arch/arm/mach-imx/imx27-dt.c
> > > +++ b/arch/arm/mach-imx/imx27-dt.c
> > > @@ -20,11 +20,7 @@
> > >  
> > >  static void __init imx27_dt_init(void)
> > >  {
> > > -   struct platform_device_info devinfo = { .name = "cpufreq-dt", };
> > > -
> > >     of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > > -
> > > -   platform_device_register_full(&devinfo);
> > >  }
> > >
> > 
> > Please remove the entire function now, a NULL .init_machine machine
> > callback pointer has the same effect as the remaining line.
> > 
> > The rest of the patch is fine.
> 
> Perhaps that should be done in a separate patch I feel. Will do so after this is
> merged.
> 

I would do it in the same patch, just like you remove some of the
.init_late() callbacks elsewhere, but it clearly works either way, so
do as you like unless Shawn or Sascha have a strong opinion on the
matter.

	Arnd
