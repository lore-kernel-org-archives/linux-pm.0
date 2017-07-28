From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpufreq: x86: Make scaling_cur_freq behave more as expected
Date: Fri, 28 Jul 2017 14:45:03 +0200
Message-ID: <13928525.cyvMOGl8Fm@aspire.rjw.lan>
References: <1498281114-3868-1-git-send-email-lenb@kernel.org> <006201d30595$e0a23870$a1e6a950$@net> <8753755.adRLzWASdR@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56487 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751673AbdG1MxG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2017 08:53:06 -0400
In-Reply-To: <8753755.adRLzWASdR@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org
Cc: Doug Smythies <dsmythies@telus.net>, 'Len Brown' <lenb@kernel.org>, rafael@kernel.org, tglx@linutronix.de, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-kernel@vger.kernel.org, 'Len Brown' <len.brown@intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit f8475cef9008 "x86: use common aperfmperf_khz_on_cpu() to
calculate KHz using APERF/MPERF" the scaling_cur_freq policy attribute
in sysfs only behaves as expected on x86 with APERF/MPERF registers
available when it is read from at least twice in a row.  The value
returned by the first read may not be meaningful, because the
computations in there use cached values from the previous iteration
of aperfmperf_snapshot_khz() which may be stale.

To prevent that from happening, modify arch_freq_get_on_cpu() to
call aperfmperf_snapshot_khz() twice, with a short delay between
these calls, if the previous invocation of aperfmperf_snapshot_khz()
was too far back in the past (specifically, more that 1s ago).

Also, as pointed out by Doug Smythies, aperf_delta is limited now
and the multiplication of it by cpu_khz won't overflow, so simplify
the s->khz computations too.

Fixes: f8475cef9008 "x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF"
Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Simplify the khz computations as per the Doug's suggestion.

---
 arch/x86/kernel/cpu/aperfmperf.c |   40 +++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

Index: linux-pm/arch/x86/kernel/cpu/aperfmperf.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/cpu/aperfmperf.c
+++ linux-pm/arch/x86/kernel/cpu/aperfmperf.c
@@ -8,20 +8,25 @@
  * This file is licensed under GPLv2.
  */
 
-#include <linux/jiffies.h>
+#include <linux/delay.h>
+#include <linux/ktime.h>
 #include <linux/math64.h>
 #include <linux/percpu.h>
 #include <linux/smp.h>
 
 struct aperfmperf_sample {
 	unsigned int	khz;
-	unsigned long	jiffies;
+	ktime_t	time;
 	u64	aperf;
 	u64	mperf;
 };
 
 static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
 
+#define APERFMPERF_CACHE_THRESHOLD_MS	10
+#define APERFMPERF_REFRESH_DELAY_MS	20
+#define APERFMPERF_STALE_THRESHOLD_MS	1000
+
 /*
  * aperfmperf_snapshot_khz()
  * On the current CPU, snapshot APERF, MPERF, and jiffies
@@ -33,9 +38,11 @@ static void aperfmperf_snapshot_khz(void
 	u64 aperf, aperf_delta;
 	u64 mperf, mperf_delta;
 	struct aperfmperf_sample *s = this_cpu_ptr(&samples);
+	ktime_t now = ktime_get();
+	s64 time_delta = ktime_ms_delta(now, s->time);
 
-	/* Don't bother re-computing within 10 ms */
-	if (time_before(jiffies, s->jiffies + HZ/100))
+	/* Don't bother re-computing within the cache threshold time. */
+	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
 		return;
 
 	rdmsrl(MSR_IA32_APERF, aperf);
@@ -51,22 +58,21 @@ static void aperfmperf_snapshot_khz(void
 	if (mperf_delta == 0)
 		return;
 
-	/*
-	 * if (cpu_khz * aperf_delta) fits into ULLONG_MAX, then
-	 *	khz = (cpu_khz * aperf_delta) / mperf_delta
-	 */
-	if (div64_u64(ULLONG_MAX, cpu_khz) > aperf_delta)
-		s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
-	else	/* khz = aperf_delta / (mperf_delta / cpu_khz) */
-		s->khz = div64_u64(aperf_delta,
-			div64_u64(mperf_delta, cpu_khz));
-	s->jiffies = jiffies;
+	s->time = now;
 	s->aperf = aperf;
 	s->mperf = mperf;
+
+	/* If the previous iteration was too long ago, discard it. */
+	if (time_delta > APERFMPERF_STALE_THRESHOLD_MS)
+		s->khz = 0;
+	else
+		s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
 }
 
 unsigned int arch_freq_get_on_cpu(int cpu)
 {
+	unsigned int khz;
+
 	if (!cpu_khz)
 		return 0;
 
@@ -74,6 +80,12 @@ unsigned int arch_freq_get_on_cpu(int cp
 		return 0;
 
 	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
+	khz = per_cpu(samples.khz, cpu);
+	if (khz)
+		return khz;
+
+	msleep(APERFMPERF_REFRESH_DELAY_MS);
+	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
 
 	return per_cpu(samples.khz, cpu);
 }
