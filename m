From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: [PATCH] OLPC rtc-cmos support
Date: Sun, 8 Jul 2007 14:40:35 -0400
Message-ID: <20070708184035.GA20078__32112.1885012419$1183920280$gmane$org@dmt>
References: <20070330235759.GC4252@cosmic.amd.com>
	<20070402165511.GD5024@cosmic.amd.com> <20070708035504.GC19633@dmt>
	<200707072213.41028.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707072213.41028.david-b@pacbell.net>
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

On Sat, Jul 07, 2007 at 10:13:40PM -0700, David Brownell wrote:
> On Saturday 07 July 2007, Marcelo Tosatti wrote:
> > 
> > Hi,
> > 
> > The following patch implements the hooks necessary for OLPC to use the
> > rtc-cmos driver. This is necessary since we do not want CONFIG_PNP.
> > 
> > This makes it possible to control rtc wakeup via
> > /sys/devices/platform/rtc_cmos/power/wakeup.
> > 
> > Comments?
> 
> Looks almost right ... though I'd have expected the RTC to
> support alarms more than just 24 hours into the future!
> 
> It's more complicated than necessary.  It'd be much simpler
> to just declare a static platform_device with pre-initted
> platform_data.  Then call device_init_wakeup() on that before
> calling the usual platform_device_register() routine.
> 
> That way you wouldn't need to have two different init sections
> just to set up one device, where one of them is spending most
> of its time working around the possibility that the other one
> failed.  And you'd also pretty much eliminate the possibility
> that the (now) single init section fails.  :)

David,

Like this? 


diff --git a/arch/i386/kernel/olpc-pm.c b/arch/i386/kernel/olpc-pm.c
index 9599dbe..8072e68 100644
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
@@ -549,6 +554,65 @@ static int __init olpc_pm_init(void)
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
+
+static struct cmos_rtc_board_info rtc_info;
+
+struct platform_device olpc_rtc_device = {
+	.name = "rtc_cmos",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(rtc_platform_resource),
+	.dev.platform_data = &rtc_info,
+	.resource = rtc_platform_resource,
+};
+
+struct resource rtc_platform_irq = {
+	.flags = IORESOURCE_IRQ,
+	.start = 8,
+	.end = 8,
+};
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
+static int olpc_rtc_init(void)
+{
+	rtc_info.rtc_day_alarm = 0;
+	rtc_info.rtc_mon_alarm = 0;
+	rtc_info.rtc_century = 0;
+	rtc_info.wake_on = rtc_wake_on;
+	rtc_info.wake_off = rtc_wake_off;
+
+	(void)platform_device_register(&olpc_rtc_device);
+
+	device_init_wakeup(&olpc_rtc_device.dev, 1);
+
+	return 0;
+}
+fs_initcall(olpc_rtc_init);
+#endif /* CONFIG_RTC_DRV_CMOS */
+
 static void olpc_pm_exit(void)
 {
 	/* Clear any pending events, and disable them */
