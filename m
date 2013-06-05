From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: move ARCH_NEEDS_CPU_IDLE_COUPLED Kconfig option
Date: Wed, 05 Jun 2013 14:50:44 +0200
Message-ID: <51AF3424.5060200@linaro.org>
References: <1460854.rT4b7LefMM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:44357 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329Ab3FEMuq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2013 08:50:46 -0400
Received: by mail-bk0-f54.google.com with SMTP id it19so870246bkc.13
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2013 05:50:44 -0700 (PDT)
In-Reply-To: <1460854.rT4b7LefMM@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org

On 06/05/2013 02:38 PM, Arnd Bergmann wrote:
> There is no reason why ARCH_NEEDS_CPU_IDLE_COUPLED needs to be
> hidden inside of "if CPU_IDLE", since it is a silent option.
> Moving it outside lets platforms select this symbol unconditionally,
> which avoid a warning from the ARM omap2plus_defconfig build:
>=20
> warning: (ARCH_OMAP4 && ARCH_TEGRA_2x_SOC) selects
> 	ARCH_NEEDS_CPU_IDLE_COUPLED which has unmet direct
> 	dependencies (CPU_IDLE)

IMHO, this option depends on CPU_IDLE and thus must be kept inside the
CPU_IDLE menuconfig.

The warning raised here is because this option is selected by the arch
Kconfig without checking if CPU_IDLE is set or not.

I am in favor to change the OMAP / TEGRA Kconfigs instead, in this way:

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f49cd51..831e89e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -83,7 +83,7 @@ config ARCH_OMAP4
        depends on ARCH_OMAP2PLUS
        depends on ARCH_MULTI_V7
        select ARCH_HAS_OPP
-       select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
+       select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
        select ARM_CPU_SUSPEND if PM
        select ARM_ERRATA_720789
        select ARM_GIC
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 84d72fc..04c6221 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -23,7 +23,7 @@ menu "NVIDIA Tegra options"

 config ARCH_TEGRA_2x_SOC
        bool "Enable support for Tegra20 family"
-       select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
+       select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
        select ARM_ERRATA_720789
        select ARM_ERRATA_754327 if SMP
        select ARM_ERRATA_764369 if SMP
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig

[ ... ]

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

