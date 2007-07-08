From: Marcelo Tosatti <marcelo@kvack.org>
Subject: [PATCH] OLPC rtc-cmos support
Date: Sat, 7 Jul 2007 23:55:04 -0400
Message-ID: <20070708035504.GC19633__38682.0750347853$1183866897$gmane$org@dmt>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703312001.55231.david-b@pacbell.net>
	<20070401165601.GA13389@cosmic.amd.com>
	<200704011728.10966.david-b@pacbell.net>
	<20070402165511.GD5024@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070402165511.GD5024@cosmic.amd.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

The following patch implements the hooks necessary for OLPC to use the
rtc-cmos driver. This is necessary since we do not want CONFIG_PNP.

This makes it possible to control rtc wakeup via
/sys/devices/platform/rtc_cmos/power/wakeup.

Comments?


diff --git a/arch/i386/kernel/olpc-pm.c b/arch/i386/kernel/olpc-pm.c
index 9599dbe..d92c54a 100644
--- a/arch/i386/kernel/olpc-pm.c
+++ b/arch/i386/kernel/olpc-pm.c
@@ -11,6 +11,9 @@ #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/suspend.h>
 #include <linux/bootmem.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/mc146818rtc.h>
 #include <asm/io.h>
 
 #include <asm/olpc.h>
@@ -272,6 +275,8 @@ static int olpc_pm_enter(suspend_state_t
 	return 0;
 }
 
+static u16 olpc_wakeup_mask = CS5536_PM_PWRBTN;
+
 int asmlinkage olpc_do_sleep(u8 sleep_state)
 {
 	void *pgd_addr = __va(read_cr3());
@@ -282,7 +287,7 @@ int asmlinkage olpc_do_sleep(u8 sleep_st
 
 	/* FIXME:  Set any other SCI events that we might want here */
 
-	outl((CS5536_PM_PWRBTN << 16) | 0xFFFF, acpi_base + PM1_STS);
+	outl((olpc_wakeup_mask << 16) | 0xFFFF, acpi_base + PM1_STS);
 
 	/* If we are in test mode, then just return (simulate a successful
 	   suspend/resume).  Otherwise, if we are doing the real thing,
@@ -549,6 +554,92 @@ static int __init olpc_pm_init(void)
 	return 0;
 }
 
+
+#if defined (CONFIG_RTC_DRV_CMOS) || defined (CONFIG_RTC_DRV_CMOS_MODULE)
+struct resource rtc_platform_resource[2] = {
+	{
+		.flags		= IORESOURCE_IO,
+		.start		= RTC_PORT(0),
+		.end		= RTC_PORT(0) + RTC_IO_EXTENT
+	},
+	{
+		.flags = IORESOURCE_IRQ,
+		.start = 8,
+		.end = 8,
+	},
+};
+
+struct resource rtc_platform_irq = {
+	.flags = IORESOURCE_IRQ,
+	.start = 8,
+	.end = 8,
+};
+
+static int olpc_add_rtc(void)
+{
+	struct platform_device *pd;
+
+	pd = platform_device_register_simple("rtc_cmos", -1,
+					     rtc_platform_resource, 2);
+	if (IS_ERR(pd)) 
+		return PTR_ERR(pd);
+
+	/* rtc-cmos only supports 24-hr mode */
+	CMOS_WRITE(CMOS_READ(RTC_CONTROL) | RTC_24H, RTC_CONTROL);
+
+	return 0;
+}
+arch_initcall(olpc_add_rtc);
+
+static struct cmos_rtc_board_info rtc_info;
+
+static void rtc_wake_on(struct device *dev)
+{
+	olpc_wakeup_mask |= CS5536_PM_RTC;
+}
+
+static void rtc_wake_off(struct device *dev)
+{
+	olpc_wakeup_mask &= ~(CS5536_PM_RTC);
+}
+
+static int rtc_match(struct device *dev, void *data)
+{
+	static const char *devname = { "rtc_cmos" };
+	struct rtc_device *rtcdev = to_rtc_device(dev);
+
+	if (!strcmp(devname, rtcdev->name))
+		return 1;
+
+	return 0;
+}
+
+static struct device * get_rtc_dev(void)
+{
+        return bus_find_device(&platform_bus_type, NULL, NULL, rtc_match);
+}
+
+static int olpc_rtc_init(void)
+{
+	struct device *dev = get_rtc_dev();
+
+	if (dev) {
+		rtc_info.rtc_day_alarm = 0;
+		rtc_info.rtc_mon_alarm = 0;
+		rtc_info.rtc_century = 0;
+		rtc_info.wake_on = rtc_wake_on;
+		rtc_info.wake_off = rtc_wake_off;
+
+		dev->platform_data = &rtc_info;
+
+		device_init_wakeup(dev, 1);
+	} else 
+		printk(KERN_ERR "no rtc\n");
+	return 0;
+}
+fs_initcall(olpc_rtc_init);
+#endif /* CONFIG_RTC_DRV_CMOS */
+
 static void olpc_pm_exit(void)
 {
 	/* Clear any pending events, and disable them */
