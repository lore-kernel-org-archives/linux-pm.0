From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: [PATCH v3] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Thu,  9 Jun 2016 23:43:28 -0700
Message-ID: <1465541008-12476-1-git-send-email-lianwei.wang@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33411 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbcFJGnj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 02:43:39 -0400
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
 kernel/cpu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3e3f6e49eabb..5e26a3c64934 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -245,6 +245,14 @@ void cpu_hotplug_done(void)
 	cpuhp_lock_release();
 }
 
+static void __cpu_hotplug_enable(void)
+{
+	if (WARN_ONCE(!cpu_hotplug_disabled, "Unbalanced cpu hotplug enable\n"))
+		return;
+
+	cpu_hotplug_disabled--;
+}
+
 /*
  * Wait for currently running CPU hotplug operations to complete (if any) and
  * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
@@ -263,7 +271,7 @@ EXPORT_SYMBOL_GPL(cpu_hotplug_disable);
 void cpu_hotplug_enable(void)
 {
 	cpu_maps_update_begin();
-	WARN_ON(--cpu_hotplug_disabled < 0);
+	__cpu_hotplug_enable();
 	cpu_maps_update_done();
 }
 EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
@@ -1091,7 +1099,7 @@ void enable_nonboot_cpus(void)
 
 	/* Allow everyone to use the CPU hotplug again */
 	cpu_maps_update_begin();
-	WARN_ON(--cpu_hotplug_disabled < 0);
+	__cpu_hotplug_enable();
 	if (cpumask_empty(frozen_cpus))
 		goto out;
 
-- 
1.9.1

