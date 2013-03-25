From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/9] cpufreq: ARM: Arrange drivers in alphabetical order
Date: Mon, 25 Mar 2013 15:41:32 +0530
Message-ID: <e7b8875eff197c3baef8dd474ff167f9a27ccdc6.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Normally we keep drivers in alphabetical inside Kconfig and Makefile and ov=
er
time this was broken for ARM cpufreq drivers. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 116 ++++++++++++++++++++++------------------=
----
 drivers/cpufreq/Makefile    |  10 ++--
 2 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 030ddf6..b72a2b3 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -2,6 +2,64 @@
 # ARM CPU Frequency scaling drivers
 #
=20
+config ARM_EXYNOS_CPUFREQ
+=09bool "SAMSUNG EXYNOS SoCs"
+=09depends on ARCH_EXYNOS
+=09default y
+=09help
+=09  This adds the CPUFreq driver common part for Samsung
+=09  EXYNOS SoCs.
+
+=09  If in doubt, say N.
+
+config ARM_EXYNOS4210_CPUFREQ
+=09def_bool CPU_EXYNOS4210
+=09help
+=09  This adds the CPUFreq driver for Samsung EXYNOS4210
+=09  SoC (S5PV310 or S5PC210).
+
+config ARM_EXYNOS4X12_CPUFREQ
+=09def_bool (SOC_EXYNOS4212 || SOC_EXYNOS4412)
+=09help
+=09  This adds the CPUFreq driver for Samsung EXYNOS4X12
+=09  SoC (EXYNOS4212 or EXYNOS4412).
+
+config ARM_EXYNOS5250_CPUFREQ
+=09def_bool SOC_EXYNOS5250
+=09help
+=09  This adds the CPUFreq driver for Samsung EXYNOS5250
+=09  SoC.
+
+config ARM_HIGHBANK_CPUFREQ
+=09tristate "Calxeda Highbank-based"
+=09depends on ARCH_HIGHBANK
+=09select CPU_FREQ_TABLE
+=09select GENERIC_CPUFREQ_CPU0
+=09select PM_OPP
+=09select REGULATOR
+
+=09default m
+=09help
+=09  This adds the CPUFreq driver for Calxeda Highbank SoC
+=09  based boards.
+
+=09  If in doubt, say N.
+
+config ARM_IMX6Q_CPUFREQ
+=09tristate "Freescale i.MX6Q cpufreq support"
+=09depends on SOC_IMX6Q
+=09depends on REGULATOR_ANATOP
+=09help
+=09  This adds cpufreq driver support for Freescale i.MX6Q SOC.
+
+=09  If in doubt, say N.
+
+config ARM_KIRKWOOD_CPUFREQ
+=09def_bool ARCH_KIRKWOOD && OF
+=09help
+=09  This adds the CPUFreq driver for Marvell Kirkwood
+=09  SoCs.
+
 config ARM_OMAP2PLUS_CPUFREQ
 =09bool "TI OMAP2+"
 =09depends on ARCH_OMAP2PLUS
@@ -49,67 +107,9 @@ config ARM_S5PV210_CPUFREQ
=20
 =09  If in doubt, say N.
=20
-config ARM_EXYNOS_CPUFREQ
-=09bool "SAMSUNG EXYNOS SoCs"
-=09depends on ARCH_EXYNOS
-=09default y
-=09help
-=09  This adds the CPUFreq driver common part for Samsung
-=09  EXYNOS SoCs.
-
-=09  If in doubt, say N.
-
-config ARM_EXYNOS4210_CPUFREQ
-=09def_bool CPU_EXYNOS4210
-=09help
-=09  This adds the CPUFreq driver for Samsung EXYNOS4210
-=09  SoC (S5PV310 or S5PC210).
-
-config ARM_EXYNOS4X12_CPUFREQ
-=09def_bool (SOC_EXYNOS4212 || SOC_EXYNOS4412)
-=09help
-=09  This adds the CPUFreq driver for Samsung EXYNOS4X12
-=09  SoC (EXYNOS4212 or EXYNOS4412).
-
-config ARM_EXYNOS5250_CPUFREQ
-=09def_bool SOC_EXYNOS5250
-=09help
-=09  This adds the CPUFreq driver for Samsung EXYNOS5250
-=09  SoC.
-
-config ARM_KIRKWOOD_CPUFREQ
-=09def_bool ARCH_KIRKWOOD && OF
-=09help
-=09  This adds the CPUFreq driver for Marvell Kirkwood
-=09  SoCs.
-
-config ARM_IMX6Q_CPUFREQ
-=09tristate "Freescale i.MX6Q cpufreq support"
-=09depends on SOC_IMX6Q
-=09depends on REGULATOR_ANATOP
-=09help
-=09  This adds cpufreq driver support for Freescale i.MX6Q SOC.
-
-=09  If in doubt, say N.
-
 config ARM_SPEAR_CPUFREQ
 =09bool "SPEAr CPUFreq support"
 =09depends on PLAT_SPEAR
 =09default y
 =09help
 =09  This adds the CPUFreq driver support for SPEAr SOCs.
-
-config ARM_HIGHBANK_CPUFREQ
-=09tristate "Calxeda Highbank-based"
-=09depends on ARCH_HIGHBANK
-=09select CPU_FREQ_TABLE
-=09select GENERIC_CPUFREQ_CPU0
-=09select PM_OPP
-=09select REGULATOR
-
-=09default m
-=09help
-=09  This adds the CPUFreq driver for Calxeda Highbank SoC
-=09  based boards.
-
-=09  If in doubt, say N.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 863fd18..e33a30e 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -45,18 +45,18 @@ obj-$(CONFIG_X86_INTEL_PSTATE)=09=09+=3D intel_pstate.o
 ##########################################################################=
########
 # ARM SoC drivers
 obj-$(CONFIG_UX500_SOC_DB8500)=09=09+=3D dbx500-cpufreq.o
-obj-$(CONFIG_ARM_S3C2416_CPUFREQ)=09+=3D s3c2416-cpufreq.o
-obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)=09+=3D s3c64xx-cpufreq.o
-obj-$(CONFIG_ARM_S5PV210_CPUFREQ)=09+=3D s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)=09+=3D exynos-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)=09+=3D exynos4210-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)=09+=3D exynos4x12-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)=09+=3D exynos5250-cpufreq.o
+obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)=09+=3D highbank-cpufreq.o
+obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)=09=09+=3D imx6q-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)=09+=3D kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)=09+=3D omap-cpufreq.o
+obj-$(CONFIG_ARM_S3C2416_CPUFREQ)=09+=3D s3c2416-cpufreq.o
+obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)=09+=3D s3c64xx-cpufreq.o
+obj-$(CONFIG_ARM_S5PV210_CPUFREQ)=09+=3D s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)=09=09+=3D spear-cpufreq.o
-obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)=09+=3D highbank-cpufreq.o
-obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)=09=09+=3D imx6q-cpufreq.o
=20
 ##########################################################################=
########
 # PowerPC platform drivers
--=20
1.7.12.rc2.18.g61b472e
