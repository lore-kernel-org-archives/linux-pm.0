From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3 6/8] ARM: cpuidle: Enable the ARM64 driver for both
 ARM32/ARM64
Date: Sat, 21 Mar 2015 20:20:33 +0000
Message-ID: <20150321202033.GB22354@red-moon>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
 <1426851841-2072-7-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42847 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbbCUUU1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 21 Mar 2015 16:20:27 -0400
Content-Disposition: inline
In-Reply-To: <1426851841-2072-7-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>

On Fri, Mar 20, 2015 at 11:43:59AM +0000, Daniel Lezcano wrote:
> ARM32 and ARM64 have the same DT definitions and the same approaches.
> 
> The generic ARM cpuidle driver can be put in common for those two
> architectures.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Kevin Hilman <khilman@linaro.org>
> Acked-by: Rob Herring <robherring2@gmail.com>
> ---
>  drivers/cpuidle/Kconfig                            |  7 +------
>  drivers/cpuidle/Kconfig.arm                        | 12 +++++++++++-
>  drivers/cpuidle/Kconfig.arm64                      | 13 -------------
>  drivers/cpuidle/Makefile                           |  5 +----
>  drivers/cpuidle/{cpuidle-arm64.c => cpuidle-arm.c} |  0
>  5 files changed, 13 insertions(+), 24 deletions(-)
>  delete mode 100644 drivers/cpuidle/Kconfig.arm64
>  rename drivers/cpuidle/{cpuidle-arm64.c => cpuidle-arm.c} (100%)
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c5029c1..8c7930b 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -29,15 +29,10 @@ config DT_IDLE_STATES
>  	bool
>  
>  menu "ARM CPU Idle Drivers"
> -depends on ARM
> +depends on ARM || ARM64
>  source "drivers/cpuidle/Kconfig.arm"

Risk here is pulling in arm drivers on arm64, maybe it is better to
add a guard in Kconfig.arm to prevent pulling in ARM drivers (on ARM64)
instead of just doing that for Exynos.

>  endmenu
>  
> -menu "ARM64 CPU Idle Drivers"
> -depends on ARM64
> -source "drivers/cpuidle/Kconfig.arm64"
> -endmenu
> -
>  menu "MIPS CPU Idle Drivers"
>  depends on MIPS
>  source "drivers/cpuidle/Kconfig.mips"
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 8e07c94..1f067bd 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -14,6 +14,16 @@ config ARM_BIG_LITTLE_CPUIDLE
>  	  define different C-states for little and big cores through the
>  	  multiple CPU idle drivers infrastructure.
>  
> +config ARM_CPUIDLE

You have to update the arm64 defconfig.

> +	bool "Generic ARM/ARM64 CPU idle Driver"
> +	select DT_IDLE_STATES
> +	help
> +	  Select this to enable generic cpuidle driver for ARM.
> +	  It provides a generic idle driver whose idle states are configured
> +	  at run-time through DT nodes. The CPUidle suspend backend is
> +	  initialized by calling the CPU operations init idle hook
> +	  provided by architecture code.
> +
>  config ARM_CLPS711X_CPUIDLE
>  	bool "CPU Idle Driver for CLPS711X processors"
>  	depends on ARCH_CLPS711X || COMPILE_TEST

This for instance gets pulled in on allmodconfig on arm64, which is
not useful and possibly noxious.

> @@ -54,7 +64,7 @@ config ARM_AT91_CPUIDLE
>  
>  config ARM_EXYNOS_CPUIDLE
>  	bool "Cpu Idle Driver for the Exynos processors"
> -	depends on ARCH_EXYNOS
> +	depends on ARCH_EXYNOS && !ARM64

I would add a guard for all ARM drivers to prevent pulling them in
on ARM64.

With the above changes:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

>  	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>  	help
>  	  Select this to enable cpuidle for Exynos processors
> diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
> deleted file mode 100644
> index 6effb36..0000000
> --- a/drivers/cpuidle/Kconfig.arm64
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#
> -# ARM64 CPU Idle drivers
> -#
> -
> -config ARM64_CPUIDLE
> -	bool "Generic ARM64 CPU idle Driver"
> -	select DT_IDLE_STATES
> -	help
> -	  Select this to enable generic cpuidle driver for ARM64.
> -	  It provides a generic idle driver whose idle states are configured
> -	  at run-time through DT nodes. The CPUidle suspend backend is
> -	  initialized by calling the CPU operations init idle hook
> -	  provided by architecture code.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 4d177b9..3ba81b1 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -17,16 +17,13 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
>  obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
>  obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
>  obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
> +obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
>  
>  ###############################################################################
>  # MIPS drivers
>  obj-$(CONFIG_MIPS_CPS_CPUIDLE)		+= cpuidle-cps.o
>  
>  ###############################################################################
> -# ARM64 drivers
> -obj-$(CONFIG_ARM64_CPUIDLE)		+= cpuidle-arm64.o
> -
> -###############################################################################
>  # POWERPC drivers
>  obj-$(CONFIG_PSERIES_CPUIDLE)		+= cpuidle-pseries.o
>  obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm.c
> similarity index 100%
> rename from drivers/cpuidle/cpuidle-arm64.c
> rename to drivers/cpuidle/cpuidle-arm.c
> -- 
> 1.9.1
> 
> 
