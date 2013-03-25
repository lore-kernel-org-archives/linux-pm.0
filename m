From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 8/9] cpufreq: s3c24xx: move cpufreq driver to drivers/cpufreq
Date: Mon, 25 Mar 2013 15:41:39 +0530
Message-ID: <918ff6cc407525d682817cf736347ec572e0316d.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch moves cpufreq driver of Samsung's ARM based s3c24xx platform to
drivers/cpufreq.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/Kconfig                                   | 46 ---------------
 arch/arm/mach-s3c24xx/Kconfig                      | 66 +++++++++---------=
----
 arch/arm/mach-s3c24xx/Makefile                     |  6 --
 arch/arm/mach-s3c24xx/{ =3D> include/mach}/s3c2412.h |  0
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c           |  2 +-
 arch/arm/plat-samsung/include/plat/cpu-freq-core.h | 10 ++--
 arch/arm/plat-samsung/include/plat/cpu-freq.h      |  6 +-
 drivers/cpufreq/Kconfig.arm                        | 58 ++++++++++++++++++=
+
 drivers/cpufreq/Makefile                           |  5 ++
 .../cpufreq/s3c2410-cpufreq.c                      |  0
 .../cpufreq/s3c2412-cpufreq.c                      |  3 +-
 .../cpufreq/s3c2440-cpufreq.c                      |  0
 .../cpufreq/s3c24xx-cpufreq-debugfs.c              |  0
 .../cpufreq.c =3D> drivers/cpufreq/s3c24xx-cpufreq.c |  0
 14 files changed, 100 insertions(+), 102 deletions(-)
 rename arch/arm/mach-s3c24xx/{ =3D> include/mach}/s3c2412.h (100%)
 rename arch/arm/mach-s3c24xx/cpufreq-s3c2410.c =3D> drivers/cpufreq/s3c241=
0-cpufreq.c (100%)
 rename arch/arm/mach-s3c24xx/cpufreq-s3c2412.c =3D> drivers/cpufreq/s3c241=
2-cpufreq.c (99%)
 rename arch/arm/mach-s3c24xx/cpufreq-s3c2440.c =3D> drivers/cpufreq/s3c244=
0-cpufreq.c (100%)
 rename arch/arm/mach-s3c24xx/cpufreq-debugfs.c =3D> drivers/cpufreq/s3c24x=
x-cpufreq-debugfs.c (100%)
 rename arch/arm/mach-s3c24xx/cpufreq.c =3D> drivers/cpufreq/s3c24xx-cpufre=
q.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 39c8a3b..cdbe688 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2162,52 +2162,6 @@ config CPU_FREQ_SA1100
 config CPU_FREQ_SA1110
 =09bool
=20
-config CPU_FREQ_S3C
-=09bool
-=09help
-=09  Internal configuration node for common cpufreq on Samsung SoC
-
-config CPU_FREQ_S3C24XX
-=09bool "CPUfreq driver for Samsung S3C24XX series CPUs (EXPERIMENTAL)"
-=09depends on ARCH_S3C24XX && CPU_FREQ
-=09select CPU_FREQ_S3C
-=09help
-=09  This enables the CPUfreq driver for the Samsung S3C24XX family
-=09  of CPUs.
-
-=09  For details, take a look at <file:Documentation/cpu-freq>.
-
-=09  If in doubt, say N.
-
-config CPU_FREQ_S3C24XX_PLL
-=09bool "Support CPUfreq changing of PLL frequency (EXPERIMENTAL)"
-=09depends on CPU_FREQ_S3C24XX
-=09help
-=09  Compile in support for changing the PLL frequency from the
-=09  S3C24XX series CPUfreq driver. The PLL takes time to settle
-=09  after a frequency change, so by default it is not enabled.
-
-=09  This also means that the PLL tables for the selected CPU(s) will
-=09  be built which may increase the size of the kernel image.
-
-config CPU_FREQ_S3C24XX_DEBUG
-=09bool "Debug CPUfreq Samsung driver core"
-=09depends on CPU_FREQ_S3C24XX
-=09help
-=09  Enable s3c_freq_dbg for the Samsung S3C CPUfreq core
-
-config CPU_FREQ_S3C24XX_IODEBUG
-=09bool "Debug CPUfreq Samsung driver IO timing"
-=09depends on CPU_FREQ_S3C24XX
-=09help
-=09  Enable s3c_freq_iodbg for the Samsung S3C CPUfreq core
-
-config CPU_FREQ_S3C24XX_DEBUGFS
-=09bool "Export debugfs for CPUFreq"
-=09depends on CPU_FREQ_S3C24XX && DEBUG_FS
-=09help
-=09  Export status information via debugfs.
-
 endif
