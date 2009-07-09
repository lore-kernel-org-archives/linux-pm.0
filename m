From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 04/06] sh: Runtime PM for sh7722 and Migo-R
Date: Fri, 10 Jul 2009 00:20:02 +0900
Message-ID: <20090709152002.8385.30419.sendpatchset__19747.3952932798$1247153089$gmane$org@rx1.opensource.se>
References: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch contains sh7722 processor specific Runtime PM code
along with some Migo-R board code that deals with sh7722.

For each platform device within the SoC a hwblk id is added
to the architecture specific platform device data area. The
hwblk code for sh7722 which is invoked by cpuidle is extended
in a hackish way to tell the system to start driver suspending.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-migor/setup.c      |    9 +++++++++
 arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c |   10 +++++++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   31 +++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2009-07-09 18:43:42.000000000 +0900
@@ -98,6 +98,9 @@ static struct platform_device sh_keysc_d
 	.dev	= {
 		.platform_data	= &sh_keysc_info,
 	},
+	.archdata = {
+		.hw_blk_id = HWBLK_KEYSC,
+	},
 };
 
 static struct mtd_partition migor_nor_flash_partitions[] =
@@ -292,6 +295,9 @@ static struct platform_device migor_lcdc
 	.dev	= {
 		.platform_data	= &sh_mobile_lcdc_info,
 	},
+	.archdata = {
+		.hw_blk_id = HWBLK_LCDC,
+	},
 };
 
 static struct clk *camera_clk;
@@ -379,6 +385,9 @@ static struct platform_device migor_ceu_
 	.dev	= {
 		.platform_data	= &sh_mobile_ceu_info,
 	},
+	.archdata = {
+		.hw_blk_id = HWBLK_CEU,
+	},
 };
 
 struct spi_gpio_platform_data sdcard_cn9_platform_data = {
--- 0005/arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c	2009-07-09 18:44:44.000000000 +0900
@@ -89,10 +89,18 @@ static struct hwblk_info sh7722_hwblk_in
 	.nr_hwblks = ARRAY_SIZE(sh7722_hwblk),
 };
 
+void platform_pm_runtime_suspend_idle(void); /* FIXME */
+
 int arch_hwblk_sleep_mode(void)
 {
-	if (!sh7722_hwblk_area[CORE_AREA].cnt[HWBLK_CNT_USAGE])
+	if (!sh7722_hwblk_area[CORE_AREA].cnt[HWBLK_CNT_USAGE]) {
+		if (sh7722_hwblk_area[CORE_AREA].cnt[HWBLK_CNT_IDLE])
+			platform_pm_runtime_suspend_idle();
+		else
+			return SUSP_SH_USTANDBY | SUSP_SH_SF;
+
 		return SUSP_SH_STANDBY | SUSP_SH_SF;
+	}
 
 	if (!sh7722_hwblk_area[CORE_AREA_BM].cnt[HWBLK_CNT_USAGE])
 		return SUSP_SH_SLEEP | SUSP_SH_SF;
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2009-07-09 18:43:36.000000000 +0900
@@ -16,6 +16,7 @@
 #include <linux/sh_timer.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
+#include <cpu/sh7722.h>
 
 static struct resource rtc_resources[] = {
 	[0] = {
@@ -45,6 +46,9 @@ static struct platform_device rtc_device
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(rtc_resources),
 	.resource	= rtc_resources,
+	.archdata = {
+		.hw_blk_id = HWBLK_RTC,
+	},
 };
 
 static struct resource usbf_resources[] = {
@@ -70,6 +74,9 @@ static struct platform_device usbf_devic
 	},
 	.num_resources	= ARRAY_SIZE(usbf_resources),
 	.resource	= usbf_resources,
+	.archdata = {
+		.hw_blk_id = HWBLK_USBF,
+	},
 };
 
 static struct resource iic_resources[] = {
@@ -91,6 +98,9 @@ static struct platform_device iic_device
 	.id             = 0, /* "i2c0" clock */
 	.num_resources  = ARRAY_SIZE(iic_resources),
 	.resource       = iic_resources,
+	.archdata = {
+		.hw_blk_id = HWBLK_IIC,
+	},
 };
 
 static struct uio_info vpu_platform_data = {
@@ -119,6 +129,9 @@ static struct platform_device vpu_device
 	},
 	.resource	= vpu_resources,
 	.num_resources	= ARRAY_SIZE(vpu_resources),
+	.archdata = {
+		.hw_blk_id = HWBLK_VPU,
+	},
 };
 
 static struct uio_info veu_platform_data = {
@@ -147,6 +160,9 @@ static struct platform_device veu_device
 	},
 	.resource	= veu_resources,
 	.num_resources	= ARRAY_SIZE(veu_resources),
+	.archdata = {
+		.hw_blk_id = HWBLK_VEU,
+	},
 };
 
 static struct uio_info jpu_platform_data = {
@@ -175,6 +191,9 @@ static struct platform_device jpu_device
 	},
 	.resource	= jpu_resources,
 	.num_resources	= ARRAY_SIZE(jpu_resources),
+	.archdata = {
+		.hw_blk_id = HWBLK_JPU,
+	},
 };
 
 static struct sh_timer_config cmt_platform_data = {
@@ -207,6 +226,9 @@ static struct platform_device cmt_device
 	},
 	.resource	= cmt_resources,
 	.num_resources	= ARRAY_SIZE(cmt_resources),
+	.archdata = {
+		.hw_blk_id = HWBLK_CMT,
+	},
 };
 
 static struct sh_timer_config tmu0_platform_data = {
@@ -238,6 +260,9 @@ static struct platform_device tmu0_devic
 	},
 	.resource	= tmu0_resources,
 	.num_resources	= ARRAY_SIZE(tmu0_resources),
+	.archdata = {
+		.hw_blk_id = HWBLK_TMU,
+	},
 };
 
 static struct sh_timer_config tmu1_platform_data = {
@@ -269,6 +294,9 @@ static struct platform_device tmu1_devic
 	},
 	.resource	= tmu1_resources,
 	.num_resources	= ARRAY_SIZE(tmu1_resources),
+	.archdata = {
+		.hw_blk_id = HWBLK_TMU,
+	},
 };
 
 static struct sh_timer_config tmu2_platform_data = {
@@ -299,6 +327,9 @@ static struct platform_device tmu2_devic
 	},
 	.resource	= tmu2_resources,
 	.num_resources	= ARRAY_SIZE(tmu2_resources),
+	.archdata = {
+		.hw_blk_id = HWBLK_TMU,
+	},
 };
 
 static struct plat_sci_port sci_platform_data[] = {
