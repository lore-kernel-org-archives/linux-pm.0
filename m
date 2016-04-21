From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Wed, 20 Apr 2016 21:56:07 -0700
Message-ID: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, oleg@redhat.com, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lianwei Wang <lianwei.wang@gmail.com>
List-Id: linux-pm@vger.kernel.org

Currently it just print a warning message but did not
reset cpu_hotplug_disabled when the enable/disable is
unbalanced. The unbalanced enable/disable will lead
the cpu hotplug work abnormally.

Reset it to 0 when an unablanced enable detected.

Signed-off-by: Lianwei Wang <lianwei.wang@gmail.com>
---
 kernel/cpu.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ea42e8da861..fef6caed77a3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -243,6 +243,19 @@ void cpu_hotplug_done(void)
 	cpuhp_lock_release();
 }
 
+static void _cpu_hotplug_disable(void)
+{
+	cpu_hotplug_disabled++;
+}
+
+static void _cpu_hotplug_enable(void)
+{
+	if (--cpu_hotplug_disabled < 0) {
+		WARN(1, "unbalanced hotplug enable %d\n", cpu_hotplug_disabled);
+		cpu_hotplug_disabled = 0;
+	}
+}
+
 /*
  * Wait for currently running CPU hotplug operations to complete (if any) and
  * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
@@ -253,7 +266,7 @@ void cpu_hotplug_done(void)
 void cpu_hotplug_disable(void)
 {
 	cpu_maps_update_begin();
-	cpu_hotplug_disabled++;
+	_cpu_hotplug_disable();
 	cpu_maps_update_done();
 }
 EXPORT_SYMBOL_GPL(cpu_hotplug_disable);
@@ -261,7 +274,7 @@ EXPORT_SYMBOL_GPL(cpu_hotplug_disable);
 void cpu_hotplug_enable(void)
 {
 	cpu_maps_update_begin();
-	WARN_ON(--cpu_hotplug_disabled < 0);
+	_cpu_hotplug_enable();
 	cpu_maps_update_done();
 }
 EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
@@ -1053,7 +1066,7 @@ int disable_nonboot_cpus(void)
 	 * this even in case of failure as all disable_nonboot_cpus() users are
 	 * supposed to do enable_nonboot_cpus() on the failure path.
 	 */
-	cpu_hotplug_disabled++;
+	_cpu_hotplug_disable();
 
 	cpu_maps_update_done();
 	return error;
@@ -1073,7 +1086,7 @@ void enable_nonboot_cpus(void)
 
 	/* Allow everyone to use the CPU hotplug again */
 	cpu_maps_update_begin();
-	WARN_ON(--cpu_hotplug_disabled < 0);
+	_cpu_hotplug_enable();
 	if (cpumask_empty(frozen_cpus))
 		goto out;
 
-- 
1.9.1
