From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz" again
Date: Tue, 14 Nov 2017 23:47:00 +0100
Message-ID: <2101739.Je3pS2vcJU@aspire.rjw.lan>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <CA+55aFycTaZjKg1SGujkMrOX5WmUyWHvy2ujzaV8jefOfDPy_Q@mail.gmail.com> <CAJZ5v0iPt8VKoM8BuRA7O+U+fk7dg37sqVJ0pi2=S8muqfznPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52663 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757215AbdKNWrO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 17:47:14 -0500
In-Reply-To: <CAJZ5v0iPt8VKoM8BuRA7O+U+fk7dg37sqVJ0pi2=S8muqfznPQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Saturday, November 11, 2017 12:09:18 AM CET Rafael J. Wysocki wrote:
> On Fri, Nov 10, 2017 at 8:11 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Thu, Nov 9, 2017 at 2:30 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>
> >> c_start() can run aperfmperf_snapshot_khz() on all CPUs upfront (say
> >> in parallel), then wait for a while (say 5 ms; the current 20 ms wait
> >> is overkill) and then aperfmperf_snapshot_khz() can be run once on
> >> each CPU in show_cpuinfo() without taking the "stale cache" threshold
> >> into account.
> >
> > Yeah, that won't work.
> 
> Indeed.
> 
> > What could work is to do that "smp_call_function_many()" at open time,
> > and *not* set the "wait" flag, but do it entirely asynchronously.
> 
> Right.
> 
> > But I don't think that's an option for 4.14 ;(
> 
> Agreed.
> 
> > So I guess I'll have to revert.
> 
> Sure thing (and I see that you've reverted it already).
> 
> The reason why I wanted to fix this up before the final 4.14 is that
> the "cpu MHz" behavior is kind of inconsistent now (generally, it is
> either constant or the last requested frequency depending on the
> cpufreq configuration), but that's not a blocker by any measure IMO.
> 
> Anyway, I'll try to come up with something better next week.

So what about the one below?  It works for me as expected.

I'm not super-happy with the __weak thing, but I kind of prefer it to
adding an extra callback to struct seq_operations just for cpuinfo on x86.

---
 arch/x86/kernel/cpu/aperfmperf.c |   74 +++++++++++++++++++++++++++------------
 arch/x86/kernel/cpu/cpu.h        |    3 +
 arch/x86/kernel/cpu/proc.c       |    6 ++-
 fs/proc/cpuinfo.c                |    6 +++
 include/linux/cpufreq.h          |    1 
 5 files changed, 67 insertions(+), 23 deletions(-)

Index: linux-pm/arch/x86/kernel/cpu/proc.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/cpu/proc.c
+++ linux-pm/arch/x86/kernel/cpu/proc.c
@@ -5,6 +5,8 @@
 #include <linux/seq_file.h>
 #include <linux/cpufreq.h>
 
+#include "cpu.h"
+
 /*
  *	Get CPU information for use by the procfs.
  */
@@ -78,9 +80,11 @@ static int show_cpuinfo(struct seq_file
 		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
 
 	if (cpu_has(c, X86_FEATURE_TSC)) {
-		unsigned int freq = cpufreq_quick_get(cpu);
+		unsigned int freq = aperfmperf_get_khz(cpu);
 
 		if (!freq)
+			freq = cpufreq_quick_get(cpu);
+		if (!freq)
 			freq = cpu_khz;
 		seq_printf(m, "cpu MHz\t\t: %u.%03u\n",
 			   freq / 1000, (freq % 1000));
Index: linux-pm/arch/x86/kernel/cpu/aperfmperf.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/cpu/aperfmperf.c
+++ linux-pm/arch/x86/kernel/cpu/aperfmperf.c
@@ -14,6 +14,8 @@
 #include <linux/percpu.h>
 #include <linux/smp.h>
 
+#include "cpu.h"
+
 struct aperfmperf_sample {
 	unsigned int	khz;
 	ktime_t	time;
@@ -24,7 +26,7 @@ struct aperfmperf_sample {
 static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
 
 #define APERFMPERF_CACHE_THRESHOLD_MS	10
-#define APERFMPERF_REFRESH_DELAY_MS	20
+#define APERFMPERF_REFRESH_DELAY_MS	10
 #define APERFMPERF_STALE_THRESHOLD_MS	1000
 
 /*
@@ -38,8 +40,6 @@ static void aperfmperf_snapshot_khz(void
 	u64 aperf, aperf_delta;
 	u64 mperf, mperf_delta;
 	struct aperfmperf_sample *s = this_cpu_ptr(&samples);
-	ktime_t now = ktime_get();
-	s64 time_delta = ktime_ms_delta(now, s->time);
 	unsigned long flags;
 
 	local_irq_save(flags);
@@ -57,38 +57,68 @@ static void aperfmperf_snapshot_khz(void
 	if (mperf_delta == 0)
 		return;
 
-	s->time = now;
+	s->time = ktime_get();
 	s->aperf = aperf;
 	s->mperf = mperf;
-
-	/* If the previous iteration was too long ago, discard it. */
-	if (time_delta > APERFMPERF_STALE_THRESHOLD_MS)
-		s->khz = 0;
-	else
-		s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
+	s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
 }
 
-unsigned int arch_freq_get_on_cpu(int cpu)
+static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
 {
-	s64 time_delta;
-	unsigned int khz;
+	s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
+
+	/* Don't bother re-computing within the cache threshold time. */
+	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
+		return true;
+
+	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
+
+	/* Return false if the previous iteration was too long ago. */
+	return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
+}
 
+unsigned int aperfmperf_get_khz(int cpu)
+{
 	if (!cpu_khz)
 		return 0;
 
 	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
-	/* Don't bother re-computing within the cache threshold time. */
-	time_delta = ktime_ms_delta(ktime_get(), per_cpu(samples.time, cpu));
-	khz = per_cpu(samples.khz, cpu);
-	if (khz && time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
-		return khz;
+	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
+	return per_cpu(samples.khz, cpu);
+}
 
-	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
-	khz = per_cpu(samples.khz, cpu);
-	if (khz)
-		return khz;
+void arch_freq_prepare_all(void)
+{
+	ktime_t now = ktime_get();
+	bool wait = false;
+	int cpu;
+
+	if (!cpu_khz)
+		return;
+
+	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+		return;
+
+	for_each_online_cpu(cpu)
+		if (!aperfmperf_snapshot_cpu(cpu, now, false))
+			wait = true;
+
+	if (wait)
+		msleep(APERFMPERF_REFRESH_DELAY_MS);
+}
+
+unsigned int arch_freq_get_on_cpu(int cpu)
+{
+	if (!cpu_khz)
+		return 0;
+
+	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+		return 0;
+
+	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
+		return per_cpu(samples.khz, cpu);
 
 	msleep(APERFMPERF_REFRESH_DELAY_MS);
 	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
Index: linux-pm/arch/x86/kernel/cpu/cpu.h
===================================================================
--- linux-pm.orig/arch/x86/kernel/cpu/cpu.h
+++ linux-pm/arch/x86/kernel/cpu/cpu.h
@@ -47,4 +47,7 @@ extern const struct cpu_dev *const __x86
 
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
+
+unsigned int aperfmperf_get_khz(int cpu);
+
 #endif /* ARCH_X86_CPU_H */
Index: linux-pm/fs/proc/cpuinfo.c
===================================================================
--- linux-pm.orig/fs/proc/cpuinfo.c
+++ linux-pm/fs/proc/cpuinfo.c
@@ -1,12 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/cpufreq.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
+__weak void arch_freq_prepare_all(void)
+{
+}
+
 extern const struct seq_operations cpuinfo_op;
 static int cpuinfo_open(struct inode *inode, struct file *file)
 {
+	arch_freq_prepare_all();
 	return seq_open(file, &cpuinfo_op);
 }
 
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -917,6 +917,7 @@ static inline bool policy_has_boost_freq
 }
 #endif
 
+extern void arch_freq_prepare_all(void);
 extern unsigned int arch_freq_get_on_cpu(int cpu);
 
 extern void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
