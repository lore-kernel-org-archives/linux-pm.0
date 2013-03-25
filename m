From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/9] cpufreq: davinci: move cpufreq driver to drivers/cpufreq
Date: Mon, 25 Mar 2013 15:41:34 +0530
Message-ID: <ef225dbf63b1d834761773384d3f70cb4ac7b611.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>, Sekhar Nori <nsekhar@ti.com>, davinci-linux-open-source@linux.davincidsp.com
List-Id: linux-pm@vger.kernel.org

This patch moves cpufreq driver of ARM based davinci platform to
drivers/cpufreq.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-davinci/Makefile                                       | 1 -
 drivers/cpufreq/Makefile                                             | 1 +
 arch/arm/mach-davinci/cpufreq.c =3D> drivers/cpufreq/davinci-cpufreq.c | 2=
 --
 3 files changed, 1 insertion(+), 3 deletions(-)
 rename arch/arm/mach-davinci/cpufreq.c =3D> drivers/cpufreq/davinci-cpufre=
q.c (99%)

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefil=
e
index fb5c1aa..dd1ffcc 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -37,7 +37,6 @@ obj-$(CONFIG_MACH_MITYOMAPL138)=09=09+=3D board-mityomapl=
138.o
 obj-$(CONFIG_MACH_OMAPL138_HAWKBOARD)=09+=3D board-omapl138-hawk.o
=20
 # Power Management
-obj-$(CONFIG_CPU_FREQ)=09=09=09+=3D cpufreq.o
 obj-$(CONFIG_CPU_IDLE)=09=09=09+=3D cpuidle.o
 obj-$(CONFIG_SUSPEND)=09=09=09+=3D pm.o sleep.o
 obj-$(CONFIG_HAVE_CLK)=09=09=09+=3D pm_domain.o
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 966ea28..efce6c7 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_X86_INTEL_PSTATE)=09=09+=3D intel_pstate.o
=20
 ##########################################################################=
########
 # ARM SoC drivers
+obj-$(CONFIG_ARCH_DAVINCI_DA850)=09+=3D davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)=09=09+=3D dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)=09+=3D exynos-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)=09+=3D exynos4210-cpufreq.o
diff --git a/arch/arm/mach-davinci/cpufreq.c b/drivers/cpufreq/davinci-cpuf=
req.c
similarity index 99%
rename from arch/arm/mach-davinci/cpufreq.c
rename to drivers/cpufreq/davinci-cpufreq.c
index 8fb0c2a..5b34f61 100644
--- a/arch/arm/mach-davinci/cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -30,8 +30,6 @@
 #include <mach/cpufreq.h>
 #include <mach/common.h>
=20
-#include "clock.h"
-
 struct davinci_cpufreq {
 =09struct device *dev;
 =09struct clk *armclk;
--=20
1.7.12.rc2.18.g61b472e
