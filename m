From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: exynos: use correct offset for TMU_CONTROL
 register on Exynos5260
Date: Thu, 13 Nov 2014 16:15:18 +0100
Message-ID: <10653155.va3UnGOxba@amdc1032>
References: <1594947.1Ri7fFnV5h@amdc1032> <17456984.pRSEMqiSfL@amdc1032>
 <20141107185949.GA27266@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20141107185949.GA27266@developer>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Friday, November 07, 2014 02:59:51 PM Eduardo Valentin wrote:
> Hi Bartlomiej,
> 
> On Mon, Oct 20, 2014 at 02:41:07PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > Eduardo, could you please merge this patch?
> > 
> 
> I queued this in my -fixes branch. It should appear also in linux-next.

Thanks!

> Can you please refresh your patch series
> https://lkml.org/lkml/2014/9/18/305
> 
> based on my tree? Looks like something may be missing, as could not get
> all patches applied cleanly.

Done:

  http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg38717.html

Sorry for the delay.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Thanks
> 
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> > 
> > On Thursday, September 11, 2014 03:00:49 PM Bartlomiej Zolnierkiewicz wrote:
> > > In exynos5260_tmu_registers tmu_ctrl entry is erroneously
> > > assigned twice.  The second assignment (to EXYNOS_TMU_REG_CONTROL1
> > > define which represents 0x24 value) overrides the first one
> > > (to EXYNOS_TMU_REG_CONTROL define which represents 0x20 value)
> > > which results in the wrong (according to the Exynos5260 SoC
> > > documentation that I have) offset being used for TMU_CONTROL
> > > register.  Fix it by removing the wrong assignment and then
> > > remove no longer used EXYNOS_TMU_REG_CONTROL1 define.
> > > 
> > > Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> > > Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> > > Cc: Lukasz Majewski <l.majewski@samsung.com>
> > > Cc: Eduardo Valentin <edubezval@gmail.com>
> > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > ---
> > >  drivers/thermal/samsung/exynos_tmu_data.c |    1 -
> > >  drivers/thermal/samsung/exynos_tmu_data.h |    1 -
> > >  2 files changed, 2 deletions(-)
> > > 
> > > Index: b/drivers/thermal/samsung/exynos_tmu_data.c
> > > ===================================================================
> > > --- a/drivers/thermal/samsung/exynos_tmu_data.c	2014-09-11 14:41:12.567347442 +0200
> > > +++ b/drivers/thermal/samsung/exynos_tmu_data.c	2014-09-11 14:43:00.211350284 +0200
> > > @@ -273,7 +273,6 @@ struct exynos_tmu_init_data const exynos
> > >  static const struct exynos_tmu_registers exynos5260_tmu_registers = {
> > >  	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
> > >  	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
> > > -	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL1,
> > >  	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
> > >  	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
> > >  	.therm_trip_en_shift = EXYNOS_TMU_THERM_TRIP_EN_SHIFT,
> > > Index: b/drivers/thermal/samsung/exynos_tmu_data.h
> > > ===================================================================
> > > --- a/drivers/thermal/samsung/exynos_tmu_data.h	2014-09-11 14:41:12.243347433 +0200
> > > +++ b/drivers/thermal/samsung/exynos_tmu_data.h	2014-09-11 14:43:36.167351233 +0200
> > > @@ -83,7 +83,6 @@
> > >  #define EXYNOS_MAX_TRIGGER_PER_REG	4
> > >  
> > >  /* Exynos5260 specific */
> > > -#define EXYNOS_TMU_REG_CONTROL1			0x24
> > >  #define EXYNOS5260_TMU_REG_INTEN		0xC0
> > >  #define EXYNOS5260_TMU_REG_INTSTAT		0xC4
> > >  #define EXYNOS5260_TMU_REG_INTCLEAR		0xC8