=20
 source "drivers/cpuidle/Kconfig"
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 37f513d..81d2f3c 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -28,7 +28,7 @@ config CPU_S3C2410
 =09select CPU_ARM920T
 =09select CPU_LLSERIAL_S3C2410
 =09select S3C2410_CLOCK
-=09select S3C2410_CPUFREQ if CPU_FREQ_S3C24XX
+=09select ARM_S3C2410_CPUFREQ if ARM_S3C24XX_CPUFREQ
 =09select S3C2410_PM if PM
 =09help
 =09  Support for S3C2410 and S3C2410A family from the S3C24XX line
@@ -202,27 +202,38 @@ config S3C24XX_GPIO_EXTRA128
 =09  Add an extra 128 gpio numbers to the available GPIO pool. This is
 =09  available for boards that need extra gpios for external devices.
=20
+config S3C24XX_PLL
+=09bool "Support CPUfreq changing of PLL frequency (EXPERIMENTAL)"
+=09depends on ARM_S3C24XX
+=09help
+=09  Compile in support for changing the PLL frequency from the
+=09  S3C24XX series CPUfreq driver. The PLL takes time to settle
+=09  after a frequency change, so by default it is not enabled.
+
+=09  This also means that the PLL tables for the selected CPU(s) will
+=09  be built which may increase the size of the kernel image.
+
 # cpu frequency items common between s3c2410 and s3c2440/s3c2442
=20
 config S3C2410_IOTIMING
 =09bool
-=09depends on CPU_FREQ_S3C24XX
+=09depends on ARM_S3C24XX_CPUFREQ
 =09help
 =09  Internal node to select io timing code that is common to the s3c2410
 =09  and s3c2440/s3c2442 cpu frequency support.
=20
 config S3C2410_CPUFREQ_UTILS
-=09bool
-=09depends on CPU_FREQ_S3C24XX
-=09help
-=09  Internal node to select timing code that is common to the s3c2410
-=09  and s3c2440/s3c244 cpu frequency support.
+       bool
+       depends on ARM_S3C24XX_CPUFREQ
+       help
+         Internal node to select timing code that is common to the s3c2410
+         and s3c2440/s3c244 cpu frequency support.
=20
 # cpu frequency support common to s3c2412, s3c2413 and s3c2442
=20
 config S3C2412_IOTIMING
 =09bool
-=09depends on CPU_FREQ_S3C24XX && (CPU_S3C2412 || CPU_S3C2443)
+=09depends on ARM_S3C24XX_CPUFREQ && (CPU_S3C2412 || CPU_S3C2443)
 =09help
 =09  Intel node to select io timing code that is common to the s3c2412
 =09  and the s3c2443.
@@ -231,16 +242,9 @@ config S3C2412_IOTIMING
=20
 if CPU_S3C2410
=20
-config S3C2410_CPUFREQ
-=09bool
-=09depends on CPU_FREQ_S3C24XX && CPU_S3C2410
-=09select S3C2410_CPUFREQ_UTILS
-=09help
-=09  CPU Frequency scaling support for S3C2410
-
 config S3C2410_PLL
 =09bool
-=09depends on S3C2410_CPUFREQ && CPU_FREQ_S3C24XX_PLL
+=09depends on ARM_S3C2410_CPUFREQ && S3C24XX_PLL
 =09default y
 =09help
 =09  Select the PLL table for the S3C2410
@@ -276,7 +280,7 @@ config ARCH_BAST
 =09bool "Simtec Electronics BAST (EB2410ITX)"
 =09select ISA
 =09select MACH_BAST_IDE
