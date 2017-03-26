From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/3] mfd: intel_soc_pmic: Fix a mess with compilation
 units
Date: Sun, 26 Mar 2017 15:37:59 +0300
Message-ID: <1490531879.708.8.camel@linux.intel.com>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
         <20170323121252.vi7oggwr6bfghe3b@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170323121252.vi7oggwr6bfghe3b@dell>
Sender: linux-acpi-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-03-23 at 12:12 +0000, Lee Jones wrote:
> On Fri, 17 Mar 2017, Andy Shevchenko wrote:
> 
> > Crystal Cove and Whiskey Cove are two different PMICs which are
> > installed on Intel Atom SoC based platforms.
> > 
> > Moreover there are two independent drivers that by some reason were
> > supposed (*) to get into one kernel module.
> > 
> > Fix the mess by clarifying Kconfig option for Crystal Cove and split
> > Whiskey Cove out of it.
> > 
> > (*) It looks like the configuration was never tested with
> >     INTEL_SOC_PMIC=n. The line in Makefile is actually wrong.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
> > Cc: Linus Walleij <linus.walleij@linaro.org> (maintainer:GPIO
> > SUBSYSTEM)
> > Cc: Zhang Rui <rui.zhang@intel.com> (supporter:THERMAL)
> > Cc: Eduardo Valentin <edubezval@gmail.com> (supporter:THERMAL)
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > - make option visible
> > - fix dependencies
> >  drivers/acpi/Kconfig         |  2 +-
> 
> This needs an ACPI Ack before I can do anything with it.

Rafael, can you give you tag?

> 
> >  drivers/gpio/Kconfig         |  2 +-
> >  drivers/mfd/Kconfig          | 14 ++++++++++++--
> >  drivers/mfd/Makefile         |  2 +-
> >  drivers/platform/x86/Kconfig |  2 +-
> >  drivers/thermal/Kconfig      |  2 +-
> >  6 files changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index 83e5f7e1a20d..03708e08fcb4 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -512,7 +512,7 @@ config XPOWER_PMIC_OPREGION
> >  
> >  config BXT_WC_PMIC_OPREGION
> >  	bool "ACPI operation region support for BXT WhiskeyCove
> > PMIC"
> > -	depends on INTEL_SOC_PMIC
> > +	depends on INTEL_SOC_PMIC_BXTWC
> >  	help
> >  	  This config adds ACPI operation region support for BXT
> > WhiskeyCove PMIC.
> >  
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 05043071fc98..9b1bcb4d0df7 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -1054,7 +1054,7 @@ config GPIO_UCB1400
> >  
> >  config GPIO_WHISKEY_COVE
> >  	tristate "GPIO support for Whiskey Cove PMIC"
> > -	depends on (X86 || COMPILE_TEST) && INTEL_SOC_PMIC
> > +	depends on (X86 || COMPILE_TEST) && INTEL_SOC_PMIC_BXTWC
> >  	select GPIOLIB_IRQCHIP
> >  	help
> >  	  Support for GPIO pins on Whiskey Cove PMIC.
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 55ecdfb74d31..e43afb8956ea 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -425,18 +425,28 @@ config LPC_SCH
> >  	  System Management Bus and General Purpose I/O.
> >  
> >  config INTEL_SOC_PMIC
> > -	bool "Support for Intel Atom SoC PMIC"
> > +	bool "Support for Crystal Cove PMIC"
> >  	depends on GPIOLIB
> >  	depends on I2C=y
> >  	select MFD_CORE
> >  	select REGMAP_I2C
> >  	select REGMAP_IRQ
> >  	help
> > -	  Select this option to enable support for the PMIC device
> > +	  Select this option to enable support for Crystal Cove
> > PMIC
> >  	  on some Intel SoC systems. The PMIC provides ADC, GPIO,
> >  	  thermal, charger and related power management functions
> >  	  on these systems.
> >  
> > +config INTEL_SOC_PMIC_BXTWC
> > +	tristate "Support for Intel Broxton Whiskey Cove PMIC"
> > +	select MFD_CORE
> > +	select REGMAP_IRQ
> > +	help
> > +	  Select this option to enable support for Whiskey Cove
> > PMIC
> > +	  on Intel Broxton systems. The PMIC provides ADC, GPIO,
> > +	  thermal, charger and related power management functions
> > +	  on these systems.
> > +
> >  config MFD_INTEL_LPSS
> >  	tristate
> >  	select COMMON_CLK
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 31ce07611a6f..201aeaf5112a 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -207,8 +207,8 @@ obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
> >  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
> >  
> >  intel-soc-pmic-objs		:= intel_soc_pmic_core.o
> > intel_soc_pmic_crc.o
> > -intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+=
> > intel_soc_pmic_bxtwc.o
> >  obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
> > +obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
> >  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
> >  
> >  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> > diff --git a/drivers/platform/x86/Kconfig
> > b/drivers/platform/x86/Kconfig
> > index e1bffc9bb194..883fbe7a2466 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1019,7 +1019,7 @@ config INTEL_PMC_IPC
> >  config INTEL_BXTWC_PMIC_TMU
> >  	tristate "Intel BXT Whiskey Cove TMU Driver"
> >  	depends on REGMAP
> > -	depends on INTEL_SOC_PMIC && INTEL_PMC_IPC
> > +	depends on INTEL_SOC_PMIC_BXTWC && INTEL_PMC_IPC
> >  	---help---
> >  	  Select this driver to use Intel BXT Whiskey Cove PMIC TMU
> > feature.
> >  	  This driver enables the alarm wakeup functionality in the
> > TMU unit
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 776b34396144..751e50a3d946 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -365,7 +365,7 @@ endmenu
> >  
> >  config INTEL_BXT_PMIC_THERMAL
> >  	tristate "Intel Broxton PMIC thermal driver"
> > -	depends on X86 && INTEL_SOC_PMIC && REGMAP
> > +	depends on X86 && INTEL_SOC_PMIC_BXTWC && REGMAP
> >  	help
> >  	  Select this driver for Intel Broxton PMIC with ADC
> > channels monitoring
> >  	  system temperature measurements and alerts.
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
