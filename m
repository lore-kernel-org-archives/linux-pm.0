From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 04/04] sh: Runtime platform device PM mockup
Date: Wed, 27 May 2009 19:06:59 +0900
Message-ID: <20090527100659.29671.16510.sendpatchset__31845.842608209$1243419083$gmane$org@rx1.opensource.se>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
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
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Make use of platform device runtime pm functions.

The patch contains changes in the following order:
1) Kconfig stuff, enables patch [01/04] to [03/04]
2) SuperH specific platform device data and harware block id
3) Mark platform devices with hardware block id
4) Change a few drivers to use idle and wakeup (todo: replace clocks)
5) Runtime PM mockup using delayed work to freeze devices.

The code does not really do anything useful apart from printing out
which devices to freeze and wakeup. The freezing may be driven from
cpuidle demand instead. Locking needs more work.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                            |    3 
 arch/sh/boards/mach-migor/setup.c          |    9 ++
 arch/sh/include/asm/device.h               |    6 +
 arch/sh/include/cpu-sh4/cpu/sh7722.h       |   14 +++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c     |   31 +++++++
 arch/sh/kernel/cpu/shmobile/pm.c           |  118 ++++++++++++++++++++++++++++
 drivers/clocksource/sh_cmt.c               |    2 
 drivers/clocksource/sh_tmu.c               |    2 
 drivers/i2c/busses/i2c-sh_mobile.c         |    2 
 drivers/media/video/sh_mobile_ceu_camera.c |    2 
 drivers/video/sh_mobile_lcdcfb.c           |    4 
 11 files changed, 193 insertions(+)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-05-26 21:22:23.000000000 +0900
@@ -16,6 +16,7 @@ config SUPERH
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DMA_API_DEBUG
 	select RTC_LIB
+	select HAVE_PLATFORM_DEVICE_ARCHDATA
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
@@ -201,6 +202,8 @@ config CPU_SHX3
 config ARCH_SHMOBILE
 	bool
 	select ARCH_SUSPEND_POSSIBLE
+	select HAVE_PLATFORM_DEVICE_IDLE_WAKEUP
+	select HAVE_PLATFORM_DEVICE_RUNTIME_PM
 
 if SUPERH32
 
--- 0001/arch/sh/include/asm/device.h
+++ work/arch/sh/include/asm/device.h	2009-05-26 21:22:23.000000000 +0900
@@ -12,3 +12,9 @@ int platform_resource_setup_memory(struc
 
 void plat_early_device_setup(void);
 
+struct pdev_archdata {
+#ifdef CONFIG_ARCH_SHMOBILE
+	int hw_blk_id;
+	struct list_head entry;
+#endif
+};
--- 0001/arch/sh/include/cpu-sh4/cpu/sh7722.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7722.h	2009-05-26 21:31:31.000000000 +0900
@@ -207,4 +207,18 @@ enum {
 	GPIO_FN_KEYOUT3, GPIO_FN_KEYOUT4_IN6, GPIO_FN_KEYOUT5_IN5,
 };
 
+enum {
+	HW_BLK_UNKNOWN=0,
+	HW_BLK_URAM, HW_BLK_XYMEM,
+	HW_BLK_TMU0, HW_BLK_TMU1, HW_BLK_TMU2,
+	HW_BLK_CMT, HW_BLK_RWDT, HW_BLK_FLCTL,
+	HW_BLK_SCIF0, HW_BLK_SCIF1, HW_BLK_SCIF2,
+	HW_BLK_IIC, HW_BLK_RTC, HW_BLK_SDHI,
+	HW_BLK_KEYSC, HW_BLK_USBF, HW_BLK_2DG,
+	HW_BLK_SIU, HW_BLK_VOU, HW_BLK_JPU,
+	HW_BLK_BEU, HW_BLK_CEU, HW_BLK_VEU,
+	HW_BLK_VPU, HW_BLK_LCDC,
+	HW_BLK_NR,
+};
+
 #endif /* __ASM_SH7722_H__ */
--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2009-05-26 21:22:34.000000000 +0900
@@ -98,6 +98,9 @@ static struct platform_device sh_keysc_d
 	.dev	= {
 		.platform_data	= &sh_keysc_info,
 	},
+	.archdata = {
+		.hw_blk_id = HW_BLK_KEYSC,
+	},
 };
 
 static struct mtd_partition migor_nor_flash_partitions[] =