-=09select S3C2410_IOTIMING if S3C2410_CPUFREQ
+=09select S3C2410_IOTIMING if ARM_S3C2410_CPUFREQ
 =09select S3C24XX_DCLK
 =09select S3C24XX_SIMTEC_NOR
 =09select S3C24XX_SIMTEC_PM if PM
@@ -385,14 +389,6 @@ config CPU_S3C2412_ONLY
 =09=09   !CPU_S3C2443 && CPU_S3C2412
 =09default y
=20
-config S3C2412_CPUFREQ
-=09bool
-=09depends on CPU_FREQ_S3C24XX && CPU_S3C2412
-=09default y
-=09select S3C2412_IOTIMING
-=09help
-=09  CPU Frequency scaling support for S3C2412 and S3C2413 SoC CPUs.
-
 config S3C2412_DMA
 =09bool
 =09help
@@ -493,14 +489,6 @@ endif=09# CPU_S3C2416
=20
 if CPU_S3C2440
=20
-config S3C2440_CPUFREQ
-=09bool "S3C2440/S3C2442 CPU Frequency scaling support"
-=09depends on CPU_FREQ_S3C24XX && (CPU_S3C2440 || CPU_S3C2442)
-=09default y
-=09select S3C2410_CPUFREQ_UTILS
-=09help
-=09  CPU Frequency scaling support for S3C2440 and S3C2442 SoC CPUs.
-
 config S3C2440_DMA
 =09bool
 =09help
@@ -520,15 +508,15 @@ config S3C2440_XTAL_16934400
=20
 config S3C2440_PLL_12000000
 =09bool
-=09depends on S3C2440_CPUFREQ && S3C2440_XTAL_12000000
-=09default y if CPU_FREQ_S3C24XX_PLL
+=09depends on ARM_S3C2440_CPUFREQ && S3C2440_XTAL_12000000
+=09default y if S3C24XX_PLL
 =09help
 =09  PLL tables for S3C2440 or S3C2442 CPUs with 12MHz crystals.
=20
 config S3C2440_PLL_16934400
 =09bool
-=09depends on S3C2440_CPUFREQ && S3C2440_XTAL_16934400
-=09default y if CPU_FREQ_S3C24XX_PLL
+=09depends on ARM_S3C2440_CPUFREQ && S3C2440_XTAL_16934400
+=09default y if S3C24XX_PLL
 =09help
 =09  PLL tables for S3C2440 or S3C2442 CPUs with 16.934MHz crystals.
=20
@@ -582,7 +570,7 @@ config MACH_NEXCODER_2440
=20
 config MACH_OSIRIS
 =09bool "Simtec IM2440D20 (OSIRIS) module"
-=09select S3C2410_IOTIMING if S3C2440_CPUFREQ
+=09select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
 =09select S3C2440_XTAL_12000000
 =09select S3C24XX_DCLK
 =09select S3C24XX_GPIO_EXTRA128
@@ -655,7 +643,7 @@ config MACH_RX1950
 =09bool "HP iPAQ rx1950"
 =09select I2C
 =09select PM_H1940 if PM
-=09select S3C2410_IOTIMING if S3C2440_CPUFREQ
+=09select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
 =09select S3C2440_XTAL_16934400
 =09select S3C24XX_DCLK
 =09select S3C24XX_PWM
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefil=
e
index af53d27..15ce13c 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -17,13 +17,11 @@ obj-=09=09=09=09:=3D
 obj-y=09=09=09=09+=3D common.o irq.o
=20
 obj-$(CONFIG_CPU_S3C2410)=09+=3D s3c2410.o
-obj-$(CONFIG_S3C2410_CPUFREQ)=09+=3D cpufreq-s3c2410.o
 obj-$(CONFIG_S3C2410_DMA)=09+=3D dma-s3c2410.o
 obj-$(CONFIG_S3C2410_PLL)=09+=3D pll-s3c2410.o
 obj-$(CONFIG_S3C2410_PM)=09+=3D pm-s3c2410.o sleep-s3c2410.o
=20
 obj-$(CONFIG_CPU_S3C2412)=09+=3D s3c2412.o irq-s3c2412.o clock-s3c2412.o
