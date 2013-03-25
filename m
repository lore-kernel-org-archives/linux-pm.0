From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/9] cpufreq: integrator: move cpufreq driver to drivers/cpufreq
Date: Mon, 25 Mar 2013 15:41:36 +0530
Message-ID: <fae1030e861c5dfd00df8f03526b0bdc5156de4d.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch moves cpufreq driver of ARM based integrator platform to
drivers/cpufreq.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/Kconfig                                              | 11 -------=
----
 arch/arm/mach-integrator/Makefile                             |  1 -
 drivers/cpufreq/Kconfig.arm                                   |  8 +++++++=
+
 drivers/cpufreq/Makefile                                      |  1 +
 .../cpu.c =3D> drivers/cpufreq/integrator-cpufreq.c             |  2 --
 5 files changed, 9 insertions(+), 14 deletions(-)
 rename arch/arm/mach-integrator/cpu.c =3D> drivers/cpufreq/integrator-cpuf=
req.c (99%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0295a08..fbb9587 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2162,17 +2162,6 @@ config CPU_FREQ_SA1100
 config CPU_FREQ_SA1110
 =09bool
=20
-config CPU_FREQ_INTEGRATOR
-=09tristate "CPUfreq driver for ARM Integrator CPUs"
-=09depends on ARCH_INTEGRATOR && CPU_FREQ
-=09default y
-=09help
-=09  This enables the CPUfreq driver for ARM Integrator CPUs.
-
-=09  For details, take a look at <file:Documentation/cpu-freq>.
-
-=09  If in doubt, say Y.
-
 config CPU_FREQ_PXA
 =09bool
 =09depends on CPU_FREQ && ARCH_PXA && PXA25x
diff --git a/arch/arm/mach-integrator/Makefile b/arch/arm/mach-integrator/M=
akefile
index 5521d18..d14d6b7 100644
--- a/arch/arm/mach-integrator/Makefile
+++ b/arch/arm/mach-integrator/Makefile
@@ -9,5 +9,4 @@ obj-$(CONFIG_ARCH_INTEGRATOR_AP)=09+=3D integrator_ap.o
 obj-$(CONFIG_ARCH_INTEGRATOR_CP)=09+=3D integrator_cp.o
=20
 obj-$(CONFIG_PCI)=09=09=09+=3D pci_v3.o pci.o
-obj-$(CONFIG_CPU_FREQ_INTEGRATOR)=09+=3D cpu.o
 obj-$(CONFIG_INTEGRATOR_IMPD1)=09=09+=3D impd1.o
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 3d83bc5..a345e20 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -61,6 +61,14 @@ config ARM_IMX6Q_CPUFREQ
=20
 =09  If in doubt, say N.
=20
+config ARM_INTEGRATOR
+=09tristate "CPUfreq driver for ARM Integrator CPUs"
+=09depends on ARCH_INTEGRATOR
+=09default y
+=09help
+=09  This enables the CPUfreq driver for ARM Integrator CPUs.
+=09  If in doubt, say Y.
+
 config ARM_KIRKWOOD_CPUFREQ
 =09def_bool ARCH_KIRKWOOD && OF
 =09help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 2759192..170f01a 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)=09+=3D exynos5250-cp=
ufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)=09+=3D highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX_CPUFREQ)=09=09+=3D imx-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)=09=09+=3D imx6q-cpufreq.o
+obj-$(CONFIG_ARM_INTEGRATOR)=09=09+=3D integrator-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)=09+=3D kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)=09+=3D omap-cpufreq.o
 obj-$(CONFIG_ARM_S3C2416_CPUFREQ)=09+=3D s3c2416-cpufreq.o
diff --git a/arch/arm/mach-integrator/cpu.c b/drivers/cpufreq/integrator-cp=
ufreq.c
similarity index 99%
rename from arch/arm/mach-integrator/cpu.c
rename to drivers/cpufreq/integrator-cpufreq.c
index df863c3..f7c99df 100644
--- a/arch/arm/mach-integrator/cpu.c
+++ b/drivers/cpufreq/integrator-cpufreq.c
@@ -1,6 +1,4 @@
 /*
- *  linux/arch/arm/mach-integrator/cpu.c
- *
  *  Copyright (C) 2001-2002 Deep Blue Solutions Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
--=20
1.7.12.rc2.18.g61b472e


