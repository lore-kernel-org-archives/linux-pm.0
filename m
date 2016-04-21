From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/8] cpufreq: imx: Use generic platdev driver
Date: Thu, 21 Apr 2016 15:20:32 +0530
Message-ID: <20160421095032.GD29799@vireshk-i7>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
 <08c7bf360dfb7620591c0e0de6e047fffb0a5546.1461228081.git.viresh.kumar@linaro.org>
 <18756925.NSB5aJaqC9@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36740 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbcDUJug (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 05:50:36 -0400
Received: by mail-pf0-f182.google.com with SMTP id e128so28430332pfe.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2016 02:50:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <18756925.NSB5aJaqC9@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Rafael Wysocki <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, arnd.bergmann@linaro.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 21-04-16, 11:46, Arnd Bergmann wrote:
> On Thursday 21 April 2016 14:13:48 Viresh Kumar wrote:
> > The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> > device now, reuse that and remove similar code from platform code.
> > 
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm/mach-imx/imx27-dt.c         | 4 ----
> >  arch/arm/mach-imx/mach-imx51.c       | 3 ---
> >  arch/arm/mach-imx/mach-imx53.c       | 2 --
> >  arch/arm/mach-imx/mach-imx7d.c       | 6 ------
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++
> >  5 files changed, 5 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
> > index bd42d1bd10af..90c62bf01f9e 100644
> > --- a/arch/arm/mach-imx/imx27-dt.c
> > +++ b/arch/arm/mach-imx/imx27-dt.c
> > @@ -20,11 +20,7 @@
> >  
> >  static void __init imx27_dt_init(void)
> >  {
> > -	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
> > -
> >  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > -
> > -	platform_device_register_full(&devinfo);
> >  }
> >
> 
> Please remove the entire function now, a NULL .init_machine machine
> callback pointer has the same effect as the remaining line.
> 
> The rest of the patch is fine.

Perhaps that should be done in a separate patch I feel. Will do so after this is
merged.

-- 
viresh
