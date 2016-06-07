From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: [PATCH v2] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Mon,  6 Jun 2016 22:57:01 -0700
Message-ID: <1465279021-3299-1-git-send-email-lianwei.wang@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32814 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbcFGF5P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 01:57:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, oleg@redhat.com, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lianwei Wang <lianwei.wang@gmail.com>

Currently it just print a warning message but did not
reset cpu_hotplug_disabled when the enable/disable is
unbalanced. The unbalanced enable/disable will lead
the cpu hotplug work abnormally.

Do nothing if an unablanced hotplug enable detected.

Signed-off-by: Lianwei Wang <lianwei.wang@gmail.com>
---
 kernel/cpu.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3e3f6e49eabb..8011b1e40523 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -245,6 +245,19 @@ void cpu_hotplug_done(void)
 	cpuhp_lock_release();
 }
 
+static void _cpu_hotplug_disable(void)
+{
+	cpu_hotplug_disabled++;
+}
+
+static void _cpu_hotplug_enable(void)
+{
+	if (WARN(!cpu_hotplug_disabled, "Unbalanced cpu hotplug enable\n"))
+		return;
+
+	cpu_hotplug_disabled--;
+}
+
 /*
  * Wait for currently running CPU hotplug operations to complete (if any) and
  * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
@@ -255,7 +268,7 @@ void cpu_hotplug_done(void)
 void cpu_hotplug_disable(void)
 {
 	cpu_maps_update_begin();
-	cpu_hotplug_disabled++;
+	_cpu_hotplug_disable();
 	cpu_maps_update_done();
 }
 EXPORT_SYMBOL_GPL(cpu_hotplug_disable);
@@ -263,7 +276,7 @@ EXPORT_SYMBOL_GPL(cpu_hotplug_disable);
 void cpu_hotplug_enable(void)
 {
 	cpu_maps_update_begin();
-	WARN_ON(--cpu_hotplug_disabled < 0);
+	_cpu_hotplug_enable();
 	cpu_maps_update_done();
 }
 EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
@@ -1071,7 +1084,7 @@ int disable_nonboot_cpus(void)
 	 * this even in case of failure as all disable_nonboot_cpus() users are
 	 * supposed to do enable_nonboot_cpus() on the failure path.
 	 */
-	cpu_hotplug_disabled++;
+	_cpu_hotplug_disable();
 
 	cpu_maps_update_done();
 	return error;
@@ -1091,7 +1104,7 @@ void enable_nonboot_cpus(void)
 
 	/* Allow everyone to use the CPU hotplug again */
 	cpu_maps_update_begin();
-	WARN_ON(--cpu_hotplug_disabled < 0);
+	_cpu_hotplug_enable();
 	if (cpumask_empty(frozen_cpus))
 		goto out;
 
-- 
1.9.1