@@ -292,6 +295,9 @@ static struct platform_device migor_lcdc
 	.dev	= {
 		.platform_data	= &sh_mobile_lcdc_info,
 	},
+	.archdata = {
+		.hw_blk_id = HW_BLK_LCDC,
+	},
 };
 
 static struct clk *camera_clk;
@@ -379,6 +385,9 @@ static struct platform_device migor_ceu_
 	.dev	= {
 		.platform_data	= &sh_mobile_ceu_info,
 	},
+	.archdata = {
+		.hw_blk_id = HW_BLK_CEU,
+	},
 };
 
 static struct ov772x_camera_info ov7725_info = {
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2009-05-26 21:22:23.000000000 +0900
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
+		.hw_blk_id = HW_BLK_RTC,
+	},
 };
 
 static struct resource usbf_resources[] = {
@@ -70,6 +74,9 @@ static struct platform_device usbf_devic
 	},
 	.num_resources	= ARRAY_SIZE(usbf_resources),
 	.resource	= usbf_resources,
+	.archdata = {
+		.hw_blk_id = HW_BLK_USBF,
+	},
 };
 
 static struct resource iic_resources[] = {
@@ -91,6 +98,9 @@ static struct platform_device iic_device
 	.id             = 0, /* "i2c0" clock */
 	.num_resources  = ARRAY_SIZE(iic_resources),
 	.resource       = iic_resources,
+	.archdata = {
+		.hw_blk_id = HW_BLK_IIC,
+	},
 };
 
 static struct uio_info vpu_platform_data = {
@@ -119,6 +129,9 @@ static struct platform_device vpu_device
 	},
 	.resource	= vpu_resources,
 	.num_resources	= ARRAY_SIZE(vpu_resources),
+	.archdata = {
+		.hw_blk_id = HW_BLK_VPU,
+	},
 };
 
 static struct uio_info veu_platform_data = {
@@ -147,6 +160,9 @@ static struct platform_device veu_device
 	},
 	.resource	= veu_resources,
 	.num_resources	= ARRAY_SIZE(veu_resources),
+	.archdata = {
+		.hw_blk_id = HW_BLK_VEU,
+	},
 };
 
 static struct uio_info jpu_platform_data = {
@@ -175,6 +191,9 @@ static struct platform_device jpu_device
 	},
 	.resource	= jpu_resources,
 	.num_resources	= ARRAY_SIZE(jpu_resources),
+	.archdata = {
+		.hw_blk_id = HW_BLK_JPU,
+	},
 };
 
 static struct sh_timer_config cmt_platform_data = {
@@ -207,6 +226,9 @@ static struct platform_device cmt_device
 	},
 	.resource	= cmt_resources,
 	.num_resources	= ARRAY_SIZE(cmt_resources),
+	.archdata = {
+		.hw_blk_id = HW_BLK_CMT,
+	},
 };
 
 static struct sh_timer_config tmu0_platform_data = {
@@ -238,6 +260,9 @@ static struct platform_device tmu0_devic
 	},
 	.resource	= tmu0_resources,
 	.num_resources	= ARRAY_SIZE(tmu0_resources),
+	.archdata = {
+		.hw_blk_id = HW_BLK_TMU0,
+	},
 };
 
 static struct sh_timer_config tmu1_platform_data = {
@@ -269,6 +294,9 @@ static struct platform_device tmu1_devic
 	},
 	.resource	= tmu1_resources,
 	.num_resources	= ARRAY_SIZE(tmu1_resources),
+	.archdata = {
+		.hw_blk_id = HW_BLK_TMU1,
+	},
 };
 
 static struct sh_timer_config tmu2_platform_data = {
@@ -299,6 +327,9 @@ static struct platform_device tmu2_devic
 	},
 	.resource	= tmu2_resources,
 	.num_resources	= ARRAY_SIZE(tmu2_resources),
