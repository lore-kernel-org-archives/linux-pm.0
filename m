From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz" again
Date: Fri, 10 Nov 2017 01:06:34 +0100
Message-ID: <3847477.0JmeHoyQ5e@aspire.rjw.lan>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <6583ed1f-3ea3-c7fd-7e69-1430c8387e54@intel.com> <CAJZ5v0hdJhuoX2j=X4C5Rq+GT9_qKtMwgc-P6OJMfQ_36uLaKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57727 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751827AbdKJAGl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2017 19:06:41 -0500
In-Reply-To: <CAJZ5v0hdJhuoX2j=X4C5Rq+GT9_qKtMwgc-P6OJMfQ_36uLaKg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: WANG Chao <chao.wang@ucloud.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Thursday, November 9, 2017 11:30:54 PM CET Rafael J. Wysocki wrote:
> On Thu, Nov 9, 2017 at 5:06 PM, Rafael J. Wysocki
> <rafael.j.wysocki@intel.com> wrote:
> > Hi Linus,
> >
> > On 11/9/2017 11:38 AM, WANG Chao wrote:
> >>
> >> Commit 941f5f0f6ef5 (x86: CPU: Fix up "cpu MHz" in /proc/cpuinfo) caused
> >> a serious performance issue when reading from /proc/cpuinfo on system
> >> with aperfmperf.
> >>
> >> For each cpu, arch_freq_get_on_cpu() sleeps 20ms to get its frequency.
> >> On a system with 64 cpus, it takes 1.5s to finish running `cat
> >> /proc/cpuinfo`, while it previously was done in 15ms.
> >
> > Honestly, I'm not sure what to do to address this ATM.
> >
> > The last requested frequency is only available in the non-HWP case, so it
> > cannot be used universally.
> 
> OK, here's an idea.
> 
> c_start() can run aperfmperf_snapshot_khz() on all CPUs upfront (say
> in parallel), then wait for a while (say 5 ms; the current 20 ms wait
> is overkill) and then aperfmperf_snapshot_khz() can be run once on
> each CPU in show_cpuinfo() without taking the "stale cache" threshold
> into account.
> 
> I'm going to try that and see how far I can get with it.

Below is what I have.

I ended up using APERFMPERF_REFRESH_DELAY_MS for the delay in
aperfmperf_snapshot_all(), because 5 ms tended to add too much
variation to the results on my test box.

I think it may be reduced to 10 ms, though.

Chao, can you please try this one and report back?


---
 arch/x86/kernel/cpu/aperfmperf.c |   42 ++++++++++++++++++++++++++++-----------
 arch/x86/kernel/cpu/cpu.h        |    4 +++
 arch/x86/kernel/cpu/proc.c       |    5 +++-
 3 files changed, 39 insertions(+), 12 deletions(-)

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
@@ -38,8 +40,6 @@ static void aperfmperf_snapshot_khz(void
 	u64 aperf, aperf_delta;
 	u64 mperf, mperf_delta;
 	struct aperfmperf_sample *s = this_cpu_ptr(&samples);
-	ktime_t now = ktime_get();
-	s64 time_delta = ktime_ms_delta(now, s->time);
 	unsigned long flags;
 
 	local_irq_save(flags);
@@ -57,15 +57,10 @@ static void aperfmperf_snapshot_khz(void
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
 
 unsigned int arch_freq_get_on_cpu(int cpu)
@@ -82,16 +77,41 @@ unsigned int arch_freq_get_on_cpu(int cp
 	/* Don't bother re-computing within the cache threshold time. */
 	time_delta = ktime_ms_delta(ktime_get(), per_cpu(samples.time, cpu));
 	khz = per_cpu(samples.khz, cpu);
-	if (khz && time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
+	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
 		return khz;
 
 	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
 	khz = per_cpu(samples.khz, cpu);
-	if (khz)
+	if (time_delta <= APERFMPERF_STALE_THRESHOLD_MS)
 		return khz;
 
+	/* If the previous iteration was too long ago, take a new data point. */
 	msleep(APERFMPERF_REFRESH_DELAY_MS);
 	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
 
 	return per_cpu(samples.khz, cpu);
 }
+
+void aperfmperf_snapshot_all(void)
+{
+	if (!cpu_khz)
+		return;
+
+	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+		return;
+
+	smp_call_function_many(cpu_online_mask, aperfmperf_snapshot_khz, NULL, 1);
+	msleep(APERFMPERF_REFRESH_DELAY_MS);
+}
+
+unsigned int aperfmperf_snapshot_cpu(int cpu)
+{
+	if (!cpu_khz)
+		return 0;
+
+	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+		return 0;
+
+	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
+	return per_cpu(samples.khz, cpu);
+}
Index: linux-pm/arch/x86/kernel/cpu/cpu.h
===================================================================
--- linux-pm.orig/arch/x86/kernel/cpu/cpu.h
+++ linux-pm/arch/x86/kernel/cpu/cpu.h
@@ -47,4 +47,8 @@ extern const struct cpu_dev *const __x86
 
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
+
+extern unsigned int aperfmperf_snapshot_cpu(int cpu);
+extern void aperfmperf_snapshot_all(void);
+
 #endif /* ARCH_X86_CPU_H */
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
@@ -78,7 +80,7 @@ static int show_cpuinfo(struct seq_file
 		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
 
 	if (cpu_has(c, X86_FEATURE_TSC)) {
-		unsigned int freq = arch_freq_get_on_cpu(cpu);
+		unsigned int freq = aperfmperf_snapshot_cpu(cpu);
 
 		if (!freq)
 			freq = cpufreq_quick_get(cpu);
@@ -141,6 +143,7 @@ static int show_cpuinfo(struct seq_file
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
+	aperfmperf_snapshot_all();
 	*pos = cpumask_next(*pos - 1, cpu_online_mask);
 	if ((*pos) < nr_cpu_ids)
 		return &cpu_data(*pos);
