From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC v2 02/11] soc: renesas: Move pm-rcar to drivers/soc/renesas/
Date: Tue, 16 Feb 2016 00:12:52 +0200
Message-ID: <2551067.YVPTHA6AER@avalon>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be> <1455571020-18968-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:56582 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbcBOWMY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 17:12:24 -0500
In-Reply-To: <1455571020-18968-3-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 15 February 2016 22:16:51 Geert Uytterhoeven wrote:
> Move the pm-rcar driver to drivers/soc/renesas/, so it can be shared
> between arm32 (R-Car H1 and Gen2) and arm64 (R-Car Gen3).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
>   - New.
> ---
> arch/arm/mach-shmobile/Kconfig                                  | 8 ++-----
> arch/arm/mach-shmobile/Makefile                                 | 1 -
> arch/arm/mach-shmobile/pm-r8a7779.c                             | 3 ++-
> arch/arm/mach-shmobile/pm-rcar-gen2.c                           | 2 +-
> arch/arm/mach-shmobile/smp-r8a7779.c                            | 2 +-
> arch/arm/mach-shmobile/smp-r8a7790.c                            | 2 +-
> drivers/soc/Kconfig                                             | 1 +
> drivers/soc/Makefile                                            | 3 ++-
> drivers/soc/renesas/Kconfig                                     | 8 ++++++++
> drivers/soc/renesas/Makefile                                    | 1 +
> {arch/arm/mach-shmobile => drivers/soc/renesas}/pm-rcar.c       | 2 +-
> {arch/arm/mach-shmobile => include/linux/soc/renesas}/pm-rcar.h | 2 ++
> 12 files changed, 22 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/soc/renesas/Kconfig
>  create mode 100644 drivers/soc/renesas/Makefile
>  rename {arch/arm/mach-shmobile => drivers/soc/renesas}/pm-rcar.c (99%)
>  rename {arch/arm/mach-shmobile => include/linux/soc/renesas}/pm-rcar.h
> (93%)
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index cd5f171f83ce6420..e45479d5104ea91a 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -4,23 +4,19 @@ config ARCH_SHMOBILE
>  config ARCH_SHMOBILE_MULTI
>  	bool
> 
> -config PM_RCAR
> -	bool
> -	select PM_GENERIC_DOMAINS if PM
> -
>  config PM_RMOBILE
>  	bool
>  	select PM_GENERIC_DOMAINS
> 
>  config ARCH_RCAR_GEN1
>  	bool
> -	select PM_RCAR if PM || SMP
> +	select RENESAS_RCAR_PM if PM || SMP
>  	select RENESAS_INTC_IRQPIN
>  	select SYS_SUPPORTS_SH_TMU
> 
>  config ARCH_RCAR_GEN2
>  	bool
> -	select PM_RCAR if PM || SMP
> +	select RENESAS_RCAR_PM if PM || SMP
>  	select RENESAS_IRQC
>  	select SYS_SUPPORTS_SH_CMT
>  	select PCI_DOMAINS if PCI
> diff --git a/arch/arm/mach-shmobile/Makefile
> b/arch/arm/mach-shmobile/Makefile index a65c80ac9009d51f..ebb909c55b856a58
> 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -39,7 +39,6 @@ smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o
> platsmp-scu.o # PM objects
>  obj-$(CONFIG_SUSPEND)		+= suspend.o
>  obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
> -obj-$(CONFIG_PM_RCAR)		+= pm-rcar.o
>  obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
>  obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
> 
> diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c
> b/arch/arm/mach-shmobile/pm-r8a7779.c index
> 14c42a1bdf1ef20d..314cc47738252ae6 100644
> --- a/arch/arm/mach-shmobile/pm-r8a7779.c
> +++ b/arch/arm/mach-shmobile/pm-r8a7779.c
> @@ -9,9 +9,10 @@
>   * for more details.
>   */
> 
> +#include <linux/soc/renesas/pm-rcar.h>
> +
>  #include <asm/io.h>
> 
> -#include "pm-rcar.h"
>  #include "r8a7779.h"
> 
>  /* SYSC */
> diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c
> b/arch/arm/mach-shmobile/pm-rcar-gen2.c index
> 6815781ad1165ef3..13ef9a8f5bf74090 100644
> --- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
> @@ -13,9 +13,9 @@
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/smp.h>
> +#include <linux/soc/renesas/pm-rcar.h>
>  #include <asm/io.h>
>  #include "common.h"
> -#include "pm-rcar.h"
>  #include "rcar-gen2.h"
> 
>  /* RST */
> diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c
> b/arch/arm/mach-shmobile/smp-r8a7779.c index
> f5c31fbc10b2efbf..12e4804a1985012e 100644
> --- a/arch/arm/mach-shmobile/smp-r8a7779.c
> +++ b/arch/arm/mach-shmobile/smp-r8a7779.c
> @@ -19,13 +19,13 @@
>  #include <linux/spinlock.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> +#include <linux/soc/renesas/pm-rcar.h>
> 
>  #include <asm/cacheflush.h>
>  #include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
> 
>  #include "common.h"
> -#include "pm-rcar.h"
>  #include "r8a7779.h"
> 
>  #define AVECR IOMEM(0xfe700040)
> diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c
> b/arch/arm/mach-shmobile/smp-r8a7790.c index
> f6426c6fdefcb489..79a0f7b86ce9149a 100644
> --- a/arch/arm/mach-shmobile/smp-r8a7790.c
> +++ b/arch/arm/mach-shmobile/smp-r8a7790.c
> @@ -17,12 +17,12 @@
>  #include <linux/init.h>
>  #include <linux/smp.h>
>  #include <linux/io.h>
> +#include <linux/soc/renesas/pm-rcar.h>
> 
>  #include <asm/smp_plat.h>
> 
>  #include "common.h"
>  #include "platsmp-apmu.h"
> -#include "pm-rcar.h"
>  #include "rcar-gen2.h"
>  #include "r8a7790.h"
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 88260205a2614c84..5d76c14ef98cdc26 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -5,6 +5,7 @@ source "drivers/soc/brcmstb/Kconfig"
>  source "drivers/soc/fsl/qe/Kconfig"
>  source "drivers/soc/mediatek/Kconfig"
>  source "drivers/soc/qcom/Kconfig"
> +source "drivers/soc/renesas/Kconfig"
>  source "drivers/soc/rockchip/Kconfig"
>  source "drivers/soc/sunxi/Kconfig"
>  source "drivers/soc/tegra/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 2afdc74f7491adf0..298ee4157bb6d9a0 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -9,7 +9,8 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
>  obj-y				+= fsl/
>  obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
>  obj-$(CONFIG_ARCH_QCOM)		+= qcom/
> -obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
> +obj-$(CONFIG_ARCH_RENESAS)	+= renesas/
> +obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
>  obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
>  obj-$(CONFIG_SOC_TI)		+= ti/
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> new file mode 100644
> index 0000000000000000..b2e4d31555c285f0
> --- /dev/null
> +++ b/drivers/soc/renesas/Kconfig
> @@ -0,0 +1,8 @@
> +#
> +# Renesas SoC drivers
> +#
> +
> +config RENESAS_RCAR_PM
> +	bool
> +	select PM_GENERIC_DOMAINS if PM
> +	default y if ARCH_RENESAS && ARM64
> diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
> new file mode 100644
> index 0000000000000000..36b8aedf2ef4195f
> --- /dev/null
> +++ b/drivers/soc/renesas/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_RENESAS_RCAR_PM)	+= pm-rcar.o
> diff --git a/arch/arm/mach-shmobile/pm-rcar.c
> b/drivers/soc/renesas/pm-rcar.c similarity index 99%
> rename from arch/arm/mach-shmobile/pm-rcar.c
> rename to drivers/soc/renesas/pm-rcar.c
> index 0af05d288b09c3ab..bc605d9fbc6ce79c 100644
> --- a/arch/arm/mach-shmobile/pm-rcar.c
> +++ b/drivers/soc/renesas/pm-rcar.c
> @@ -13,7 +13,7 @@
>  #include <linux/mm.h>
>  #include <linux/spinlock.h>
>  #include <linux/io.h>
> -#include "pm-rcar.h"
> +#include <linux/soc/renesas/pm-rcar.h>
> 
>  /* SYSC Common */
>  #define SYSCSR			0x00	/* SYSC Status Register */
> diff --git a/arch/arm/mach-shmobile/pm-rcar.h
> b/include/linux/soc/renesas/pm-rcar.h similarity index 93%
> rename from arch/arm/mach-shmobile/pm-rcar.h
> rename to include/linux/soc/renesas/pm-rcar.h
> index 1b901db4a24c4633..bfeb647ffd9d2e12 100644
> --- a/arch/arm/mach-shmobile/pm-rcar.h
> +++ b/include/linux/soc/renesas/pm-rcar.h
> @@ -1,6 +1,8 @@
>  #ifndef PM_RCAR_H
>  #define PM_RCAR_H
> 
> +#include <linux/types.h>
> +
>  struct rcar_sysc_ch {
>  	u16 chan_offs;
>  	u8 chan_bit;

-- 
Regards,

Laurent Pinchart

