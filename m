From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/4][RFC v2] PM / sleep: Introduce arch-specific hook for disable/enable nonboot cpus
Date: Sun, 26 Jun 2016 00:18:41 +0800
Message-ID: <fb78859e5c1ea061ce4e35e200821ed170e6658d.1466844557.git.yu.c.chen@intel.com>
References: <cover.1466844557.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466844557.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, x86@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

There is requirement that we need to do some arch-specific
operations before putting the nonboot CPUs offline/online.
One of the requirements comes from the hibernation resume
process on x86_64, we need to kick all the offlin-CPUs
online and offline again, in order to put them in a safe
state, thus to avoid possible unwilling wake up during
hibernation resume.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d25266e..ce6e5e4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1017,6 +1017,16 @@ EXPORT_SYMBOL_GPL(cpu_up);
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
+void __weak arch_disable_nonboot_cpus_pre(void)
+{
+
+}
+
+void __weak arch_enable_nonboot_cpus_pre(void)
+{
+
+}
+
 int disable_nonboot_cpus(void)
 {
 	int cpu, first_cpu, error = 0;
@@ -1024,6 +1034,7 @@ int disable_nonboot_cpus(void)
 	if (frozen_cpus == NULL)
 		return -ENOMEM;
 	cpu_maps_update_begin();
+	arch_disable_nonboot_cpus_pre();
 	first_cpu = cpumask_first(cpu_online_mask);
 	/*
 	 * We take down all of the non-boot CPUs in one shot to avoid races
@@ -1078,6 +1089,7 @@ void enable_nonboot_cpus(void)
 		return;
 	/* Allow everyone to use the CPU hotplug again */
 	cpu_maps_update_begin();
+	arch_enable_nonboot_cpus_pre();
 	WARN_ON(--cpu_hotplug_disabled < 0);
 	if (cpumask_empty(frozen_cpus))
 		goto out;
-- 
2.7.4
