From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 7/9] cpufreq: pxa2xx: move cpufreq driver to drivers/cpufreq
Date: Mon, 25 Mar 2013 15:41:38 +0530
Message-ID: <e4abaad7218d2a27f4f35131667868b3685acd70.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch moves cpufreq driver of ARM based pxa2xx platform to drivers/cpu=
freq.

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/Kconfig                                                   | 7 ---=
----
 arch/arm/mach-pxa/Makefile                                         | 5 ---=
--
 drivers/cpufreq/Makefile                                           | 2 ++
 .../mach-pxa/cpufreq-pxa2xx.c =3D> drivers/cpufreq/pxa2xx-cpufreq.c  | 2 -=
-
 4 files changed, 2 insertions(+), 14 deletions(-)
 rename arch/arm/mach-pxa/cpufreq-pxa2xx.c =3D> drivers/cpufreq/pxa2xx-cpuf=
req.c (99%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fbb9587..39c8a3b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2162,13 +2162,6 @@ config CPU_FREQ_SA1100
 config CPU_FREQ_SA1110
 =09bool
=20
-config CPU_FREQ_PXA
-=09bool
-=09depends on CPU_FREQ && ARCH_PXA && PXA25x
-=09default y
-=09select CPU_FREQ_DEFAULT_GOV_USERSPACE
-=09select CPU_FREQ_TABLE
-
 config CPU_FREQ_S3C
 =09bool
 =09help
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 929e700..648867a 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -7,11 +7,6 @@ obj-y=09=09=09=09+=3D clock.o devices.o generic.o irq.o \
 =09=09=09=09   time.o reset.o
 obj-$(CONFIG_PM)=09=09+=3D pm.o sleep.o standby.o
=20
-ifeq ($(CONFIG_CPU_FREQ),y)
-obj-$(CONFIG_PXA25x)=09=09+=3D cpufreq-pxa2xx.o
-obj-$(CONFIG_PXA27x)=09=09+=3D cpufreq-pxa2xx.o
-endif
-
 # Generic drivers that other drivers may depend upon
=20
 # SoC-specific code
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index c5c276a..aa00ca4 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -56,6 +56,8 @@ obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)=09=09+=3D imx6q-cpufreq.o
 obj-$(CONFIG_ARM_INTEGRATOR)=09=09+=3D integrator-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)=09+=3D kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)=09+=3D omap-cpufreq.o
+obj-$(CONFIG_PXA25x)=09=09=09+=3D pxa2xx-cpufreq.o
+obj-$(CONFIG_PXA27x)=09=09=09+=3D pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)=09=09=09+=3D pxa3xx-cpufreq.o
 obj-$(CONFIG_ARM_S3C2416_CPUFREQ)=09+=3D s3c2416-cpufreq.o
 obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)=09+=3D s3c64xx-cpufreq.o
diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c b/drivers/cpufreq/pxa2xx-cp=
ufreq.c
similarity index 99%
rename from arch/arm/mach-pxa/cpufreq-pxa2xx.c
rename to drivers/cpufreq/pxa2xx-cpufreq.c
index f1ca4da..fe4c55b 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -1,6 +1,4 @@
 /*
- *  linux/arch/arm/mach-pxa/cpufreq-pxa2xx.c
- *
  *  Copyright (C) 2002,2003 Intrinsyc Software
  *
  * This program is free software; you can redistribute it and/or modify
--=20
1.7.12.rc2.18.g61b472e
