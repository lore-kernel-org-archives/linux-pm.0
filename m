From: Todd Poynor <tpoynor@mvista.com>
Subject: PowerOP 3/3: Intel Centrino cpufreq integration
Date: Mon, 8 Aug 2005 19:57:27 -0700
Message-ID: <20050809025727.GD25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org, cpufreq@lists.linux.org.uk
List-Id: linux-pm@vger.kernel.org

A minimal example of modifying cpufreq to use PowerOP for reading and
writing power parameters on Intel Centrino platforms.  It would be
possible to move voltage table lookups to the PowerOP layer.


Index: linux-2.6.12/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
===================================================================
--- linux-2.6.12.orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-08-04 19:49:29.000000000 +0000
+++ linux-2.6.12/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-08-05 01:21:45.000000000 +0000
@@ -24,6 +24,7 @@
 #include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/compiler.h>
+#include <linux/powerop.h>
 
 #ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
 #include <linux/acpi.h>
@@ -322,29 +323,21 @@
 /* Return the current CPU frequency in kHz */
 static unsigned int get_cur_freq(unsigned int cpu)
 {
-	unsigned l, h;
-	unsigned clock_freq;
+	struct powerop_point point;
+	unsigned clock_freq = 0;
 	cpumask_t saved_mask;
	
 	saved_mask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));
 	if (smp_processor_id() != cpu)
 		return 0;
 
-	rdmsr(MSR_IA32_PERF_STATUS, l, h);
-	clock_freq = extract_clock(l, cpu, 0);
+	if (powerop_get_point(&point))
+		goto out;
 
-	if (unlikely(clock_freq == 0)) {
-		/*
-		 * On some CPUs, we can see transient MSR values (which are
-		 * not present in _PSS), while CPU is doing some automatic
-		 * P-state transition (like TM2). Get the last freq set 
-		 * in PERF_CTL.
-		 */
-		rdmsr(MSR_IA32_PERF_CTL, l, h);
-		clock_freq = extract_clock(l, cpu, 1);
-	}
+	clock_freq = point.param[POWEROP_CPU + cpu] * 1000;
 
+out:
 	set_cpus_allowed(current, saved_mask);
 	return clock_freq;
 }
@@ -610,6 +603,7 @@
 	unsigned int	msr, oldmsr, h, cpu = policy->cpu;
 	struct cpufreq_freqs	freqs;
 	cpumask_t		saved_mask;
+	struct powerop_point	point;
 	int			retval;
 
 	if (centrino_model[cpu] == NULL)
@@ -650,14 +644,9 @@
 
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
-	/* all but 16 LSB are "reserved", so treat them with
-	   care */
-	oldmsr &= ~0xffff;
-	msr &= 0xffff;
-	oldmsr |= msr;
-
-	wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
-
+	point.param[POWEROP_CPU + cpu] = ((msr >> 8) & 0xff) * 100;
+	point.param[POWEROP_V + cpu] = ((msr & 0xff) * 16) + 700;
+	powerop_set_point(&point);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	retval = 0;
