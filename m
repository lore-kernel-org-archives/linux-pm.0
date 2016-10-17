From: Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/3] thermal/intel_powerclamp: Remove duplicated code that starts the kthread
Date: Mon, 17 Oct 2016 14:32:50 +0200
Message-ID: <1476707572-32215-2-git-send-email-pmladek@suse.com>
References: <1476707572-32215-1-git-send-email-pmladek@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476707572-32215-1-git-send-email-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
List-Id: linux-pm@vger.kernel.org

This patch removes a code duplication. It does not modify
the functionality.

Signed-off-by: Petr Mladek <pmladek@suse.com>
CC: Zhang Rui <rui.zhang@intel.com>
CC: Eduardo Valentin <edubezval@gmail.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: linux-pm@vger.kernel.org
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 45 +++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 0e4dc0afcfd2..63657d193db5 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -508,10 +508,27 @@ static void poll_pkg_cstate(struct work_struct *dummy)
 		schedule_delayed_work(&poll_pkg_cstate_work, HZ);
 }
 
+static void start_power_clamp_thread(unsigned long cpu)
+{
+	struct task_struct **p = per_cpu_ptr(powerclamp_thread, cpu);
+	struct task_struct *thread;
+
+	thread = kthread_create_on_node(clamp_thread,
+					(void *) cpu,
+					cpu_to_node(cpu),
+					"kidle_inject/%ld", cpu);
+	if (IS_ERR(thread))
+		return;
+
+	/* bind to cpu here */
+	kthread_bind(thread, cpu);
+	wake_up_process(thread);
+	*p = thread;
+}
+
 static int start_power_clamp(void)
 {
 	unsigned long cpu;
-	struct task_struct *thread;
 
 	set_target_ratio = clamp(set_target_ratio, 0U, MAX_TARGET_RATIO - 1);
 	/* prevent cpu hotplug */
@@ -527,20 +544,7 @@ static int start_power_clamp(void)
 
 	/* start one thread per online cpu */
 	for_each_online_cpu(cpu) {
-		struct task_struct **p =
-			per_cpu_ptr(powerclamp_thread, cpu);
-
-		thread = kthread_create_on_node(clamp_thread,
-						(void *) cpu,
-						cpu_to_node(cpu),
-						"kidle_inject/%ld", cpu);
-		/* bind to cpu here */
-		if (likely(!IS_ERR(thread))) {
-			kthread_bind(thread, cpu);
-			wake_up_process(thread);
-			*p = thread;
-		}
-
+		start_power_clamp_thread(cpu);
 	}
 	put_online_cpus();
 
@@ -572,7 +576,6 @@ static int powerclamp_cpu_callback(struct notifier_block *nfb,
 				unsigned long action, void *hcpu)
 {
 	unsigned long cpu = (unsigned long)hcpu;
-	struct task_struct *thread;
 	struct task_struct **percpu_thread =
 		per_cpu_ptr(powerclamp_thread, cpu);
 
@@ -581,15 +584,7 @@ static int powerclamp_cpu_callback(struct notifier_block *nfb,
 
 	switch (action) {
 	case CPU_ONLINE:
-		thread = kthread_create_on_node(clamp_thread,
-						(void *) cpu,
-						cpu_to_node(cpu),
-						"kidle_inject/%lu", cpu);
-		if (likely(!IS_ERR(thread))) {
-			kthread_bind(thread, cpu);
-			wake_up_process(thread);
-			*percpu_thread = thread;
-		}
+		start_power_clamp_thread(cpu);
 		/* prefer BSP as controlling CPU */
 		if (cpu == 0) {
 			control_cpu = 0;
-- 
1.8.5.6
