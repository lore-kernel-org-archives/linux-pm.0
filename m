From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6/9] cpufreq: pxa3xx: move cpufreq driver to drivers/cpufreq
Date: Mon, 25 Mar 2013 15:41:37 +0530
Message-ID: <2aa937c3d81776f01c2c1d6fcfcb08ba74163b53.1364205812.git.viresh.kumar@linaro.org>
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

This patch moves cpufreq driver of ARM based pxa3xx platform to drivers/cpu=
freq.

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-pxa/Makefile                                           | 1 -
 arch/arm/mach-pxa/include/mach/generic.h                             | 1 +
 drivers/cpufreq/Makefile                                             | 1 +
 .../mach-pxa/cpufreq-pxa3xx.c =3D> drivers/cpufreq/pxa3xx-cpufreq.c    | 5=
 +----
 4 files changed, 3 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/generic.h
 rename arch/arm/mach-pxa/cpufreq-pxa3xx.c =3D> drivers/cpufreq/pxa3xx-cpuf=
req.c (98%)

diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 12c5005..929e700 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_PM)=09=09+=3D pm.o sleep.o standby.o
 ifeq ($(CONFIG_CPU_FREQ),y)
 obj-$(CONFIG_PXA25x)=09=09+=3D cpufreq-pxa2xx.o
 obj-$(CONFIG_PXA27x)=09=09+=3D cpufreq-pxa2xx.o
-obj-$(CONFIG_PXA3xx)=09=09+=3D cpufreq-pxa3xx.o
 endif
=20
 # Generic drivers that other drivers may depend upon
diff --git a/arch/arm/mach-pxa/include/mach/generic.h b/arch/arm/mach-pxa/i=
nclude/mach/generic.h
new file mode 100644
index 0000000..665542e
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/generic.h
@@ -0,0 +1 @@
+#include "../../generic.h"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 170f01a..c5c276a 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)=09=09+=3D imx6q-cpufreq.o
 obj-$(CONFIG_ARM_INTEGRATOR)=09=09+=3D integrator-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)=09+=3D kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)=09+=3D omap-cpufreq.o
+obj-$(CONFIG_PXA3xx)=09=09=09+=3D pxa3xx-cpufreq.o
 obj-$(CONFIG_ARM_S3C2416_CPUFREQ)=09+=3D s3c2416-cpufreq.o
 obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)=09+=3D s3c64xx-cpufreq.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)=09+=3D s5pv210-cpufreq.o
diff --git a/arch/arm/mach-pxa/cpufreq-pxa3xx.c b/drivers/cpufreq/pxa3xx-cp=
ufreq.c
similarity index 98%
rename from arch/arm/mach-pxa/cpufreq-pxa3xx.c
rename to drivers/cpufreq/pxa3xx-cpufreq.c
index 8c45b2b..15d60f8 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa3xx.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -1,6 +1,4 @@
 /*
- * linux/arch/arm/mach-pxa/cpufreq-pxa3xx.c
- *
  * Copyright (C) 2008 Marvell International Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -17,10 +15,9 @@
 #include <linux/slab.h>
 #include <linux/io.h>
=20
+#include <mach/generic.h>
 #include <mach/pxa3xx-regs.h>
=20
-#include "generic.h"
-
 #define HSS_104M=09(0)
 #define HSS_156M=09(1)
 #define HSS_208M=09(2)
--=20
1.7.12.rc2.18.g61b472e
