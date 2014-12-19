From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: [PATCH 4/4] PM: Eliminate CONFIG_PM_RUNTIME
Date: Fri, 19 Dec 2014 03:03:46 +0100
Message-ID: <2635409.SWsBMlb9s4@vostro.rjw.lan>
References: <472992175.g1ArEYGFPo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <472992175.g1ArEYGFPo-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb@vger
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Having switched over all of the users of CONFIG_PM_RUNTIME to use
CONFIG_PM directly, turn the latter into a user-selectable option
and drop the former entirely from the tree.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/configs/ape6evm_defconfig         |    2 +-
 arch/arm/configs/armadillo800eva_defconfig |    2 +-
 arch/arm/configs/bcm_defconfig             |    2 +-
 arch/arm/configs/bockw_defconfig           |    2 +-
 arch/arm/configs/davinci_all_defconfig     |    2 +-
 arch/arm/configs/exynos_defconfig          |    2 +-
 arch/arm/configs/ezx_defconfig             |    2 +-
 arch/arm/configs/hisi_defconfig            |    2 +-
 arch/arm/configs/imote2_defconfig          |    2 +-
 arch/arm/configs/imx_v6_v7_defconfig       |    2 +-
 arch/arm/configs/keystone_defconfig        |    2 +-
 arch/arm/configs/kzm9g_defconfig           |    2 +-
 arch/arm/configs/lager_defconfig           |    2 +-
 arch/arm/configs/mackerel_defconfig        |    2 +-
 arch/arm/configs/marzen_defconfig          |    2 +-
 arch/arm/configs/omap1_defconfig           |    2 +-
 arch/arm/configs/prima2_defconfig          |    2 +-
 arch/arm/configs/sama5_defconfig           |    2 +-
 arch/arm/configs/shmobile_defconfig        |    2 +-
 arch/arm/configs/sunxi_defconfig           |    2 +-
 arch/arm/configs/tegra_defconfig           |    2 +-
 arch/arm/configs/u8500_defconfig           |    2 +-
 arch/arm/configs/vt8500_v6_v7_defconfig    |    2 +-
 arch/arm/mach-omap2/Kconfig                |    6 +++---
 arch/mips/configs/db1xxx_defconfig         |    2 +-
 arch/mips/configs/lemote2f_defconfig       |    2 +-
 arch/mips/configs/loongson3_defconfig      |    2 +-
 arch/mips/configs/nlm_xlp_defconfig        |    2 +-
 arch/mips/configs/nlm_xlr_defconfig        |    2 +-
 arch/powerpc/configs/ps3_defconfig         |    2 +-
 arch/sh/Kconfig                            |    2 +-
 arch/sh/configs/apsh4ad0a_defconfig        |    2 +-
 arch/sh/configs/sdk7786_defconfig          |    2 +-
 drivers/usb/host/isp1760-hcd.c             |    2 +-
 drivers/usb/host/oxu210hp-hcd.c            |    2 +-
 include/linux/devfreq.h                    |    2 +-
 kernel/power/Kconfig                       |   16 ++++++----------
 37 files changed, 44 insertions(+), 48 deletions(-)

Index: linux-pm/arch/arm/configs/ape6evm_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/ape6evm_defconfig
+++ linux-pm/arch/arm/configs/ape6evm_defconfig
@@ -33,7 +33,7 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_BINFMT_MISC=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/armadillo800eva_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/armadillo800eva_defconfig
+++ linux-pm/arch/arm/configs/armadillo800eva_defconfig
@@ -43,7 +43,7 @@ CONFIG_KEXEC=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/bcm_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/bcm_defconfig
+++ linux-pm/arch/arm/configs/bcm_defconfig
@@ -39,7 +39,7 @@ CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
Index: linux-pm/arch/arm/configs/bockw_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/bockw_defconfig
+++ linux-pm/arch/arm/configs/bockw_defconfig
@@ -29,7 +29,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/davinci_all_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/davinci_all_defconfig
+++ linux-pm/arch/arm/configs/davinci_all_defconfig
@@ -49,7 +49,7 @@ CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_ONDEMAND=m
 CONFIG_CPU_IDLE=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/exynos_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/exynos_defconfig
