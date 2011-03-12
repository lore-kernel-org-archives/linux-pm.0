From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/8] cpufreq: Use syscore_ops for boot CPU
	suspend/resume
Date: Sat, 12 Mar 2011 22:20:29 +0100
Message-ID: <201103122220.30173.rjw__14736.6130062894$1299965649$gmane$org@sisk.pl>
References: <201103100131.58206.rjw@sisk.pl> <201103122212.40828.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103122212.40828.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, mingo@redhat.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The cpufreq subsystem uses sysdev suspend and resume for
executing cpufreq_suspend() and cpufreq_resume(), respectively,
during system suspend, after interrupts have been switched off on the
boot CPU, and during system resume, while interrupts are still off on
the boot CPU.  In both cases the other CPUs are off-line at the
relevant point (either they have been switched off via CPU hotplug
during suspend, or they haven't been switched on yet during resume).
For this reason, although it may seem that cpufreq_suspend() and
cpufreq_resume() are executed for all CPUs in the system, they are
only called for the boot CPU in fact, which is quite confusing.

To remove the confusion and to prepare for elimiating sysdev
suspend and resume operations from the kernel enirely, convernt
cpufreq to using a struct syscore_ops object for the boot CPU
suspend and resume and rename the callbacks so that their names
reflect their purpose.  In addition, put some explanatory remarks
into their kerneldoc comments.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/cpufreq/cpufreq.c |   43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

Index: linux-2.6/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6/drivers/cpufreq/cpufreq.c
@@ -28,6 +28,7 @@
 #include <linux/cpu.h>
 #include <linux/completion.h>
 #include <linux/mutex.h>
+#include <linux/syscore_ops.h>
 
 #include <trace/events/power.h>
 
@@ -1340,23 +1341,27 @@ out:
 }
 EXPORT_SYMBOL(cpufreq_get);
 
+static struct sysdev_driver cpufreq_sysdev_driver = {
+	.add		= cpufreq_add_dev,
+	.remove		= cpufreq_remove_dev,
+};
+
 
 /**
- *	cpufreq_suspend - let the low level driver prepare for suspend
+ * cpufreq_bp_suspend - Prepare the boot CPU for system suspend.
+ *
+ * This function is only executed for the boot processor.  The other CPUs
+ * have been put offline by means of CPU hotplug.
  */
-
-static int cpufreq_suspend(struct sys_device *sysdev, pm_message_t pmsg)
+static int cpufreq_bp_suspend(void)
 {
 	int ret = 0;
 
-	int cpu = sysdev->id;
+	int cpu = smp_processor_id();
 	struct cpufreq_policy *cpu_policy;
 
 	dprintk("suspending cpu %u\n", cpu);
 
-	if (!cpu_online(cpu))
-		return 0;
-
 	/* we may be lax here as interrupts are off. Nonetheless
 	 * we need to grab the correct cpu policy, as to check
 	 * whether we really run on this CPU.
@@ -1383,7 +1388,7 @@ out:
 }
 
 /**
- *	cpufreq_resume -  restore proper CPU frequency handling after resume
+ * cpufreq_bp_resume - Restore proper frequency handling of the boot CPU.
  *
  *	1.) resume CPUfreq hardware support (cpufreq_driver->resume())
  *	2.) schedule call cpufreq_update_policy() ASAP as interrupts are
@@ -1391,19 +1396,19 @@ out:
  *	    what we believe it to be. This is a bit later than when it
  *	    should be, but nonethteless it's better than calling
  *	    cpufreq_driver->get() here which might re-enable interrupts...
+ *
+ * This function is only executed for the boot CPU.  The other CPUs have not
+ * been turned on yet.
  */
-static int cpufreq_resume(struct sys_device *sysdev)
+static void cpufreq_bp_resume(void)
 {
 	int ret = 0;
 
-	int cpu = sysdev->id;
+	int cpu = smp_processor_id();
 	struct cpufreq_policy *cpu_policy;
 
 	dprintk("resuming cpu %u\n", cpu);
 
-	if (!cpu_online(cpu))
-		return 0;
-
 	/* we may be lax here as interrupts are off. Nonetheless
 	 * we need to grab the correct cpu policy, as to check
 	 * whether we really run on this CPU.
@@ -1411,7 +1416,7 @@ static int cpufreq_resume(struct sys_dev
 
 	cpu_policy = cpufreq_cpu_get(cpu);
 	if (!cpu_policy)
-		return -EINVAL;
+		return;
 
 	/* only handle each CPU group once */
 	if (unlikely(cpu_policy->cpu != cpu))
@@ -1430,14 +1435,11 @@ static int cpufreq_resume(struct sys_dev
 
 fail:
 	cpufreq_cpu_put(cpu_policy);
-	return ret;
 }
 
-static struct sysdev_driver cpufreq_sysdev_driver = {
-	.add		= cpufreq_add_dev,
-	.remove		= cpufreq_remove_dev,
-	.suspend	= cpufreq_suspend,
-	.resume		= cpufreq_resume,
+static struct syscore_ops cpufreq_syscore_ops = {
+	.suspend	= cpufreq_bp_suspend,
+	.resume		= cpufreq_bp_resume,
 };
 
 
@@ -2002,6 +2004,7 @@ static int __init cpufreq_core_init(void
 	cpufreq_global_kobject = kobject_create_and_add("cpufreq",
 						&cpu_sysdev_class.kset.kobj);
 	BUG_ON(!cpufreq_global_kobject);
+	register_syscore_ops(&cpufreq_syscore_ops);
 
 	return 0;
 }
