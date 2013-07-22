From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 5/8] ARM: S3C64XX: move cpuidle driver to drivers/cpuidle/
Date: Mon, 22 Jul 2013 12:33:05 +0900
Message-ID: <0ad501ce868c$2d9d9ad0$88d8d070$%kim@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
 <1372241747-21083-6-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57728 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454Ab3GVDdI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jul 2013 23:33:08 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQB00817J75E1O0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 22 Jul 2013 12:33:06 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Kukjin Kim' <kgene.kim@samsung.com>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com

Kukjin Kim wrote:
> 
Re-sending due to e-mail client problem :-(

> Bartlomiej Zolnierkiewicz wrote:
> >
> > While at it:
> > - remove file path from comment
> >
> > Compile tested only.
> >
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  arch/arm/mach-s3c64xx/Makefile    |  1 -
> >  arch/arm/mach-s3c64xx/cpuidle.c   | 63
---------------------------------
> --
> > ----
> >  drivers/cpuidle/Makefile          |  3 ++
> >  drivers/cpuidle/cpuidle-s3c64xx.c | 62
> > ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 65 insertions(+), 64 deletions(-)
> >  delete mode 100644 arch/arm/mach-s3c64xx/cpuidle.c
> >  create mode 100644 drivers/cpuidle/cpuidle-s3c64xx.c
> >
> Please see below with using '-M'.
> 
> --------8<-------------------------------8<--------
> obj-$(CONFIG_PM)		+= pm.o irq-pm.o sleep.o
> -obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
> 
>  # DMA support
> 
> diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/drivers/cpuidle/cpuidle-
> s3c64xx.c
> similarity index 92%
> rename from arch/arm/mach-s3c64xx/cpuidle.c
> rename to drivers/cpuidle/cpuidle-s3c64xx.c
> index 3c8ab07..c18d075 100644
> --- a/arch/arm/mach-s3c64xx/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle-s3c64xx.c
> @@ -1,5 +1,4 @@
> -/* linux/arch/arm/mach-s3c64xx/cpuidle.c
> - *
> +/*
>   * Copyright (c) 2011 Wolfson Microelectronics, plc
>   * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>   *		http://www.samsung.com
> @@ -20,8 +19,8 @@
> 
>  #include <mach/map.h>
> 
> -#include "regs-sys.h"
> -#include "regs-syscon-power.h"
> +#include "../../arch/arm/mach-s3c64xx/regs-sys.h"
> +#include "../../arch/arm/mach-s3c64xx/regs-syscon-power.h"
> 
>  static int s3c64xx_enter_idle(struct cpuidle_device *dev,
>  			      struct cpuidle_driver *drv,
> --------8<-------------------------------8<--------
> 
> Would be helpful to check which codes have been changed...
> 
> Need to sort out above inclusions...
> 
> > diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-
> > s3c64xx/Makefile
> > index 31d0c91..e7a3ee7 100644
> > --- a/arch/arm/mach-s3c64xx/Makefile
> > +++ b/arch/arm/mach-s3c64xx/Makefile
> > @@ -22,7 +22,6 @@ obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
> >  # PM
> >
> >  obj-$(CONFIG_PM)		+= pm.o irq-pm.o sleep.o
> > -obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
> >
> >  # DMA support
> >
> > diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-
> > s3c64xx/cpuidle.c
> > deleted file mode 100644
> > index 3c8ab07..0000000
> > --- a/arch/arm/mach-s3c64xx/cpuidle.c
> > +++ /dev/null
> 
> [...]
> 
> > diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> > index 6436c67..eed221e 100644
> > --- a/drivers/cpuidle/Makefile
> > +++ b/drivers/cpuidle/Makefile
> > @@ -31,4 +31,7 @@ ifeq ($(CONFIG_ARCH_OMAP4),y)
> >  	ccflags-y += -I$(srctree)/arch/arm/mach-omap2/include
> >  	obj-y += cpuidle-omap44xx.o
> >  endif
> > +ifeq ($(CONFIG_ARCH_S3C64XX),y)
> > +	obj-y += cpuidle-s3c64xx.o
> > +endif
> 
> I think, adding CONFIG_CPU_IDLE_S3C64XX like others, Calexeda, Zynq is
> better...?
> 
> >  obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
> > diff --git a/drivers/cpuidle/cpuidle-s3c64xx.c
> b/drivers/cpuidle/cpuidle-
> > s3c64xx.c
> > new file mode 100644
> > index 0000000..c18d075
> > --- /dev/null
> > +++ b/drivers/cpuidle/cpuidle-s3c64xx.c
> 
> [...]
> 
> > --
> > 1.8.2.3
> 
> Thanks,
> Kukjin