+++ linux-pm/arch/arm/configs/exynos_defconfig
@@ -27,7 +27,7 @@ CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
 CONFIG_VFP=y
 CONFIG_NEON=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/ezx_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/ezx_defconfig
+++ linux-pm/arch/arm/configs/ezx_defconfig
@@ -39,7 +39,7 @@ CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 CONFIG_PM=y
 CONFIG_APM_EMULATION=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/hisi_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/hisi_defconfig
+++ linux-pm/arch/arm/configs/hisi_defconfig
@@ -18,7 +18,7 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_NEON=y
 CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/imote2_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/imote2_defconfig
+++ linux-pm/arch/arm/configs/imote2_defconfig
@@ -31,7 +31,7 @@ CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 CONFIG_PM=y
 CONFIG_APM_EMULATION=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/imx_v6_v7_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/imx_v6_v7_defconfig
+++ linux-pm/arch/arm/configs/imx_v6_v7_defconfig
@@ -54,7 +54,7 @@ CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_BINFMT_MISC=m
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_TEST_SUSPEND=y
 CONFIG_NET=y
Index: linux-pm/arch/arm/configs/keystone_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/keystone_defconfig
+++ linux-pm/arch/arm/configs/keystone_defconfig
@@ -30,7 +30,7 @@ CONFIG_HIGHMEM=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_SUSPEND is not set
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/kzm9g_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/kzm9g_defconfig
+++ linux-pm/arch/arm/configs/kzm9g_defconfig
@@ -43,7 +43,7 @@ CONFIG_KEXEC=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/lager_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/lager_defconfig
+++ linux-pm/arch/arm/configs/lager_defconfig
@@ -37,7 +37,7 @@ CONFIG_AUTO_ZRELADDR=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/mackerel_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/mackerel_defconfig
+++ linux-pm/arch/arm/configs/mackerel_defconfig
@@ -28,7 +28,7 @@ CONFIG_KEXEC=y
 CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/marzen_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/marzen_defconfig
+++ linux-pm/arch/arm/configs/marzen_defconfig
@@ -33,7 +33,7 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_VFP=y
 CONFIG_KEXEC=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/omap1_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/omap1_defconfig
+++ linux-pm/arch/arm/configs/omap1_defconfig
@@ -63,7 +63,7 @@ CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
 # CONFIG_SUSPEND is not set
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/prima2_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/prima2_defconfig
+++ linux-pm/arch/arm/configs/prima2_defconfig
@@ -18,7 +18,7 @@ CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_KEXEC=y
 CONFIG_BINFMT_MISC=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
Index: linux-pm/arch/arm/configs/sama5_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/sama5_defconfig
+++ linux-pm/arch/arm/configs/sama5_defconfig
@@ -32,7 +32,7 @@ CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_ADVANCED_DEBUG=y
 CONFIG_NET=y
Index: linux-pm/arch/arm/configs/shmobile_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/shmobile_defconfig
+++ linux-pm/arch/arm/configs/shmobile_defconfig
@@ -39,7 +39,7 @@ CONFIG_KEXEC=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/sunxi_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/sunxi_defconfig
+++ linux-pm/arch/arm/configs/sunxi_defconfig
@@ -11,7 +11,7 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/tegra_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/tegra_defconfig
+++ linux-pm/arch/arm/configs/tegra_defconfig
@@ -46,7 +46,7 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/u8500_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/u8500_defconfig
+++ linux-pm/arch/arm/configs/u8500_defconfig
@@ -25,7 +25,7 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_U8500_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/arm/configs/vt8500_v6_v7_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/vt8500_v6_v7_defconfig
+++ linux-pm/arch/arm/configs/vt8500_v6_v7_defconfig
@@ -16,7 +16,7 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
Index: linux-pm/arch/mips/configs/db1xxx_defconfig
===================================================================
--- linux-pm.orig/arch/mips/configs/db1xxx_defconfig
+++ linux-pm/arch/mips/configs/db1xxx_defconfig
@@ -36,7 +36,7 @@ CONFIG_PCI=y
 CONFIG_PCI_REALLOC_ENABLE_AUTO=y
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
Index: linux-pm/arch/mips/configs/lemote2f_defconfig
===================================================================
--- linux-pm.orig/arch/mips/configs/lemote2f_defconfig
+++ linux-pm/arch/mips/configs/lemote2f_defconfig
@@ -37,7 +37,7 @@ CONFIG_MIPS32_N32=y
 CONFIG_PM=y
 CONFIG_HIBERNATION=y
 CONFIG_PM_STD_PARTITION="/dev/hda3"
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEBUG=y
 CONFIG_CPU_FREQ_STAT=m
