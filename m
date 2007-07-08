From: Marcelo Tosatti <marcelo@kvack.org>
Subject: [PATCH] add powerbutton and lid platform devices
Date: Sun, 8 Jul 2007 18:10:27 -0400
Message-ID: <20070708221027.GA4964__23665.746060624$1183932831$gmane$org@dmt>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200704011728.10966.david-b@pacbell.net>
	<20070619170048.GA342@dmt.media.mit.edu>
	<200706201830.52277.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706201830.52277.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>, Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org

Jordan,

This allows configuration of powerbutton/lid events... Are the 
gpio_gpio_{clear,set} calls correct for enabling/disabling LID
events?

What else do we want to support?

--- olpc-pm.c.orig	2007-07-08 17:09:07.000000000 -0400
+++ olpc-pm.c	2007-07-08 18:07:03.000000000 -0400
@@ -54,6 +54,18 @@
 
 static int gpio_wake_events = 0;
 static int ebook_state = -1;
+static u16 olpc_wakeup_mask = 0;
+
+struct platform_device olpc_powerbutton_dev = {
+	.name = "powerbutton",
+	.id = 0,
+};
+
+struct platform_device olpc_lid_dev = {
+	.name = "lid",
+	.id = 0,
+};
+
 
 static void __init init_ebook_state(void)
 {
@@ -250,6 +262,16 @@
 	/* Save the MFGPT MSRs */
 	rdmsrl(MFGPT_IRQ_MSR, mfgpt_irq_msr);
 	rdmsrl(MFGPT_NR_MSR, mfgpt_nr_msr);
+
+	if (device_may_wakeup(&olpc_powerbutton_dev.dev))
+		olpc_wakeup_mask |= CS5536_PM_PWRBTN;
+	else
+		olpc_wakeup_mask &= ~(CS5536_PM_PWRBTN);
+
+	if (device_may_wakeup(&olpc_lid_dev.dev))
+		geode_gpio_clear(OLPC_GPIO_LID, GPIO_EVENTS_ENABLE);
+	else
+		geode_gpio_set(OLPC_GPIO_LID, GPIO_EVENTS_ENABLE);
 }
 
 static int olpc_pm_enter(suspend_state_t pm_state)
@@ -275,8 +297,6 @@
 	return 0;
 }
 
-static u16 olpc_wakeup_mask = CS5536_PM_PWRBTN;
-
 int asmlinkage olpc_do_sleep(u8 sleep_state)
 {
 	void *pgd_addr = __va(read_cr3());
@@ -596,15 +616,20 @@
 	.resource = rtc_platform_resource,
 };
 
-static int __init olpc_rtc_init(void)
+static int __init olpc_platform_init(void)
 {
 	(void)platform_device_register(&olpc_rtc_device);
-
 	device_init_wakeup(&olpc_rtc_device.dev, 1);
 
+	(void)platform_device_register(&olpc_powerbutton_dev);
+	device_init_wakeup(&olpc_powerbutton_dev.dev, 1);
+
+	(void)platform_device_register(&olpc_lid_dev);
+	device_init_wakeup(&olpc_lid_dev.dev, 1);
+
 	return 0;
 }
-arch_initcall(olpc_rtc_init);
+arch_initcall(olpc_platform_init);
 #endif /* CONFIG_RTC_DRV_CMOS */
 
 static void olpc_pm_exit(void)
