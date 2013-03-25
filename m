From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 9/9] cpufreq: sa11x0: move cpufreq driver to drivers/cpufreq
Date: Mon, 25 Mar 2013 15:41:40 +0530
Message-ID: <87d2cd71a29fb826efe15a3d97cc3444031387c0.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58991 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab3CYKMM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 06:12:12 -0400
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1364205812.git.viresh.kumar@linaro.org>
References: <cover.1364205812.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>

This patch moves cpufreq driver of ARM based sa11x0 platform to drivers/cpu=
freq.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/Kconfig                                   |  8 -------
 arch/arm/mach-sa1100/Kconfig                       | 26 +++++++++++-------=
----
 arch/arm/mach-sa1100/Makefile                      |  3 ---
 arch/arm/mach-sa1100/include/mach/generic.h        |  1 +
 drivers/cpufreq/Kconfig.arm                        |  6 +++++
 drivers/cpufreq/Makefile                           |  2 ++
 .../cpufreq/sa1100-cpufreq.c                       |  3 +--
 .../cpufreq/sa1110-cpufreq.c                       |  3 +--
 8 files changed, 24 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/mach-sa1100/include/mach/generic.h
 rename arch/arm/mach-sa1100/cpu-sa1100.c =3D> drivers/cpufreq/sa1100-cpufr=
eq.c (99%)
 rename arch/arm/mach-sa1100/cpu-sa1110.c =3D> drivers/cpufreq/sa1110-cpufr=
eq.c (99%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdbe688..8d73413 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2153,15 +2153,7 @@ endmenu
 menu "CPU Power Management"
=20
 if ARCH_HAS_CPUFREQ
-
 source "drivers/cpufreq/Kconfig"
-
-config CPU_FREQ_SA1100
-=09bool
-
-config CPU_FREQ_SA1110
-=09bool
-
 endif
=20
 source "drivers/cpuidle/Kconfig"
diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index ca14dbd..04f9784 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -4,7 +4,7 @@ menu "SA11x0 Implementations"
=20
 config SA1100_ASSABET
 =09bool "Assabet"
-=09select CPU_FREQ_SA1110
+=09select ARM_SA1110_CPUFREQ
 =09help
 =09  Say Y here if you are using the Intel(R) StrongARM(R) SA-1110
 =09  Microprocessor Development Board (also known as the Assabet).
@@ -20,7 +20,7 @@ config ASSABET_NEPONSET
=20
 config SA1100_CERF
 =09bool "CerfBoard"
-=09select CPU_FREQ_SA1110
+=09select ARM_SA1110_CPUFREQ
 =09help
 =09  The Intrinsyc CerfBoard is based on the StrongARM 1110 (Discontinued)=
.
 =09  More information is available at:
@@ -47,7 +47,7 @@ endchoice
=20
 config SA1100_COLLIE
 =09bool "Sharp Zaurus SL5500"
-=09# FIXME: select CPU_FREQ_SA11x0
+=09# FIXME: select ARM_SA11x0_CPUFREQ
 =09select SHARP_LOCOMO
 =09select SHARP_PARAM
 =09select SHARP_SCOOP
@@ -56,7 +56,7 @@ config SA1100_COLLIE
=20
 config SA1100_H3100
 =09bool "Compaq iPAQ H3100"
-=09select CPU_FREQ_SA1110
+=09select ARM_SA1110_CPUFREQ
 =09select HTC_EGPIO
 =09help
 =09  Say Y here if you intend to run this kernel on the Compaq iPAQ
@@ -67,7 +67,7 @@ config SA1100_H3100
=20
 config SA1100_H3600
 =09bool "Compaq iPAQ H3600/H3700"
-=09select CPU_FREQ_SA1110
+=09select ARM_SA1110_CPUFREQ
 =09select HTC_EGPIO
 =09help
 =09  Say Y here if you intend to run this kernel on the Compaq iPAQ
@@ -78,7 +78,7 @@ config SA1100_H3600
=20
 config SA1100_BADGE4
 =09bool "HP Labs BadgePAD 4"
-=09select CPU_FREQ_SA1100
+=09select ARM_SA1100_CPUFREQ
 =09select SA1111
 =09help
 =09  Say Y here if you want to build a kernel for the HP Laboratories
@@ -86,7 +86,7 @@ config SA1100_BADGE4
=20
 config SA1100_JORNADA720
 =09bool "HP Jornada 720"
-=09# FIXME: select CPU_FREQ_SA11x0
+=09# FIXME: select ARM_SA11x0_CPUFREQ
 =09select SA1111
 =09help
 =09  Say Y here if you want to build a kernel for the HP Jornada 720
@@ -105,14 +105,14 @@ config SA1100_JORNADA720_SSP
=20
 config SA1100_HACKKIT
 =09bool "HackKit Core CPU Board"
-=09select CPU_FREQ_SA1100
+=09select ARM_SA1100_CPUFREQ
 =09help
 =09  Say Y here to support the HackKit Core CPU Board
 =09  <http://hackkit.eletztrick.de>;
=20
 config SA1100_LART
 =09bool "LART"
-=09select CPU_FREQ_SA1100
+=09select ARM_SA1100_CPUFREQ
 =09help
 =09  Say Y here if you are using the Linux Advanced Radio Terminal
 =09  (also known as the LART).  See <http://www.lartmaker.nl/> for
@@ -120,7 +120,7 @@ config SA1100_LART
=20
 config SA1100_NANOENGINE
 =09bool "nanoEngine"
-=09select CPU_FREQ_SA1110
+=09select ARM_SA1110_CPUFREQ
 =09select PCI
 =09select PCI_NANOENGINE
 =09help
@@ -130,7 +130,7 @@ config SA1100_NANOENGINE
=20
 config SA1100_PLEB
 =09bool "PLEB"
-=09select CPU_FREQ_SA1100
+=09select ARM_SA1100_CPUFREQ
 =09help
 =09  Say Y here if you are using version 1 of the Portable Linux
 =09  Embedded Board (also known as PLEB).
@@ -139,7 +139,7 @@ config SA1100_PLEB
=20
 config SA1100_SHANNON
 =09bool "Shannon"
-=09select CPU_FREQ_SA1100
+=09select ARM_SA1100_CPUFREQ
 =09help
 =09  The Shannon (also known as a Tuxscreen, and also as a IS2630) was a
 =09  limited edition webphone produced by Philips. The Shannon is a SA1100
@@ -148,7 +148,7 @@ config SA1100_SHANNON
=20
 config SA1100_SIMPAD
 =09bool "Simpad"
-=09select CPU_FREQ_SA1110
+=09select ARM_SA1110_CPUFREQ
 =09help
 =09  The SIEMENS webpad SIMpad is based on the StrongARM 1110. There
 =09  are two different versions CL4 and SL4. CL4 has 32MB RAM and 16MB
diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
index 1aed9e7..2732eef 100644
--- a/arch/arm/mach-sa1100/Makefile
+++ b/arch/arm/mach-sa1100/Makefile
@@ -8,9 +8,6 @@ obj-m :=3D
 obj-n :=3D
 obj-  :=3D
=20
-obj-$(CONFIG_CPU_FREQ_SA1100)=09=09+=3D cpu-sa1100.o
-obj-$(CONFIG_CPU_FREQ_SA1110)=09=09+=3D cpu-sa1110.o
-
 # Specific board support
 obj-$(CONFIG_SA1100_ASSABET)=09=09+=3D assabet.o
 obj-$(CONFIG_ASSABET_NEPONSET)=09=09+=3D neponset.o
diff --git a/arch/arm/mach-sa1100/include/mach/generic.h b/arch/arm/mach-sa=
1100/include/mach/generic.h
new file mode 100644
index 0000000..665542e
--- /dev/null
+++ b/arch/arm/mach-sa1100/include/mach/generic.h
@@ -0,0 +1 @@
+#include "../../generic.h"
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 3021e35..cdaadcb 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -180,6 +180,12 @@ config ARM_S5PV210_CPUFREQ
=20
 =09  If in doubt, say N.
=20
+config ARM_SA1100_CPUFREQ
+=09bool
+
+config ARM_SA1110_CPUFREQ
+=09bool
+
 config ARM_SPEAR_CPUFREQ
 =09bool "SPEAr CPUFreq support"
 =09depends on PLAT_SPEAR
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 3886eda..c113af2 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -67,6 +67,8 @@ obj-$(CONFIG_ARM_S3C2416_CPUFREQ)=09+=3D s3c2416-cpufreq.=
o
 obj-$(CONFIG_ARM_S3C2440_CPUFREQ)=09+=3D s3c2440-cpufreq.o
 obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)=09+=3D s3c64xx-cpufreq.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)=09+=3D s5pv210-cpufreq.o