Index: linux-pm/arch/mips/configs/loongson3_defconfig
===================================================================
--- linux-pm.orig/arch/mips/configs/loongson3_defconfig
+++ linux-pm/arch/mips/configs/loongson3_defconfig
@@ -58,7 +58,7 @@ CONFIG_BINFMT_MISC=m
 CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
Index: linux-pm/arch/mips/configs/nlm_xlp_defconfig
===================================================================
--- linux-pm.orig/arch/mips/configs/nlm_xlp_defconfig
+++ linux-pm/arch/mips/configs/nlm_xlp_defconfig
@@ -61,7 +61,7 @@ CONFIG_BINFMT_MISC=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_PM_DEBUG=y
 CONFIG_NET=y
 CONFIG_PACKET=y
Index: linux-pm/arch/mips/configs/nlm_xlr_defconfig
===================================================================
--- linux-pm.orig/arch/mips/configs/nlm_xlr_defconfig
+++ linux-pm/arch/mips/configs/nlm_xlr_defconfig
@@ -41,7 +41,7 @@ CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_DEBUG=y
 CONFIG_BINFMT_MISC=m
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_PM_DEBUG=y
 CONFIG_NET=y
 CONFIG_PACKET=y
Index: linux-pm/arch/powerpc/configs/ps3_defconfig
===================================================================
--- linux-pm.orig/arch/powerpc/configs/ps3_defconfig
+++ linux-pm/arch/powerpc/configs/ps3_defconfig
@@ -36,7 +36,7 @@ CONFIG_KEXEC=y
 CONFIG_SCHED_SMT=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE=""
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_PM_DEBUG=y
 # CONFIG_SECCOMP is not set
 # CONFIG_PCI is not set
Index: linux-pm/arch/sh/configs/apsh4ad0a_defconfig
===================================================================
--- linux-pm.orig/arch/sh/configs/apsh4ad0a_defconfig
+++ linux-pm/arch/sh/configs/apsh4ad0a_defconfig
@@ -47,7 +47,7 @@ CONFIG_PREEMPT=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
 CONFIG_PM_DEBUG=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
Index: linux-pm/arch/sh/configs/sdk7786_defconfig
===================================================================
--- linux-pm.orig/arch/sh/configs/sdk7786_defconfig
+++ linux-pm/arch/sh/configs/sdk7786_defconfig
@@ -82,7 +82,7 @@ CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
 CONFIG_PM_DEBUG=y
-CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
Index: linux-pm/arch/arm/mach-omap2/Kconfig
===================================================================
--- linux-pm.orig/arch/arm/mach-omap2/Kconfig
+++ linux-pm/arch/arm/mach-omap2/Kconfig
@@ -15,7 +15,7 @@ config ARCH_OMAP3
 	select ARM_CPU_SUSPEND if PM
 	select OMAP_INTERCONNECT
 	select PM_OPP if PM
-	select PM_RUNTIME if CPU_IDLE
+	select PM if CPU_IDLE
 	select SOC_HAS_OMAP2_SDRC
 
 config ARCH_OMAP4
@@ -32,7 +32,7 @@ config ARCH_OMAP4
 	select PL310_ERRATA_588369 if CACHE_L2X0
 	select PL310_ERRATA_727915 if CACHE_L2X0
 	select PM_OPP if PM
