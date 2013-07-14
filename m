From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq
Date: Mon, 15 Jul 2013 01:26:03 +0200
Message-ID: <1429422.16N7g1KiV4@vostro.rjw.lan>
References: <1372841395-30891-1-git-send-email-kpark3469@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42681 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422Ab3GNXQO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 14 Jul 2013 19:16:14 -0400
In-Reply-To: <1372841395-30891-1-git-send-email-kpark3469@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kpark3469@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, keun-o.park@windriver.com

On Wednesday, July 03, 2013 05:49:55 PM kpark3469@gmail.com wrote:
> From: Sahara <keun-o.park@windriver.com>
> 
> This patch adds Kconfig.arm for cpuidle drivers for ARM. And, this
> also moves calxeda, kirkwood and zynq to Kconfig.arm. Like cpufreq
> menu, "CPU Idle" menu is added to drivers/cpuidle/Kconfig.
> 
> Signed-off-by: Sahara <keun-o.park@windriver.com>

Daniel: Yes, no, maybe?

Rafael


> ---
>  drivers/cpuidle/Kconfig     |   19 +++++++------------
>  drivers/cpuidle/Kconfig.arm |   21 +++++++++++++++++++++
>  drivers/cpuidle/Makefile    |    8 +++++---
>  3 files changed, 33 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/cpuidle/Kconfig.arm
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 81de5d9..b3fb81d 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -1,5 +1,6 @@
> +menu "CPU Idle"
>  
> -menuconfig CPU_IDLE
> +config CPU_IDLE
>  	bool "CPU idle PM support"
>  	default y if ACPI || PPC_PSERIES
>  	select CPU_IDLE_GOV_LADDER if (!NO_HZ && !NO_HZ_IDLE)
> @@ -29,19 +30,13 @@ config CPU_IDLE_GOV_MENU
>  	bool "Menu governor (for tickless system)"
>  	default y
>  
> -config CPU_IDLE_CALXEDA
> -	bool "CPU Idle Driver for Calxeda processors"
> -	depends on ARCH_HIGHBANK
> -	help
> -	  Select this to enable cpuidle on Calxeda processors.
> -
> -config CPU_IDLE_ZYNQ
> -	bool "CPU Idle Driver for Xilinx Zynq processors"
> -	depends on ARCH_ZYNQ
> -	help
> -	  Select this to enable cpuidle on Xilinx Zynq processors.
> +menu "ARM CPU Idle Drivers"
> +depends on ARM
> +source "drivers/cpuidle/Kconfig.arm"
> +endmenu
>  
>  endif
>  
>  config ARCH_NEEDS_CPU_IDLE_COUPLED
>  	def_bool n
> +endmenu
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> new file mode 100644
> index 0000000..df69259
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -0,0 +1,21 @@
> +#
> +# ARM CPU Idle drivers
> +#
> +
> +config ARM_HIGHBANK_CPUIDLE
> +	bool "CPU Idle Driver for Calxeda processors"
> +	depends on ARCH_HIGHBANK
> +	help
> +	  Select this to enable cpuidle on Calxeda processors.
> +
> +config ARM_KIRKWOOD_CPUIDLE
> +	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
> +	depends on ARCH_KIRKWOOD
> +	help
> +	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
> +
> +config ARM_ZYNQ_CPUIDLE
> +	bool "CPU Idle Driver for Xilinx Zynq processors"
> +	depends on ARCH_ZYNQ
> +	help
> +	  Select this to enable cpuidle on Xilinx Zynq processors.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 8767a7b..77cf767 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -5,6 +5,8 @@
>  obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
>  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>  
> -obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
> -obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
> -obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
> +##################################################################################
> +# ARM SoC drivers
> +obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
> +obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
> +obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
