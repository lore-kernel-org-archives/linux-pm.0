From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/4] x86: do not use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
Date: Fri, 23 Jun 2017 22:11:51 -0700
Message-ID: <e3f0ab4d677eb1337999731f1a98022caa8a796a.1498280509.git.len.brown@intel.com>
References: <1498281114-3868-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498281114-3868-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

cpufreq_quick_get() allows cpufreq drivers to over-ride cpu_khz
that is otherwise reported in x86 /proc/cpuinfo "cpu MHz".

There are four problems with this scheme,
any of them is sufficient justification to delete it.

1. Depending on which cpufreq driver is loaded, the behavior
   of this field is different.

2. Distros complain that they have to explain to users
   why and how this field changes.  Distros have requested a constant.

3. The two major providers of this information, acpi_cpufreq
   and intel_pstate, both "get it wrong" in different ways.

   acpi_cpufreq lies to the user by telling them that
   they are running at whatever frequency was last
   requested by software.

   intel_pstate lies to the user by telling them that
   they are running at the average frequency computed
   over an undefined measurement.  But an average computed
   over an undefined interval, is itself, undefined...

4. On modern processors, user space utilities, such as
   turbostat(1), are more accurate and more precise, while
   supporing concurrent measurement over arbitrary intervals.

Users who have been consulting /proc/cpuinfo to
track changing CPU frequency will be dissapointed that
it no longer wiggles -- perhaps being unaware of the
limitations of the information they have been consuming.

Yes, they can change their scripts to look in sysfs
cpufreq/scaling_cur_frequency.  Here they will find the same
data of dubious quality here removed from /proc/cpuinfo.
The value in sysfs will be addressed in a subsequent patch
to address issues 1-3, above.

Issue 4 will remain -- users that really care about
accurate frequency information should not be using either
proc or sysfs kernel interfaces.
They should be using using turbostat(8), or a similar
purpose-built analysis tool.

Signed-off-by: Len Brown <len.brown@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/proc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 6df621a..218f798 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -2,7 +2,6 @@
 #include <linux/timex.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
-#include <linux/cpufreq.h>
 
 /*
  *	Get CPU information for use by the procfs.
@@ -76,14 +75,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (c->microcode)
 		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
 
-	if (cpu_has(c, X86_FEATURE_TSC)) {
-		unsigned int freq = cpufreq_quick_get(cpu);
-
-		if (!freq)
-			freq = cpu_khz;
+	if (cpu_has(c, X86_FEATURE_TSC))
 		seq_printf(m, "cpu MHz\t\t: %u.%03u\n",
-			   freq / 1000, (freq % 1000));
-	}
+			   cpu_khz / 1000, (cpu_khz % 1000));
 
 	/* Cache size */
 	if (c->x86_cache_size >= 0)
-- 
2.7.4