-obj-$(CONFIG_S3C2412_CPUFREQ)=09+=3D cpufreq-s3c2412.o
 obj-$(CONFIG_S3C2412_DMA)=09+=3D dma-s3c2412.o
 obj-$(CONFIG_S3C2412_PM)=09+=3D pm-s3c2412.o
 obj-$(CONFIG_S3C2412_PM_SLEEP)=09+=3D sleep-s3c2412.o
@@ -34,7 +32,6 @@ obj-$(CONFIG_S3C2416_PM)=09+=3D pm-s3c2416.o
 obj-$(CONFIG_CPU_S3C2440)=09+=3D s3c2440.o irq-s3c2440.o clock-s3c2440.o
 obj-$(CONFIG_CPU_S3C2442)=09+=3D s3c2442.o
 obj-$(CONFIG_CPU_S3C244X)=09+=3D s3c244x.o irq-s3c244x.o clock-s3c244x.o
-obj-$(CONFIG_S3C2440_CPUFREQ)=09+=3D cpufreq-s3c2440.o
 obj-$(CONFIG_S3C2440_DMA)=09+=3D dma-s3c2440.o
 obj-$(CONFIG_S3C2440_PLL_12000000) +=3D pll-s3c2440-12000000.o
 obj-$(CONFIG_S3C2440_PLL_16934400) +=3D pll-s3c2440-16934400.o
@@ -59,9 +56,6 @@ obj-$(CONFIG_S3C2412_IOTIMING)=09+=3D iotiming-s3c2412.o
 obj-$(CONFIG_S3C2443_COMMON)=09+=3D common-s3c2443.o
 obj-$(CONFIG_S3C2443_DMA)=09+=3D dma-s3c2443.o
=20
-obj-$(CONFIG_CPU_FREQ_S3C24XX)=09+=3D cpufreq.o
-obj-$(CONFIG_CPU_FREQ_S3C24XX_DEBUGFS) +=3D cpufreq-debugfs.o
-
 #
 # machine support
 # following is ordered alphabetically by option text.
diff --git a/arch/arm/mach-s3c24xx/s3c2412.h b/arch/arm/mach-s3c24xx/includ=
e/mach/s3c2412.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/s3c2412.h
rename to arch/arm/mach-s3c24xx/include/mach/s3c2412.h
diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c b/arch/arm/mach-s3c24=
xx/iotiming-s3c2412.c
index 663436d..bd064c0 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
@@ -31,7 +31,7 @@
 #include <plat/cpu-freq-core.h>
 #include <plat/clock.h>
=20
-#include "s3c2412.h"
+#include <mach/s3c2412.h>
=20
 #define print_ns(x) ((x) / 10), ((x) % 10)
