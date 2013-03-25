From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/9] cpufreq: imx: move cpufreq driver to drivers/cpufreq
Date: Mon, 25 Mar 2013 15:41:35 +0530
Message-ID: <6c0d4611de3586b12d5df9beaa5d21e4703dd38b.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

This patch moves cpufreq driver of ARM based imx platform to drivers/cpufre=
q.

Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/Kconfig                                             |  7 -------
 arch/arm/mach-imx/Makefile                                   |  1 -
 arch/arm/mach-imx/mxc.h                                      |  6 +-----
 drivers/cpufreq/Kconfig.arm                                  |  7 +++++++
 drivers/cpufreq/Makefile                                     |  1 +
 arch/arm/mach-imx/cpufreq.c =3D> drivers/cpufreq/imx-cpufreq.c |  7 +++---=
-
 include/linux/cpufreq/imx.h                                  | 10 ++++++++=
++
 7 files changed, 22 insertions(+), 17 deletions(-)
 rename arch/arm/mach-imx/cpufreq.c =3D> drivers/cpufreq/imx-cpufreq.c (99%=
)
 create mode 100644 include/linux/cpufreq/imx.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2c3bdce..0295a08 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2156,13 +2156,6 @@ if ARCH_HAS_CPUFREQ
=20
 source "drivers/cpufreq/Kconfig"
=20
-config CPU_FREQ_IMX
-=09tristate "CPUfreq driver for i.MX CPUs"
-=09depends on ARCH_MXC && CPU_FREQ
-=09select CPU_FREQ_TABLE
-=09help
-=09  This enables the CPUfreq driver for i.MX CPUs.
-
 config CPU_FREQ_SA1100
 =09bool
=20
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index c4ce090..e313433 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -27,7 +27,6 @@ obj-$(CONFIG_IRAM_ALLOC) +=3D iram_alloc.o
 obj-$(CONFIG_MXC_ULPI) +=3D ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) +=3D epit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) +=3D 3ds_debugboard.o
-obj-$(CONFIG_CPU_FREQ_IMX)    +=3D cpufreq.o
=20
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-y +=3D cpuidle.o
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 7dce17a..ec8d752 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -151,13 +151,9 @@ extern unsigned int __mxc_cpu_type;
=20
 #ifndef __ASSEMBLY__
=20
-struct cpu_op {
-=09u32 cpu_rate;
-};
+#include <linux/cpufreq/imx.h>
=20
 int tzic_enable_wake(void);
-
-extern struct cpu_op *(*get_cpu_op)(int *op);
 #endif
=20
 #define cpu_is_mx3()=09(cpu_is_mx31() || cpu_is_mx35())
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index b72a2b3..3d83bc5 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -45,6 +45,13 @@ config ARM_HIGHBANK_CPUFREQ
=20
 =09  If in doubt, say N.
=20
+config ARM_IMX_CPUFREQ
+=09tristate "CPUfreq driver for i.MX CPUs"
+=09depends on ARCH_MXC
+=09select CPU_FREQ_TABLE
+=09help
+=09  This enables the CPUfreq driver for i.MX CPUs.
+
 config ARM_IMX6Q_CPUFREQ
 =09tristate "Freescale i.MX6Q cpufreq support"
 =09depends on SOC_IMX6Q
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index efce6c7..2759192 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)=09+=3D exynos4210-cp=
ufreq.o
 obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)=09+=3D exynos4x12-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)=09+=3D exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)=09+=3D highbank-cpufreq.o
+obj-$(CONFIG_ARM_IMX_CPUFREQ)=09=09+=3D imx-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)=09=09+=3D imx6q-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)=09+=3D kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)=09+=3D omap-cpufreq.o
diff --git a/arch/arm/mach-imx/cpufreq.c b/drivers/cpufreq/imx-cpufreq.c
similarity index 99%
rename from arch/arm/mach-imx/cpufreq.c
rename to drivers/cpufreq/imx-cpufreq.c
index cfce5e3..3b856e0 100644
--- a/arch/arm/mach-imx/cpufreq.c
+++ b/drivers/cpufreq/imx-cpufreq.c
@@ -17,14 +17,13 @@
  * the CPU clock speed on the fly.
  */
=20
-#include <linux/module.h>
-#include <linux/cpufreq.h>
 #include <linux/clk.h>
+#include <linux/cpufreq.h>
+#include <linux/cpufreq/imx.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/slab.h>
=20
-#include "hardware.h"
-
 #define CLK32_FREQ=0932768
 #define NANOSECOND=09(1000 * 1000 * 1000)
=20
diff --git a/include/linux/cpufreq/imx.h b/include/linux/cpufreq/imx.h
new file mode 100644
index 0000000..dd2cc49
--- /dev/null
+++ b/include/linux/cpufreq/imx.h
@@ -0,0 +1,10 @@
+#ifndef CPUFREQ_IMX_H
+#define CPUFREQ_IMX_H
+
+struct cpu_op {
+=09u32 cpu_rate;
+};
+
+extern struct cpu_op *(*get_cpu_op)(int *op);
+
+#endif
--=20
1.7.12.rc2.18.g61b472e
