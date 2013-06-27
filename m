From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/8] ARM: OMAP: move cpuidle drivers to drivers/cpuidle/
Date: Thu, 27 Jun 2013 11:36:44 -0400
Message-ID: <51CC5C0C.2090505@ti.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
 <1372241747-21083-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, khilman@deeprootsystems.com, linus.walleij@linaro.org, nsekhar@ti.com, kgene.kim@samsung.com, daniel.lezcano@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, nicolas.ferre@atmel.com, Rajendra Nayak <rnayak@ti.com>, rjw@sisk.pl, horms@verge.net.au, ben-linux@fluff.org, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, "Kristo, Tero" <t-kristo@ti.com>, kyungmin.park@samsung.com, kernel@pengutronix.de, shawn.guo@linaro.org
List-Id: linux-pm@vger.kernel.org

(You have missed few CC's)

+Kevin, Tero, Rajendra

On Wednesday 26 June 2013 06:15 AM, Bartlomiej Zolnierkiewicz wrote:
> While at it:
> - remove file path from comment
> - fix whitespace issues
> 
> Compile tested only.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-omap2/Makefile       |   5 -
>  arch/arm/mach-omap2/cpuidle34xx.c  | 344 -------------------------------------
>  arch/arm/mach-omap2/cpuidle44xx.c  | 217 -----------------------
>  drivers/cpuidle/Makefile           |  10 ++
>  drivers/cpuidle/cpuidle-omap34xx.c | 342 ++++++++++++++++++++++++++++++++++++
>  drivers/cpuidle/cpuidle-omap44xx.c | 216 +++++++++++++++++++++++
>  6 files changed, 568 insertions(+), 566 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/cpuidle34xx.c
>  delete mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
>  create mode 100644 drivers/cpuidle/cpuidle-omap34xx.c
>  create mode 100644 drivers/cpuidle/cpuidle-omap44xx.c
> 

[..]

> diff --git a/drivers/cpuidle/cpuidle-omap44xx.c b/drivers/cpuidle/cpuidle-omap44xx.c
> new file mode 100644
> index 0000000..86b8a51
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-omap44xx.c
> @@ -0,0 +1,216 @@
> +/*
> + * OMAP4+ CPU idle Routines
> + *
> + * Copyright (C) 2011-2013 Texas Instruments, Inc.
> + * Santosh Shilimkar <santosh.shilimkar@ti.com>
> + * Rajendra Nayak <rnayak@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/export.h>
> +
> +#include <asm/cpuidle.h>
> +#include <asm/proc-fns.h>
> +
> +#include "../../arch/arm/mach-omap2/common.h"
> +#include "../../arch/arm/mach-omap2/pm.h"
> +#include "../../arch/arm/mach-omap2/prm.h"
> +#include "../../arch/arm/mach-omap2/clockdomain.h"
> +
We have discussed it already on the list in past. The
movement was pending exactly for above dependencies.

I let Kevin take a call but moving drivers with
such dependency with platform code is just not
right.

Regards,
Santosh
