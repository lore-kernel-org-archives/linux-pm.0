From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: smp/swsusp using cpu hotplug
Date: Fri, 25 Mar 2005 00:06:54 +0100
Message-ID: <20050324230654.GA1675@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70553565987203415=="
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============70553565987203415==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

against 2.6.12-rc1-mm1. pci.c hunk is probably not needed in -mm2.

								Pavel

--- clean-mm/drivers/pci/pci.c	2005-03-21 11:39:32.000000000 +0100
+++ linux-mm/drivers/pci/pci.c	2005-03-22 01:41:48.000000000 +0100
@@ -376,11 +376,13 @@
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
+#if 0
 	if (platform_pci_choose_state) {
 		ret = platform_pci_choose_state(dev, state);
 		if (ret >= 0)
 			state = ret;
 	}
+#endif
 	switch (state) {
 	case 0: return PCI_D0;
 	case 3: return PCI_D3hot;
--- clean-mm/kernel/power/Kconfig	2005-01-22 21:24:53.000000000 +0100
+++ linux-mm/kernel/power/Kconfig	2005-03-23 11:40:14.000000000 +0100
@@ -28,7 +28,7 @@
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM && SWAP
+	depends on EXPERIMENTAL && PM && SWAP && (HOTPLUG_CPU || !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
--- clean-mm/kernel/power/smp.c	2005-03-19 00:32:32.000000000 +0100
+++ linux-mm/kernel/power/smp.c	2005-03-23 15:38:30.000000000 +0100
@@ -7,79 +7,53 @@
  * This file is released under the GPLv2.
  */
 
-#undef DEBUG
-
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
 #include <asm/atomic.h>
 #include <asm/tlbflush.h>
+#include <asm/cpu.h>
 
-static atomic_t cpu_counter, freeze;
-
-
-static void smp_pause(void * data)
-{
-	struct saved_context ctxt;
-	__save_processor_state(&ctxt);
-	printk("Sleeping in:\n");
-	dump_stack();
-	atomic_inc(&cpu_counter);
-	while (atomic_read(&freeze)) {
-		/* FIXME: restore takes place at random piece inside this.
-		   This should probably be written in assembly, and
-		   preserve general-purpose registers, too
-
-		   What about stack? We may need to move to new stack here.
-
-		   This should better be ran with interrupts disabled.
-		 */
-		cpu_relax();
-		barrier();
-	}
-	atomic_dec(&cpu_counter);
-	__restore_processor_state(&ctxt);
-}
-
-static cpumask_t oldmask;
+cpumask_t frozen_cpus;
 
 void disable_nonboot_cpus(void)
 {
-	printk("Freezing CPUs (at %d)", smp_processor_id());
-	oldmask = current->cpus_allowed;
-	set_cpus_allowed(current, cpumask_of_cpu(0));
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(HZ);
-	printk("...");
-	BUG_ON(smp_processor_id() != 0);
-
-	/* FIXME: for this to work, all the CPUs must be running
-	 * "idle" thread (or we deadlock). Is that guaranteed? */
+	int cpu, error;
 
-	atomic_set(&cpu_counter, 0);
-	atomic_set(&freeze, 1);
-	smp_call_function(smp_pause, NULL, 0, 0);
-	while (atomic_read(&cpu_counter) < (num_online_cpus() - 1)) {
-		cpu_relax();
-		barrier();
+	error = 0;
+	cpus_clear(frozen_cpus);
+	printk("Freezing cpus ...\n");
+	for_each_online_cpu(cpu) {
+		if (cpu == 0)
+			continue;
+		error = cpu_down(cpu);
+		if (!error) {
+			cpu_set(cpu, frozen_cpus);
+			printk("CPU%d is down\n", cpu);
+			continue;
+		}
+		printk("Error taking cpu %d down: %d\n", cpu, error);
 	}
-	printk("ok\n");
+	BUG_ON(smp_processor_id() != 0);
+	if (error)
+		panic("cpus not sleeping");
 }
 
 void enable_nonboot_cpus(void)
 {
-	printk("Restarting CPUs");
-	atomic_set(&freeze, 0);
-	while (atomic_read(&cpu_counter)) {
-		cpu_relax();
-		barrier();
-	}
-	printk("...");
-	set_cpus_allowed(current, oldmask);
-	schedule();
-	printk("ok\n");
+	int cpu, error;
 
+	printk("Thawing cpus ...\n");
+	for_each_cpu_mask(cpu, frozen_cpus) {
+		if (cpu == 0)
+			continue;
+		error = cpu_up(cpu);
+		if (!error) {
+			printk("CPU%d is up\n", cpu);
+			continue;
+		}
+		printk("Error taking cpu %d up: %d\n", cpu, error);
+		panic("Not enough cpus");
+	}
 }
-
-
--- clean-mm/kernel/power/swsusp.c	2005-03-21 11:39:33.000000000 +0100
+++ linux-mm/kernel/power/swsusp.c	2005-03-23 15:34:53.000000000 +0100
@@ -1194,8 +1194,11 @@
 		return "version";
 	if (strcmp(swsusp_info.uts.machine,system_utsname.machine))
 		return "machine";
+#if 0
+	/* We can't use number of CPUs when we use hotplug to remove them ;-))) */
 	if(swsusp_info.cpus != num_online_cpus())
 		return "number of cpus";
+#endif
 	return NULL;
 }
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============70553565987203415==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70553565987203415==--