+obj-$(CONFIG_ARM_SA1100_CPUFREQ)=09+=3D sa1100-cpufreq.o
+obj-$(CONFIG_ARM_SA1110_CPUFREQ)=09+=3D sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)=09=09+=3D spear-cpufreq.o
 obj-$(CONFIG_ARCH_TEGRA)=09=09+=3D tegra-cpufreq.o
=20
diff --git a/arch/arm/mach-sa1100/cpu-sa1100.c b/drivers/cpufreq/sa1100-cpu=
freq.c
similarity index 99%
rename from arch/arm/mach-sa1100/cpu-sa1100.c
rename to drivers/cpufreq/sa1100-cpufreq.c
index 3268761..cff18e8 100644
--- a/arch/arm/mach-sa1100/cpu-sa1100.c
+++ b/drivers/cpufreq/sa1100-cpufreq.c
@@ -91,10 +91,9 @@
=20
 #include <asm/cputype.h>
=20
+#include <mach/generic.h>
 #include <mach/hardware.h>
=20
-#include "generic.h"
-
 struct sa1100_dram_regs {
 =09int speed;
 =09u32 mdcnfg;
diff --git a/arch/arm/mach-sa1100/cpu-sa1110.c b/drivers/cpufreq/sa1110-cpu=
freq.c
similarity index 99%
rename from arch/arm/mach-sa1100/cpu-sa1110.c
rename to drivers/cpufreq/sa1110-cpufreq.c
index 38a7733..39c90b6 100644
--- a/arch/arm/mach-sa1100/cpu-sa1110.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -27,10 +27,9 @@
 #include <asm/cputype.h>
 #include <asm/mach-types.h>
=20
+#include <mach/generic.h>
 #include <mach/hardware.h>
=20
-#include "generic.h"
-
 #undef DEBUG
=20
 struct sdram_params {
--=20
1.7.12.rc2.18.g61b472e


