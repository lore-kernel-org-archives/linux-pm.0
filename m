From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/3] mfd: intel_soc_pmic: Fix a mess with compilation
 units
Date: Thu, 23 Mar 2017 12:12:52 +0000
Message-ID: <20170323121252.vi7oggwr6bfghe3b@dell>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38066 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdCWMM6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 08:12:58 -0400
Received: by mail-wm0-f45.google.com with SMTP id t189so61271228wmt.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 05:12:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On Fri, 17 Mar 2017, Andy Shevchenko wrote:

> Crystal Cove and Whiskey Cove are two different PMICs which are
> installed on Intel Atom SoC based platforms.
> 
> Moreover there are two independent drivers that by some reason were
> supposed (*) to get into one kernel module.
> 
> Fix the mess by clarifying Kconfig option for Crystal Cove and split
> Whiskey Cove out of it.
> 
> (*) It looks like the configuration was never tested with
>     INTEL_SOC_PMIC=n. The line in Makefile is actually wrong.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
> Cc: Linus Walleij <linus.walleij@linaro.org> (maintainer:GPIO SUBSYSTEM)
> Cc: Zhang Rui <rui.zhang@intel.com> (supporter:THERMAL)
> Cc: Eduardo Valentin <edubezval@gmail.com> (supporter:THERMAL)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - make option visible
> - fix dependencies
>  drivers/acpi/Kconfig         |  2 +-

This needs an ACPI Ack before I can do anything with it.

>  drivers/gpio/Kconfig         |  2 +-
>  drivers/mfd/Kconfig          | 14 ++++++++++++--
>  drivers/mfd/Makefile         |  2 +-
>  drivers/platform/x86/Kconfig |  2 +-
>  drivers/thermal/Kconfig      |  2 +-
>  6 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 83e5f7e1a20d..03708e08fcb4 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -512,7 +512,7 @@ config XPOWER_PMIC_OPREGION
>  
>  config BXT_WC_PMIC_OPREGION
>  	bool "ACPI operation region support for BXT WhiskeyCove PMIC"
> -	depends on INTEL_SOC_PMIC
> +	depends on INTEL_SOC_PMIC_BXTWC
>  	help
>  	  This config adds ACPI operation region support for BXT WhiskeyCove PMIC.
>  
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 05043071fc98..9b1bcb4d0df7 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1054,7 +1054,7 @@ config GPIO_UCB1400
>  
>  config GPIO_WHISKEY_COVE
>  	tristate "GPIO support for Whiskey Cove PMIC"
> -	depends on (X86 || COMPILE_TEST) && INTEL_SOC_PMIC
> +	depends on (X86 || COMPILE_TEST) && INTEL_SOC_PMIC_BXTWC
>  	select GPIOLIB_IRQCHIP
>  	help
>  	  Support for GPIO pins on Whiskey Cove PMIC.
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 55ecdfb74d31..e43afb8956ea 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -425,18 +425,28 @@ config LPC_SCH
>  	  System Management Bus and General Purpose I/O.
>  
>  config INTEL_SOC_PMIC
> -	bool "Support for Intel Atom SoC PMIC"
> +	bool "Support for Crystal Cove PMIC"
>  	depends on GPIOLIB
>  	depends on I2C=y
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
>  	help
> -	  Select this option to enable support for the PMIC device
> +	  Select this option to enable support for Crystal Cove PMIC
>  	  on some Intel SoC systems. The PMIC provides ADC, GPIO,
>  	  thermal, charger and related power management functions
>  	  on these systems.
>  
> +config INTEL_SOC_PMIC_BXTWC
> +	tristate "Support for Intel Broxton Whiskey Cove PMIC"
> +	select MFD_CORE
> +	select REGMAP_IRQ
> +	help
> +	  Select this option to enable support for Whiskey Cove PMIC
> +	  on Intel Broxton systems. The PMIC provides ADC, GPIO,
> +	  thermal, charger and related power management functions
> +	  on these systems.
> +
>  config MFD_INTEL_LPSS
>  	tristate
>  	select COMMON_CLK
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 31ce07611a6f..201aeaf5112a 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -207,8 +207,8 @@ obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
>  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
>  
>  intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
> -intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
> +obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index e1bffc9bb194..883fbe7a2466 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1019,7 +1019,7 @@ config INTEL_PMC_IPC
>  config INTEL_BXTWC_PMIC_TMU
>  	tristate "Intel BXT Whiskey Cove TMU Driver"
>  	depends on REGMAP
> -	depends on INTEL_SOC_PMIC && INTEL_PMC_IPC
> +	depends on INTEL_SOC_PMIC_BXTWC && INTEL_PMC_IPC
>  	---help---
>  	  Select this driver to use Intel BXT Whiskey Cove PMIC TMU feature.
>  	  This driver enables the alarm wakeup functionality in the TMU unit
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 776b34396144..751e50a3d946 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -365,7 +365,7 @@ endmenu
>  
>  config INTEL_BXT_PMIC_THERMAL
>  	tristate "Intel Broxton PMIC thermal driver"
> -	depends on X86 && INTEL_SOC_PMIC && REGMAP
> +	depends on X86 && INTEL_SOC_PMIC_BXTWC && REGMAP
>  	help
>  	  Select this driver for Intel Broxton PMIC with ADC channels monitoring
>  	  system temperature measurements and alerts.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
