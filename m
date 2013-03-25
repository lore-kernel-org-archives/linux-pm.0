From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/9] cpufreq: tegra: Move driver to drivers/cpufreq
Date: Mon, 25 Mar 2013 15:41:33 +0530
Message-ID: <fb8f986f4f94109ad0916917d8fa0d1692c757a0.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-pm@vger.kernel.org

This patch moves cpufreq driver of ARM based tegra platform to drivers/cpuf=
req.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-tegra/Makefile                                       | 1 -
 drivers/cpufreq/Makefile                                           | 1 +
 arch/arm/mach-tegra/cpu-tegra.c =3D> drivers/cpufreq/tegra-cpufreq.c | 2 -=
-
 3 files changed, 1 insertion(+), 3 deletions(-)
 rename arch/arm/mach-tegra/cpu-tegra.c =3D> drivers/cpufreq/tegra-cpufreq.=
c (99%)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index f6b46ae..09b578f 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -24,7 +24,6 @@ obj-$(CONFIG_ARCH_TEGRA_3x_SOC)=09=09+=3D cpuidle-tegra30=
.o
 endif
 obj-$(CONFIG_SMP)=09=09=09+=3D platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               +=3D hotplug.o
-obj-$(CONFIG_CPU_FREQ)                  +=3D cpu-tegra.o
 obj-$(CONFIG_TEGRA_PCI)=09=09=09+=3D pcie.o
=20
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)=09=09+=3D board-dt-tegra20.o
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index e33a30e..966ea28 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_ARM_S3C2416_CPUFREQ)=09+=3D s3c2416-cpufreq.=
o
 obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)=09+=3D s3c64xx-cpufreq.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)=09+=3D s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)=09=09+=3D spear-cpufreq.o
+obj-$(CONFIG_ARCH_TEGRA)=09=09+=3D tegra-cpufreq.o
=20
 ##########################################################################=
########
 # PowerPC platform drivers
diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/drivers/cpufreq/tegra-cpufre=
q.c
similarity index 99%
rename from arch/arm/mach-tegra/cpu-tegra.c
rename to drivers/cpufreq/tegra-cpufreq.c
index 11ca730..c74c0e1 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-tegra/cpu-tegra.c
- *
  * Copyright (C) 2010 Google, Inc.
  *
  * Author:
--=20
1.7.12.rc2.18.g61b472e
