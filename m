From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/8] ARM: OMAP: move cpuidle drivers to drivers/cpuidle/
Date: Thu, 27 Jun 2013 01:06:54 -0700
Message-ID: <20130627080653.GH5523@atomide.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
 <1372241747-21083-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1372241747-21083-5-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kevin Hilman <khilman@linaro.org>
Cc: kgene.kim@samsung.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, khilman@deeprootsystems.com, nsekhar@ti.com, linus.walleij@linaro.org, swarren@wwwdotorg.org, magnus.damm@gmail.com, nicolas.ferre@atmel.com, linux@maxim.org.za, rjw@sisk.pl, kyungmin.park@samsung.com, horms@verge.net.au, srinidhi.kasagar@stericsson.com, ben-linux@fluff.org, shawn.guo@linaro.org, plagnioj@jcrosoft.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

* Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> [130626 12:25]:
> While at it:
> - remove file path from comment
> - fix whitespace issues
> 
> Compile tested only.
...

> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-omap34xx.c
> @@ -0,0 +1,342 @@
> +/*
> + * OMAP3 CPU IDLE Routines
> + *
> + * Copyright (C) 2008 Texas Instruments, Inc.
> + * Rajendra Nayak <rnayak@ti.com>
> + *
> + * Copyright (C) 2007 Texas Instruments, Inc.
> + * Karthik Dasu <karthik-dp@ti.com>
> + *
> + * Copyright (C) 2006 Nokia Corporation
> + * Tony Lindgren <tony@atomide.com>
> + *
> + * Copyright (C) 2005 Texas Instruments, Inc.
> + * Richard Woodruff <r-woodruff2@ti.com>
> + *
> + * Based on pm.c for omap2
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/cpuidle.h>
> +#include <linux/export.h>
> +#include <linux/cpu_pm.h>
> +#include <asm/cpuidle.h>
> +
> +#include "../../arch/arm/mach-omap2/powerdomain.h"
> +#include "../../arch/arm/mach-omap2/clockdomain.h"
> +
> +#include "../../arch/arm/mach-omap2/pm.h"
> +#include "../../arch/arm/mach-omap2/control.h"
> +#include "../../arch/arm/mach-omap2/common.h"

Do we really want to do includes like this from drivers?
Presumably these will go away with DT, but still.

Kevin, any comments?

Regards,

Tony
