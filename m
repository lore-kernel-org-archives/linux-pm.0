From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 3/5] clk: imx: add CPU clock type
Date: Fri, 26 Sep 2014 10:59:34 +0800
Message-ID: <20140926025933.GA31948@dragon>
References: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
 <1411143381-10516-4-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1on0134.outbound.protection.outlook.com ([157.56.110.134]:50660
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753214AbaIZDAB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Sep 2014 23:00:01 -0400
Content-Disposition: inline
In-Reply-To: <1411143381-10516-4-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, kernel@pengutronix.de

On Fri, Sep 19, 2014 at 06:16:19PM +0200, Lucas Stach wrote:
> From: Lucas Stach <dev@lynxeye.de>
> 
> This implements a virtual clock used to abstract away
> all the steps needed in order to change the ARM clock,
> so we don't have to push all this clock handling into
> the cpufreq driver.
> 
> While it will be used for i.MX53 at first it is generic
> enough to be used on i.MX6 later on.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>

Is this intentional to use a different email address than your usual
one?

> ---
>  arch/arm/mach-imx/Makefile  |   2 +-
>  arch/arm/mach-imx/clk-cpu.c | 104 ++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/clk.h     |   4 ++
>  3 files changed, 109 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-imx/clk-cpu.c
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index ac88599ca080..4d6071351f4f 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clk-imx31.o iomux-imx31.o ehci-
>  obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clk-imx35.o ehci-imx35.o pm-imx3.o
>  
>  imx5-pm-$(CONFIG_PM) += pm-imx5.o
> -obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o clk-imx51-imx53.o $(imx5-pm-y)
> +obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o clk-imx51-imx53.o clk-cpu.o $(imx5-pm-y)
>  
>  obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
>  			    clk-pfd.o clk-busy.o clk.o \
> diff --git a/arch/arm/mach-imx/clk-cpu.c b/arch/arm/mach-imx/clk-cpu.c
> new file mode 100644
> index 000000000000..ffba96228d3b
> --- /dev/null
> +++ b/arch/arm/mach-imx/clk-cpu.c
> @@ -0,0 +1,104 @@
> +/*
> + * Copyright (c) 2014 Lucas Stach <l.stach@pengutronix.de>, Pengutronix
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +
> +struct clk_cpu {
> +	struct clk_hw	hw;
> +	struct clk	*div, *mux, *pll, *step;

This is personal taste, so I'm not strong on this.  But I feel having
them on multiple lines makes the later addition/removal of struct clk
pointers a bit easier.

Other than these trivial comments, the patch looks good to me.

Shawn

> +};