-	select PM_RUNTIME if CPU_IDLE
+	select PM if CPU_IDLE
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 
@@ -103,7 +103,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select I2C_OMAP
 	select MENELAUS if ARCH_OMAP2
 	select NEON if CPU_V7
-	select PM_RUNTIME
+	select PM
 	select REGULATOR
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
Index: linux-pm/arch/sh/Kconfig
===================================================================
--- linux-pm.orig/arch/sh/Kconfig
+++ linux-pm/arch/sh/Kconfig
@@ -223,7 +223,7 @@ config CPU_SHX3
 config ARCH_SHMOBILE
 	bool
 	select ARCH_SUSPEND_POSSIBLE
-	select PM_RUNTIME
+	select PM
 
 config CPU_HAS_PMU
        depends on CPU_SH4 || CPU_SH4A
Index: linux-pm/drivers/usb/host/isp1760-hcd.c
===================================================================
--- linux-pm.orig/drivers/usb/host/isp1760-hcd.c
+++ linux-pm/drivers/usb/host/isp1760-hcd.c
@@ -1739,7 +1739,7 @@ static int isp1760_hub_status_data(struc
 	int retval = 1;
 	unsigned long flags;
 
-	/* if !PM_RUNTIME, root hub timers won't get shut down ... */
+	/* if !PM, root hub timers won't get shut down ... */
 	if (!HC_IS_RUNNING(hcd->state))
 		return 0;
 
Index: linux-pm/drivers/usb/host/oxu210hp-hcd.c
===================================================================
--- linux-pm.orig/drivers/usb/host/oxu210hp-hcd.c
+++ linux-pm/drivers/usb/host/oxu210hp-hcd.c
@@ -3087,7 +3087,7 @@ static int oxu_hub_status_data(struct us
 	int ports, i, retval = 1;
 	unsigned long flags;
 
-	/* if !PM_RUNTIME, root hub timers won't get shut down ... */
+	/* if !PM, root hub timers won't get shut down ... */
 	if (!HC_IS_RUNNING(hcd->state))
 		return 0;
 
Index: linux-pm/include/linux/devfreq.h
===================================================================
--- linux-pm.orig/include/linux/devfreq.h
+++ linux-pm/include/linux/devfreq.h
@@ -188,7 +188,7 @@ extern struct devfreq *devm_devfreq_add_
 extern void devm_devfreq_remove_device(struct device *dev,
 				  struct devfreq *devfreq);
 
-/* Supposed to be called by PM_SLEEP/PM_RUNTIME callbacks */
+/* Supposed to be called by PM callbacks */
 extern int devfreq_suspend_device(struct devfreq *devfreq);
 extern int devfreq_resume_device(struct devfreq *devfreq);
 
Index: linux-pm/kernel/power/Kconfig
===================================================================
--- linux-pm.orig/kernel/power/Kconfig
+++ linux-pm/kernel/power/Kconfig
@@ -94,7 +94,7 @@ config PM_STD_PARTITION
 config PM_SLEEP
 	def_bool y
 	depends on SUSPEND || HIBERNATE_CALLBACKS
-	select PM_RUNTIME
+	select PM
 
 config PM_SLEEP_SMP
 	def_bool y
@@ -130,23 +130,19 @@ config PM_WAKELOCKS_GC
 	depends on PM_WAKELOCKS
 	default y
 
-config PM_RUNTIME
-	bool "Run-time PM core functionality"
+config PM
+	bool "Device power management core functionality"
 	---help---
 	  Enable functionality allowing I/O devices to be put into energy-saving
-	  (low power) states at run time (or autosuspended) after a specified
-	  period of inactivity and woken up in response to a hardware-generated
+	  (low power) states, for example after a specified period of inactivity
+	  (autosuspended), and woken up in response to a hardware-generated
 	  wake-up event or a driver's request.
 
 	  Hardware support is generally required for this functionality to work
 	  and the bus type drivers of the buses the devices are on are
-	  responsible for the actual handling of the autosuspend requests and
+	  responsible for the actual handling of device suspend requests and
 	  wake-up events.
 
-config PM
-	def_bool y
-	depends on PM_SLEEP || PM_RUNTIME
