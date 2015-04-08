From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH] ARM: tegra: cpuidle: implement cpuidle_state.enter_freeze()
Date: Wed,  8 Apr 2015 12:54:38 +0200
Message-ID: <1428490480-10144-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34868 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbDHKzK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2015 06:55:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-tegra@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This callback is expected to do the same as enter() only that all
non-wakeup IRQs are expected to be disabled.

It will be called when the system goes to suspend-to-idle and will
reduce power usage because CPUs won't be awaken for unnecessary IRQs.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/arm/mach-tegra/cpuidle-tegra114.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index f2b586d..ef06001 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -39,28 +39,44 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
 				    struct cpuidle_driver *drv,
 				    int index)
 {
-	local_fiq_disable();
-
 	tegra_set_cpu_in_lp2();
 	cpu_pm_enter();
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
-
 	call_firmware_op(prepare_idle);
 
 	/* Do suspend by ourselves if the firmware does not implement it */
 	if (call_firmware_op(do_idle, 0) == -ENOSYS)
 		cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
-
 	cpu_pm_exit();
 	tegra_clear_cpu_in_lp2();
 
+	return index;
+}
+
+static int tegra114_idle_enter(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv,
+			       int index)
+{
+	local_fiq_disable();
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+
+	index = tegra114_idle_power_down(dev, drv, index);
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+
 	local_fiq_enable();
 
 	return index;
 }
+
+static void tegra114_idle_enter_freeze(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv,
+				       int index)
+{
+	tegra114_idle_power_down(dev, drv, index);
+}
 #endif
 
 static struct cpuidle_driver tegra_idle_driver = {
@@ -71,7 +87,8 @@ static struct cpuidle_driver tegra_idle_driver = {
 		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
 #ifdef CONFIG_PM_SLEEP
 		[1] = {
-			.enter			= tegra114_idle_power_down,
+			.enter			= tegra114_idle_enter,
+			.enter_freeze		= tegra114_idle_enter_freeze,
 			.exit_latency		= 500,
 			.target_residency	= 1000,
 			.power_usage		= 0,
-- 
2.3.4

