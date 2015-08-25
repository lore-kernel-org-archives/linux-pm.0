From: Abylay Ospan <aospan@netup.ru>
Subject: [PATCH v2] x86 kernel crash fix when thermal interrupt called
Date: Tue, 25 Aug 2015 04:31:51 -0400
Message-ID: <1440491511-2751-1-git-send-email-aospan@netup.ru>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from team.netup.ru ([77.72.80.1]:54052 "EHLO a-desktop"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754825AbbHYIkM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 25 Aug 2015 04:40:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: Abylay Ospan <aospan@netup.ru>

1. platform_thermal_package_notify can be called while initialization not
complete. In this case pkg_temp_thermal_threshold_work not inited and we got
kernel crash:
[   86.158612] kernel BUG at kernel/time/timer.c:973!
[   86.187998] invalid opcode: 0000 [#1] PREEMPT SMP
...
[   87.162383] Call Trace:
[   87.177624]  <IRQ>
[   87.189170]  [<ffffffff8106964a>] __queue_delayed_work+0x12a/0x160
[   87.228490]  [<ffffffff810696c5>] queue_delayed_work_on+0x45/0x80
[   87.265525]  [<ffffffffa05880d7>]
pkg_temp_thermal_platform_thermal_notify+0xb7/0x110 [x86_pkg_temp_thermal]
[   87.324973]  [<ffffffff8102f201>] intel_thermal_interrupt+0x201/0x240
[   87.364138]  [<ffffffff8102f25b>] smp_thermal_interrupt+0x1b/0x40
[   87.401221]  [<ffffffff81ebcf00>] thermal_interrupt+0x70/0x80

2. platform_thermal_package_notify can became NULL when 'rmmod
x86_pkg_temp_thermal' called (race condition). In this case we got kernel
crash in interrupt handler:
[30864.490949] BUG: unable to handle kernel NULL pointer dereference at
(null)
[30864.538114] IP: [<          (null)>]           (null)
...
[30865.456589] Stack:
[30865.468664]  ffffffff8102f201 ffff88021dd15680 ffff88021dd15680
ffff88021dd15680
[30865.513446]  ffff8801ef35b300 ffff88021dd03fa8 ffffffff8102f25b
ffff8801f0a17918
[30865.558272]  ffffffff81ebcf00 ffff8801f0a17878 <EOI>  ffff8801f0a17918
0000000000000001
[30865.606852] Call Trace:
[30865.621521]  <IRQ>
[30865.633099]  [<ffffffff8102f201>] ? intel_thermal_interrupt+0x201/0x240
[30865.674029]  [<ffffffff8102f25b>] smp_thermal_interrupt+0x1b/0x40
[30865.710640]  [<ffffffff81ebcf00>] thermal_interrupt+0x70/0x80

Reproduce:
Heat system for critical temp and check that thermal interrupts are processed:
# cat /sys/kernel/debug/pkg_temp_thermal/pkg_thres_interrupt
3600

then reload x86_pkg_temp_thermal module in cycle:
# while [ 1 ]; do rmmod x86_pkg_temp_thermal; modprobe x86_pkg_temp_thermal;
done

without this patch you will get one of above kernel crash (1 or 2).

Signed-off-by: Abylay Ospan <aospan@netup.ru>
---
 arch/x86/include/asm/mce.h               |  3 +++
 arch/x86/kernel/cpu/mcheck/therm_throt.c | 18 ++++++++++++++++--
 drivers/thermal/x86_pkg_temp_thermal.c   | 31 +++++++++++++++++++++++--------
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 982dfc3..7313119 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -255,6 +255,9 @@ void intel_init_thermal(struct cpuinfo_x86 *c);
 
 void mce_log_therm_throt_event(__u64 status);
 
+/* Protect callback handling core threshold interrupts */
+extern spinlock_t platform_thermal_lock;
+
 /* Interrupt Handler for core thermal thresholds */
 extern int (*platform_thermal_notify)(__u64 msr_val);
 
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 1af51b1..d361f13 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -72,6 +72,9 @@ EXPORT_SYMBOL_GPL(platform_thermal_package_notify);
 bool (*platform_thermal_package_rate_control)(void);
 EXPORT_SYMBOL_GPL(platform_thermal_package_rate_control);
 
+/* Protect callback handling core threshold interrupts */
+spinlock_t platform_thermal_lock;
+EXPORT_SYMBOL_GPL(platform_thermal_lock);
 
 static DEFINE_PER_CPU(struct thermal_state, thermal_state);
 
@@ -333,9 +336,13 @@ static void notify_package_thresholds(__u64 msr_val)
 {
 	bool notify_thres_0 = false;
 	bool notify_thres_1 = false;
+	unsigned long flags;
 
-	if (!platform_thermal_package_notify)
+	spin_lock_irqsave(&platform_thermal_lock, flags);
+	if (!platform_thermal_package_notify) {
+		spin_unlock_irqrestore(&platform_thermal_lock, flags);
 		return;
+	}
 
 	/* lower threshold check */
 	if (msr_val & THERM_LOG_THRESHOLD0)
@@ -344,13 +351,16 @@ static void notify_package_thresholds(__u64 msr_val)
 	if (msr_val & THERM_LOG_THRESHOLD1)
 		notify_thres_1 = true;
 
-	if (!notify_thres_0 && !notify_thres_1)
+	if (!notify_thres_0 && !notify_thres_1) {
+		spin_unlock_irqrestore(&platform_thermal_lock, flags);
 		return;
+	}
 
 	if (platform_thermal_package_rate_control &&
 		platform_thermal_package_rate_control()) {
 		/* Rate control is implemented in callback */
 		platform_thermal_package_notify(msr_val);
+		spin_unlock_irqrestore(&platform_thermal_lock, flags);
 		return;
 	}
 
@@ -360,6 +370,8 @@ static void notify_package_thresholds(__u64 msr_val)
 	/* higher threshold reached */
 	if (notify_thres_1 && thresh_event_valid(PACKAGE_LEVEL, 1))
 		platform_thermal_package_notify(msr_val);
+
+	spin_unlock_irqrestore(&platform_thermal_lock, flags);
 }
 
 static void notify_thresholds(__u64 msr_val)
@@ -475,6 +487,8 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	if (!intel_thermal_supported(c))
 		return;
 
+	spin_lock_init(&platform_thermal_lock);
+
 	/*
 	 * First check if its enabled already, in which case there might
 	 * be some SMM goo which handles it, so we can't even put a handler
diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 50d1d2c..8569dc9 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -567,6 +567,24 @@ static int pkg_temp_thermal_cpu_callback(struct notifier_block *nfb,
 	return NOTIFY_OK;
 }
 
+/* Safe registration of callback */
+static void enable_thermal_callback(bool onoff)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&platform_thermal_lock, flags);
+	if (onoff) {
+		platform_thermal_package_notify =
+			pkg_temp_thermal_platform_thermal_notify;
+		platform_thermal_package_rate_control =
+			pkg_temp_thermal_platform_thermal_rate_control;
+	} else {
+		platform_thermal_package_notify = NULL;
+		platform_thermal_package_rate_control = NULL;
+	}
+	spin_unlock_irqrestore(&platform_thermal_lock, flags);
+}
+
 static struct notifier_block pkg_temp_thermal_notifier __refdata = {
 	.notifier_call = pkg_temp_thermal_cpu_callback,
 };
