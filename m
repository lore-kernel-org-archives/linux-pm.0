From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 1/2] ARM: imx: add select on ARCH_MXC for cpufreq
 support
Date: Mon, 13 Jan 2014 14:01:04 +0800
Message-ID: <20140113060102.GO23525@S2101-09.ap.freescale.net>
References: <1389321592-33220-1-git-send-email-john.tobias.ph@gmail.com>
 <20140113032043.GF23525@S2101-09.ap.freescale.net>
 <CACUGKYMx_o6TLsvMxK3Gb+cmOUCX3Toj+6MeJmo=ahfyc=vXCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACUGKYMx_o6TLsvMxK3Gb+cmOUCX3Toj+6MeJmo=ahfyc=vXCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<kernel@pengutronix.de>" <kernel@pengutronix.de>, "<linux@arm.linux.org.uk>" <linux@arm.linux.org.uk>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, Fabio Estevam <festevam@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Jan 12, 2014 at 08:54:18PM -0800, John Tobias wrote:
> I tested leaving the HAVE_IMX_ANATOP under SOC_IMX6Q and SOC_IMX6SL.
> The iMX6Q cpufreq driver won't show up in menu config / gconfig and
> that's the reason why I added it.

I tested the following changes against my for-next branch, and I can see
iMX6Q cpufreq driver in menuconfig.  Note, the
drivers/cpufreq/Kconfig.arm change is on cpufreq tree, so I have to make
the change locally for the testing.

Shawn

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 1e70150..7071468 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,5 +1,7 @@
 config ARCH_MXC
        bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 ||
ARCH_MULTI_V6_V7
+       select ARCH_HAS_CPUFREQ
+       select ARCH_HAS_OPP
        select ARCH_REQUIRE_GPIOLIB
        select ARM_CPU_SUSPEND if PM
        select ARM_PATCH_PHYS_VIRT
@@ -12,6 +14,7 @@ config ARCH_MXC
        select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
        select MULTI_IRQ_HANDLER
        select PINCTRL
+       select PM_OPP if PM
        select SOC_BUS
        select SPARSE_IRQ
        select USE_OF
@@ -787,8 +790,6 @@ config      SOC_IMX53

 config SOC_IMX6Q
        bool "i.MX6 Quad/DualLite support"
-       select ARCH_HAS_CPUFREQ
-       select ARCH_HAS_OPP
        select ARM_ERRATA_754322
        select ARM_ERRATA_764369 if SMP
        select ARM_ERRATA_775420
@@ -808,7 +809,6 @@ config SOC_IMX6Q
        select PL310_ERRATA_588369 if CACHE_PL310
        select PL310_ERRATA_727915 if CACHE_PL310
        select PL310_ERRATA_769419 if CACHE_PL310
-       select PM_OPP if PM

        help
          This enables support for Freescale i.MX6 Quad processor.
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index ce52ed9..21e069e 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -80,7 +80,7 @@ config ARM_HIGHBANK_CPUFREQ

 config ARM_IMX6Q_CPUFREQ
        tristate "Freescale i.MX6Q cpufreq support"
-       depends on SOC_IMX6Q
+       depends on ARCH_MXC
        depends on REGULATOR_ANATOP
        help
          This adds cpufreq driver support for Freescale i.MX6Q SOC.
