From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 04/18] ARM: imx: cpuidle: create separate drivers for
 imx5/imx6
Date: Fri, 12 Apr 2013 14:05:30 +0800
Message-ID: <20130412060527.GA16494@S2101-09.ap.freescale.net>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:44783
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751370Ab3DLGFU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 02:05:20 -0400
Content-Disposition: inline
In-Reply-To: <1365603743-5618-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On Wed, Apr 10, 2013 at 04:22:09PM +0200, Daniel Lezcano wrote:
> The code intializes the cpuidle driver at different places.
> The cpuidle driver for :
>   * imx5 : is in the pm-imx5.c, the init function is in cpuidle.c
>   * imx6 : is in cpuidle-imx6q.c, the init function is in cpuidle.c
>            and cpuidle-imx6q.c
> 
> Instead of having the cpuidle code spread across different files,
> let's write a driver for each SoC and make the code similar.
> 
> That implies some code duplication but that will be fixed with the
> next patches which consolidate the initialization for all the drivers.
> 
IMO, this is unnecessary churn.  I agree that we can have cpuidle-imx5.c
instead of carrying imx5 cpuidle code in pm-imx5.c.  But removing
cpuidle.c and duplicating what imx_cpuidle_init() does into imx5 and
imx6q driver is a step backward to me.

I suggest simply merging this patch into "[PATCH 18/18] ARM: imx:
cpuidle: use init/exit common routine"

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-imx/Makefile        |    1 +
>  arch/arm/mach-imx/cpuidle-imx5.c  |   74 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/cpuidle-imx6q.c |   36 ++++++++++++++++-
>  arch/arm/mach-imx/cpuidle.c       |   80 -------------------------------------
>  arch/arm/mach-imx/cpuidle.h       |   10 ++---
>  arch/arm/mach-imx/pm-imx5.c       |   29 +-------------
>  6 files changed, 115 insertions(+), 115 deletions(-)
>  create mode 100644 arch/arm/mach-imx/cpuidle-imx5.c
>  delete mode 100644 arch/arm/mach-imx/cpuidle.c
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index c4ce090..bfd5f5b 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
>  
>  ifeq ($(CONFIG_CPU_IDLE),y)
>  obj-y += cpuidle.o

This target should be removed, since arch/arm/mach-imx/cpuidle.c goes
away.

Shawn

> +obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
>  obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
>  endif