@@ -585,10 +603,6 @@ static int __init pkg_temp_thermal_init(void)
 		return -ENODEV;
 
 	spin_lock_init(&pkg_work_lock);
-	platform_thermal_package_notify =
-			pkg_temp_thermal_platform_thermal_notify;
-	platform_thermal_package_rate_control =
-			pkg_temp_thermal_platform_thermal_rate_control;
 
 	cpu_notifier_register_begin();
 	for_each_online_cpu(i)
@@ -597,17 +611,18 @@ static int __init pkg_temp_thermal_init(void)
 	__register_hotcpu_notifier(&pkg_temp_thermal_notifier);
 	cpu_notifier_register_done();
 
+	enable_thermal_callback(true);
+
 	pkg_temp_debugfs_init(); /* Don't care if fails */
 
 	return 0;
 
 err_ret:
+	enable_thermal_callback(false);
 	for_each_online_cpu(i)
 		put_core_offline(i);
 	cpu_notifier_register_done();
 	kfree(pkg_work_scheduled);
-	platform_thermal_package_notify = NULL;
-	platform_thermal_package_rate_control = NULL;
 
 	return -ENODEV;
 }
@@ -617,6 +632,8 @@ static void __exit pkg_temp_thermal_exit(void)
 	struct phy_dev_entry *phdev, *n;
 	int i;
 
+	enable_thermal_callback(false);
+
 	cpu_notifier_register_begin();
 	__unregister_hotcpu_notifier(&pkg_temp_thermal_notifier);
 	mutex_lock(&phy_dev_list_mutex);
@@ -631,8 +648,6 @@ static void __exit pkg_temp_thermal_exit(void)
 		kfree(phdev);
 	}
 	mutex_unlock(&phy_dev_list_mutex);
-	platform_thermal_package_notify = NULL;
-	platform_thermal_package_rate_control = NULL;
 	for_each_online_cpu(i)
 		cancel_delayed_work_sync(
 			&per_cpu(pkg_temp_thermal_threshold_work, i));
-- 
2.1.4