=20
diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h b/arch/arm/=
plat-samsung/include/plat/cpu-freq-core.h
index 95509d8..d7e1715 100644
--- a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
+++ b/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
@@ -202,7 +202,7 @@ extern int s3c_plltab_register(struct cpufreq_frequency=
_table *plls,
 extern struct s3c_cpufreq_config *s3c_cpufreq_getconfig(void);
 extern struct s3c_iotimings *s3c_cpufreq_getiotimings(void);
=20
-#ifdef CONFIG_CPU_FREQ_S3C24XX_DEBUGFS
+#ifdef CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS
 #define s3c_cpufreq_debugfs_call(x) x
 #else
 #define s3c_cpufreq_debugfs_call(x) NULL
@@ -259,17 +259,17 @@ extern void s3c2412_iotiming_set(struct s3c_cpufreq_c=
onfig *cfg,
 #define s3c2412_iotiming_set NULL
 #endif /* CONFIG_S3C2412_IOTIMING */
=20
-#ifdef CONFIG_CPU_FREQ_S3C24XX_DEBUG
+#ifdef CONFIG_ARM_S3C24XX_CPUFREQ_DEBUG
 #define s3c_freq_dbg(x...) printk(KERN_INFO x)
 #else
 #define s3c_freq_dbg(x...) do { if (0) printk(x); } while (0)
-#endif /* CONFIG_CPU_FREQ_S3C24XX_DEBUG */
+#endif /* CONFIG_ARM_S3C24XX_CPUFREQ_DEBUG */
=20
-#ifdef CONFIG_CPU_FREQ_S3C24XX_IODEBUG
+#ifdef CONFIG_ARM_S3C24XX_CPUFREQ_IODEBUG
 #define s3c_freq_iodbg(x...) printk(KERN_INFO x)
 #else
 #define s3c_freq_iodbg(x...) do { if (0) printk(x); } while (0)
-#endif /* CONFIG_CPU_FREQ_S3C24XX_IODEBUG */
+#endif /* CONFIG_ARM_S3C24XX_CPUFREQ_IODEBUG */
=20
 static inline int s3c_cpufreq_addfreq(struct cpufreq_frequency_table *tabl=
e,
 =09=09=09=09      int index, size_t table_size,
diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq.h b/arch/arm/plat-=
samsung/include/plat/cpu-freq.h
index 80c4a80..85517ab 100644
--- a/arch/arm/plat-samsung/include/plat/cpu-freq.h
+++ b/arch/arm/plat-samsung/include/plat/cpu-freq.h
@@ -126,7 +126,7 @@ struct s3c_cpufreq_board {
 };
=20
 /* Things depending on frequency scaling. */
-#ifdef CONFIG_CPU_FREQ_S3C
+#ifdef CONFIG_ARM_S3C_CPUFREQ
 #define __init_or_cpufreq
 #else
 #define __init_or_cpufreq __init
@@ -134,7 +134,7 @@ struct s3c_cpufreq_board {
=20
 /* Board functions */
=20
-#ifdef CONFIG_CPU_FREQ_S3C
+#ifdef CONFIG_ARM_S3C_CPUFREQ
 extern int s3c_cpufreq_setboard(struct s3c_cpufreq_board *board);
 #else
=20
@@ -142,4 +142,4 @@ static inline int s3c_cpufreq_setboard(struct s3c_cpufr=
eq_board *board)
 {
 =09return 0;
 }
-#endif  /* CONFIG_CPU_FREQ_S3C */
+#endif  /* CONFIG_ARM_S3C_CPUFREQ */
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a345e20..3021e35 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -81,6 +81,56 @@ config ARM_OMAP2PLUS_CPUFREQ
 =09default ARCH_OMAP2PLUS
 =09select CPU_FREQ_TABLE
=20
+config ARM_S3C_CPUFREQ
+=09bool
+=09help
+=09  Internal configuration node for common cpufreq on Samsung SoC
+
+config ARM_S3C24XX_CPUFREQ
+=09bool "CPUfreq driver for Samsung S3C24XX series CPUs (EXPERIMENTAL)"
+=09depends on ARCH_S3C24XX
+=09select ARM_S3C_CPUFREQ
+=09help
+=09  This enables the CPUfreq driver for the Samsung S3C24XX family
+=09  of CPUs.
+
+=09  For details, take a look at <file:Documentation/cpu-freq>.
+
+=09  If in doubt, say N.
+
+config ARM_S3C24XX_CPUFREQ_DEBUG
+=09bool "Debug CPUfreq Samsung driver core"
+=09depends on ARM_S3C24XX_CPUFREQ
+=09help
+=09  Enable s3c_freq_dbg for the Samsung S3C CPUfreq core
+
+config ARM_S3C24XX_CPUFREQ_IODEBUG
+=09bool "Debug CPUfreq Samsung driver IO timing"
+=09depends on ARM_S3C24XX_CPUFREQ
+=09help
+=09  Enable s3c_freq_iodbg for the Samsung S3C CPUfreq core
+
+config ARM_S3C24XX_CPUFREQ_DEBUGFS
+=09bool "Export debugfs for CPUFreq"
+=09depends on ARM_S3C24XX_CPUFREQ && DEBUG_FS
+=09help
+=09  Export status information via debugfs.
+
+config ARM_S3C2410_CPUFREQ
+=09bool
+=09depends on ARM_S3C24XX_CPUFREQ && CPU_S3C2410
+=09select S3C2410_CPUFREQ_UTILS
+=09help
+=09  CPU Frequency scaling support for S3C2410
+
+config ARM_S3C2412_CPUFREQ
+=09bool
+=09depends on ARM_S3C24XX_CPUFREQ && CPU_S3C2412
+=09default y
+=09select S3C2412_IOTIMING
+=09help
+=09  CPU Frequency scaling support for S3C2412 and S3C2413 SoC CPUs.
+
 config ARM_S3C2416_CPUFREQ
 =09bool "S3C2416 CPU Frequency scaling support"
 =09depends on CPU_S3C2416
@@ -103,6 +153,14 @@ config ARM_S3C2416_CPUFREQ_VCORESCALE
=20
 =09  If in doubt, say N.
=20
+config ARM_S3C2440_CPUFREQ
+=09bool "S3C2440/S3C2442 CPU Frequency scaling support"
+=09depends on ARM_S3C24XX_CPUFREQ && (CPU_S3C2440 || CPU_S3C2442)
+=09select S3C2410_CPUFREQ_UTILS
+=09default y
+=09help
+=09  CPU Frequency scaling support for S3C2440 and S3C2442 SoC CPUs.
+
 config ARM_S3C64XX_CPUFREQ
 =09bool "Samsung S3C64XX"
 =09depends on CPU_S3C6410
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index aa00ca4..3886eda 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -59,7 +59,12 @@ obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)=09+=3D omap-cpufreq.=
o
 obj-$(CONFIG_PXA25x)=09=09=09+=3D pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA27x)=09=09=09+=3D pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)=09=09=09+=3D pxa3xx-cpufreq.o
+obj-$(CONFIG_ARM_S3C24XX_CPUFREQ)=09+=3D s3c24xx-cpufreq.o
+obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) +=3D s3c24xx-cpufreq-debugfs.o
+obj-$(CONFIG_ARM_S3C2410_CPUFREQ)=09+=3D s3c2410-cpufreq.o
+obj-$(CONFIG_ARM_S3C2412_CPUFREQ)=09+=3D s3c2412-cpufreq.o
 obj-$(CONFIG_ARM_S3C2416_CPUFREQ)=09+=3D s3c2416-cpufreq.o
