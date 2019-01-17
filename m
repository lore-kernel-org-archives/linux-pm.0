From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
Date: Thu, 17 Jan 2019 15:51:07 +0530
Message-ID: <20190117102107.2n5liu325alisxhd@vireshk-i7>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7>
 <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Stephen Boyd <swboyd@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 17-01-19, 11:08, Rafael J. Wysocki wrote:
> On Thu, Jan 17, 2019 at 6:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > 1. Have following for CONFIG_CPU_FREQ
> >        depends on !CPU_THERMAL || THERMAL
> 
> Sorry, but this makes my teeth hurt.

I knew it :)

> >    The platforms which don't need CPU_THERMAL (like x86) should not
> >    enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.
> >
> >    @amit: If this gets accepted, please update the Kconfig entries for
> >    all those drivers to not have above lines anymore.
> >
> > - Change CONFIG_THERMAL to bool instead of tristate ?
> >
> > - Anything else ?
> 
> The design in the thermal subsystem seems to be upside-down.
> Non-modular code should never be made depend on anything only defined
> in a module.
> 
> Would an explicit "select THERMAL" under CPU_THERMAL cause THERMAL to be 'y'?

That causes recursive-dependency issues:

drivers/thermal/Kconfig:5:error: recursive dependency detected!
drivers/thermal/Kconfig:5:      symbol THERMAL is selected by CPU_THERMAL
drivers/thermal/Kconfig:16:     symbol CPU_THERMAL depends on THERMAL_OF
drivers/thermal/Kconfig:70:     symbol THERMAL_OF depends on THERMAL
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"

something like this works though:

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 30323426902e..ee9f9f2a795b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -13,6 +13,20 @@ menuconfig THERMAL
          All platforms with ACPI thermal support can use this driver.
          If you want this support, you should say Y or M here.
 
+config CPU_THERMAL
+       bool "generic cpu cooling support"
+       depends on CPU_FREQ
+       select THERMAL_OF
+       select THERMAL
+       help
+         This implements the generic cpu cooling mechanism through frequency
+         reduction. An ACPI version of this already exists
+         (drivers/acpi/processor_thermal.c).
+         This will be useful for platforms using the generic thermal interface
+         and not the ACPI interface.
+
+         If you want this support, you should say Y here.
+
 if THERMAL
 
 config THERMAL_STATISTICS
@@ -148,19 +162,6 @@ config THERMAL_GOV_POWER_ALLOCATOR
          Enable this to manage platform thermals by dynamically
          allocating and limiting power to devices.
 
-config CPU_THERMAL
-       bool "generic cpu cooling support"
-       depends on CPU_FREQ
-       depends on THERMAL_OF
-       help
-         This implements the generic cpu cooling mechanism through frequency
-         reduction. An ACPI version of this already exists
-         (drivers/acpi/processor_thermal.c).
-         This will be useful for platforms using the generic thermal interface
-         and not the ACPI interface.
-
-         If you want this support, you should say Y here.
-
 config CLOCK_THERMAL
        bool "Generic clock cooling support"
        depends on COMMON_CLK


What about make CONFIG_THERMAL bool instead ? Who wants it to be a module ?

$ git grep "CONFIG_THERMAL=m"
arch/arm/configs/mini2440_defconfig:CONFIG_THERMAL=m
arch/arm/configs/omap2plus_defconfig:CONFIG_THERMAL=m
arch/arm/configs/pxa_defconfig:CONFIG_THERMAL=m
arch/mips/configs/ip22_defconfig:CONFIG_THERMAL=m
arch/mips/configs/ip27_defconfig:CONFIG_THERMAL=m
arch/unicore32/configs/unicore32_defconfig:#CONFIG_THERMAL=m

Not sure if they really want this code out :(

-- 
viresh
