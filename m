From: Joe Perches <joe@perches.com>
Subject: [PATCH] intel_idle: Use more common logging style
Date: Fri,  9 Jun 2017 12:29:20 -0700
Message-ID: <a3acab19b42e51c59e2e20464ceb91f94f033eea.1497036538.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Remove #define PREFIX and add #define pr_fmt to use more common logging.

Miscellanea:

o Add missing newline to format
o Convert a single printk without KERN_<LEVEL> to pr_info

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/idle/intel_idle.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 216d7ec88c0c..c2ae819a871c 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -51,6 +51,8 @@
 /* un-comment DEBUG to enable pr_debug() statements */
 #define DEBUG
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
 #include <linux/tick.h>
@@ -65,7 +67,6 @@
 #include <asm/msr.h>
 
 #define INTEL_IDLE_VERSION "0.4.1"
-#define PREFIX "intel_idle: "
 
 static struct cpuidle_driver intel_idle_driver = {
 	.name = "intel_idle",
@@ -1111,7 +1112,7 @@ static int __init intel_idle_probe(void)
 	const struct x86_cpu_id *id;
 
 	if (max_cstate == 0) {
-		pr_debug(PREFIX "disabled\n");
+		pr_debug("disabled\n");
 		return -EPERM;
 	}
 
@@ -1119,8 +1120,8 @@ static int __init intel_idle_probe(void)
 	if (!id) {
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
 		    boot_cpu_data.x86 == 6)
-			pr_debug(PREFIX "does not run on family %d model %d\n",
-				boot_cpu_data.x86, boot_cpu_data.x86_model);
+			pr_debug("does not run on family %d model %d\n",
+				 boot_cpu_data.x86, boot_cpu_data.x86_model);
 		return -ENODEV;
 	}
 
@@ -1134,13 +1135,13 @@ static int __init intel_idle_probe(void)
 	    !mwait_substates)
 			return -ENODEV;
 
-	pr_debug(PREFIX "MWAIT substates: 0x%x\n", mwait_substates);
+	pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
 
 	icpu = (const struct idle_cpu *)id->driver_data;
 	cpuidle_state_table = icpu->state_table;
 
-	pr_debug(PREFIX "v" INTEL_IDLE_VERSION
-		" model 0x%X\n", boot_cpu_data.x86_model);
+	pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
+		 boot_cpu_data.x86_model);
 
 	return 0;
 }
@@ -1340,8 +1341,7 @@ static void __init intel_idle_cpuidle_driver_init(void)
 			break;
 
 		if (cstate + 1 > max_cstate) {
-			printk(PREFIX "max_cstate %d reached\n",
-				max_cstate);
+			pr_info("max_cstate %d reached\n", max_cstate);
 			break;
 		}
 
@@ -1358,8 +1358,8 @@ static void __init intel_idle_cpuidle_driver_init(void)
 
 		/* if state marked as disabled, skip it */
 		if (cpuidle_state_table[cstate].disabled != 0) {
-			pr_debug(PREFIX "state %s is disabled",
-				cpuidle_state_table[cstate].name);
+			pr_debug("state %s is disabled\n",
+				 cpuidle_state_table[cstate].name);
 			continue;
 		}
 
@@ -1395,7 +1395,7 @@ static int intel_idle_cpu_init(unsigned int cpu)
 	dev->cpu = cpu;
 
 	if (cpuidle_register_device(dev)) {
-		pr_debug(PREFIX "cpuidle_register_device %d failed!\n", cpu);
+		pr_debug("cpuidle_register_device %d failed!\n", cpu);
 		return -EIO;
 	}
 
@@ -1447,8 +1447,8 @@ static int __init intel_idle_init(void)
 	retval = cpuidle_register_driver(&intel_idle_driver);
 	if (retval) {
 		struct cpuidle_driver *drv = cpuidle_get_driver();
-		printk(KERN_DEBUG PREFIX "intel_idle yielding to %s",
-			drv ? drv->name : "none");
+		printk(KERN_DEBUG pr_fmt("intel_idle yielding to %s\n"),
+		       drv ? drv->name : "none");
 		goto init_driver_fail;
 	}
 
@@ -1460,8 +1460,8 @@ static int __init intel_idle_init(void)
 	if (retval < 0)
 		goto hp_setup_fail;
 
-	pr_debug(PREFIX "lapic_timer_reliable_states 0x%x\n",
-		lapic_timer_reliable_states);
+	pr_debug("lapic_timer_reliable_states 0x%x\n",
+		 lapic_timer_reliable_states);
 
 	return 0;
 
-- 
2.10.0.rc2.1.g053435c