+obj-$(CONFIG_ARM_S3C2440_CPUFREQ)=09+=3D s3c2440-cpufreq.o
 obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)=09+=3D s3c64xx-cpufreq.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)=09+=3D s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)=09=09+=3D spear-cpufreq.o
diff --git a/arch/arm/mach-s3c24xx/cpufreq-s3c2410.c b/drivers/cpufreq/s3c2=
410-cpufreq.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/cpufreq-s3c2410.c
rename to drivers/cpufreq/s3c2410-cpufreq.c
diff --git a/arch/arm/mach-s3c24xx/cpufreq-s3c2412.c b/drivers/cpufreq/s3c2=
412-cpufreq.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/cpufreq-s3c2412.c
rename to drivers/cpufreq/s3c2412-cpufreq.c
index 8bf0f3a..4645b48 100644
--- a/arch/arm/mach-s3c24xx/cpufreq-s3c2412.c
+++ b/drivers/cpufreq/s3c2412-cpufreq.c
@@ -25,13 +25,12 @@
 #include <asm/mach/map.h>
=20
 #include <mach/regs-clock.h>
+#include <mach/s3c2412.h>
=20
 #include <plat/cpu.h>
 #include <plat/clock.h>
 #include <plat/cpu-freq-core.h>
=20
-#include "s3c2412.h"
-
 /* our clock resources. */
 static struct clk *xtal;
 static struct clk *fclk;
diff --git a/arch/arm/mach-s3c24xx/cpufreq-s3c2440.c b/drivers/cpufreq/s3c2=
440-cpufreq.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/cpufreq-s3c2440.c
rename to drivers/cpufreq/s3c2440-cpufreq.c
diff --git a/arch/arm/mach-s3c24xx/cpufreq-debugfs.c b/drivers/cpufreq/s3c2=
4xx-cpufreq-debugfs.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/cpufreq-debugfs.c
rename to drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
diff --git a/arch/arm/mach-s3c24xx/cpufreq.c b/drivers/cpufreq/s3c24xx-cpuf=
req.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/cpufreq.c
rename to drivers/cpufreq/s3c24xx-cpufreq.c
--=20
1.7.12.rc2.18.g61b472e