+	.archdata = {
+		.hw_blk_id = HW_BLK_TMU2,
+	},
 };
 
 static struct plat_sci_port sci_platform_data[] = {
--- 0001/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2009-05-26 21:22:23.000000000 +0900
@@ -153,6 +153,7 @@ static int sh_cmt_enable(struct sh_cmt_p
 	int ret;
 
 	/* enable clock */
+	platform_device_wakeup(p->pdev);
 	ret = clk_enable(p->clk);
 	if (ret) {
 		pr_err("sh_cmt: cannot enable clock \"%s\"\n", cfg->clk);
@@ -186,6 +187,7 @@ static void sh_cmt_disable(struct sh_cmt
 
 	/* stop clock */
 	clk_disable(p->clk);
+	platform_device_idle(p->pdev);
 }
 
 /* private flags */
--- 0001/drivers/clocksource/sh_tmu.c
+++ work/drivers/clocksource/sh_tmu.c	2009-05-26 21:22:23.000000000 +0900
@@ -110,6 +110,7 @@ static int sh_tmu_enable(struct sh_tmu_p
 	int ret;
 
 	/* enable clock */
+	platform_device_wakeup(p->pdev);
 	ret = clk_enable(p->clk);
 	if (ret) {
 		pr_err("sh_tmu: cannot enable clock \"%s\"\n", cfg->clk);
@@ -140,6 +141,7 @@ static void sh_tmu_disable(struct sh_tmu
 
 	/* stop clock */
 	clk_disable(p->clk);
+	platform_device_idle(p->pdev);
 }
 
 static void sh_tmu_set_next(struct sh_tmu_priv *p, unsigned long delta,
--- 0001/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2009-05-26 21:30:56.000000000 +0900
@@ -166,6 +166,7 @@ static void activate_ch(struct sh_mobile
 	u_int32_t tmp;
 
 	/* Make sure the clock is enabled */
+	platform_device_wakeup(to_platform_device(pd->dev));
 	clk_enable(pd->clk);
 
 	/* Get clock rate after clock is enabled */
@@ -215,6 +216,7 @@ static void deactivate_ch(struct sh_mobi
 
 	/* Disable clock */
 	clk_disable(pd->clk);
+	platform_device_idle(to_platform_device(pd->dev));
 }
 
 static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
--- 0001/drivers/media/video/sh_mobile_ceu_camera.c
+++ work/drivers/media/video/sh_mobile_ceu_camera.c	2009-05-26 21:22:23.000000000 +0900
@@ -364,6 +364,7 @@ static int sh_mobile_ceu_add_device(stru
 	if (ret)
 		goto err;
 
+	platform_device_wakeup(to_platform_device(ici->dev));
 	clk_enable(pcdev->clk);
 
 	ceu_write(pcdev, CAPSR, 1 << 16); /* reset */
@@ -399,6 +400,7 @@ static void sh_mobile_ceu_remove_device(
 	spin_unlock_irqrestore(&pcdev->lock, flags);
 
 	clk_disable(pcdev->clk);
+	platform_device_idle(to_platform_device(pcdev->ici.dev));
 
 	icd->ops->release(icd);
 
--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2009-05-26 21:30:39.000000000 +0900
@@ -38,6 +38,7 @@ struct sh_mobile_lcdc_chan {
 };
 
 struct sh_mobile_lcdc_priv {
+	struct platform_device *pdev;
 	void __iomem *base;
 	int irq;
 #ifdef CONFIG_HAVE_CLK
@@ -185,6 +186,7 @@ struct sh_mobile_lcdc_sys_bus_ops sh_mob
 #ifdef CONFIG_HAVE_CLK
 static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 {
+	platform_device_wakeup(priv->pdev);
 	if (atomic_inc_and_test(&priv->clk_usecnt)) {
 		clk_enable(priv->clk);
 		if (priv->dot_clk)
@@ -199,6 +201,7 @@ static void sh_mobile_lcdc_clk_off(struc
 			clk_disable(priv->dot_clk);
 		clk_disable(priv->clk);
 	}
+	platform_device_idle(priv->pdev);
 }
 #else
 static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv) {}
@@ -744,6 +747,7 @@ static int __init sh_mobile_lcdc_probe(s
 	}
 
 	priv->irq = i;
+	priv->pdev = pdev;
 	platform_set_drvdata(pdev, priv);
 	pdata = pdev->dev.platform_data;
 
--- 0001/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-05-26 21:22:23.000000000 +0900
@@ -13,8 +13,10 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/suspend.h>
+#include <linux/platform_device.h>
 #include <asm/suspend.h>
 #include <asm/uaccess.h>
+#include <cpu/sh7722.h>
 
 /*
  * Sleep modes available on SuperH Mobile:
@@ -90,3 +92,119 @@ static int __init sh_pm_init(void)
 }
 
 late_initcall(sh_pm_init);
+
+static DECLARE_BITMAP(hw_blks_added, HW_BLK_NR);
+static DECLARE_BITMAP(hw_blks_idle, HW_BLK_NR);
+static DECLARE_BITMAP(hw_blks_frozen, HW_BLK_NR);
+
+static DEFINE_SPINLOCK(hw_blk_lock);
+static LIST_HEAD(hw_blk_list);
+
+#define PLATFORM_PM_IDLE_DELAY 1000 /* ms */
+
+static void platform_device_freezer(struct work_struct *work);
+static DECLARE_DELAYED_WORK(hw_blk_delayed_work, platform_device_freezer);
+
+static void platform_device_schedule_work(int id)
+{
+	schedule_delayed_work(&hw_blk_delayed_work, PLATFORM_PM_IDLE_DELAY);
+}
+
+static void platform_device_freezer(struct work_struct *work)
+{
+	struct platform_device *pdev;
+	int id;
+
+	spin_lock(&hw_blk_lock);
+	list_for_each_entry(pdev, &hw_blk_list, archdata.entry) {
+		id = pdev->archdata.hw_blk_id;
+
+		if (test_bit(id, hw_blks_idle) &&
+		    !test_bit(id, hw_blks_frozen)) {
+
+			printk("freezing idle device %d!\n",
+			       pdev->archdata.hw_blk_id);
+
+			platform_runtime_dev_pm_ops.freeze_noirq(&pdev->dev);
+			__set_bit(pdev->archdata.hw_blk_id, hw_blks_frozen);
+		}
+	}
+	spin_unlock(&hw_blk_lock);
+}
+
+void platform_device_wakeup(struct platform_device *pdev)
+{
+	int id = pdev->archdata.hw_blk_id;
+
+	/* ignore off-chip or already woken up platform devices */
+	if (!id || !test_bit(id, hw_blks_idle))
+		return;
+	
+	spin_lock(&hw_blk_lock);
+	if (test_bit(id, hw_blks_frozen)) {
+		printk("waking up frozen device %d!\n", id);
+
+		platform_runtime_dev_pm_ops.thaw_noirq(&pdev->dev);
+		__clear_bit(id, hw_blks_frozen);
+	}
+	spin_unlock(&hw_blk_lock);
+	clear_bit(id, hw_blks_idle);
+}
+
+void platform_device_idle(struct platform_device *pdev)
+{
+	int id = pdev->archdata.hw_blk_id;
+
+	/* ignore off-chip non-SoC platform devices */
+	if (!id)
+		return;
+
+	set_bit(id, hw_blks_idle);
+	if (test_bit(id, hw_blks_added))
+		platform_device_schedule_work(id);
+}
+
+static int __devinit platform_bus_notify(struct notifier_block *nb,
+					 unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct platform_device *pdev = to_platform_device(dev);
+	int id = pdev->archdata.hw_blk_id;
+
+	/* ignore off-chip non-SoC platform devices */
+	if (!id)
+		return 0;
+
+	switch(action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		INIT_LIST_HEAD(&pdev->archdata.entry);
+
+		spin_lock(&hw_blk_lock);
+		list_add_tail(&pdev->archdata.entry, &hw_blk_list);
+		__set_bit(id, hw_blks_added);
+		spin_unlock(&hw_blk_lock);
+
+		if (test_bit(id, hw_blks_idle))
+			platform_device_schedule_work(id);
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		spin_lock(&hw_blk_lock);
+		list_del(&pdev->archdata.entry);
+		__clear_bit(id, hw_blks_added);
+		spin_unlock(&hw_blk_lock);
+		break;
+	}
+	return 0;
+}
+
+static struct notifier_block platform_bus_notifier = {
+	.notifier_call = platform_bus_notify
+};
+
+static int __init sh_pm_runtime_init(void)
+{
+	bus_register_notifier(&platform_bus_type, &platform_bus_notifier);
+	return 0;
+}
+
+arch_initcall(sh_pm_runtime_init);
