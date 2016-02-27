From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/16] tools/power turbostat: detect and work around syscall jitter
Date: Sat, 27 Feb 2016 04:01:10 -0500
Message-ID: <f899e44ea4b92e2bc24b6bf9f9c8458e6477400c.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35538 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbcB0JCL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:02:11 -0500
Received: by mail-yw0-f194.google.com with SMTP id u200so5302638ywf.2
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:02:11 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

The accuracy of Bzy_Mhz and Busy% depend on reading
the TSC, APERF, and MPERF close together in time.

When there is a very short measurement interval,
or a large system is profoundly idle, the changes
in APERF and MPERF may be very small.
They can be small enough that an expensive interrupt
between reading APERF and MPERF can cause the APERF/MPERF
ratio to become inaccurate, resulting in invalid
calculation and display of Bzy_MHz.

A dummy APERF read of APERF makes this problem
much more rare.  Apparently this 1st systemn call
after exiting a long stretch of idle is when we
typically see expensive timer interrupts that cause
large jitter.

For the cases that dummy APERF read fails to prevent,
we compare the latency of the APERF and MPERF reads.
If they differ by more than 2x, we re-issue them.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 51 ++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9896619..2c43527 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1059,19 +1059,68 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
 	int cpu = t->cpu_id;
 	unsigned long long msr;
+	int aperf_mperf_retry_count = 0;
 
 	if (cpu_migrate(cpu)) {
 		fprintf(outf, "Could not migrate to CPU %d\n", cpu);
 		return -1;
 	}
 
+retry:
 	t->tsc = rdtsc();	/* we are running on local CPU of interest */
 
 	if (has_aperf) {
+		unsigned long long tsc_before, tsc_between, tsc_after, aperf_time, mperf_time;
+
+		/*
+		 * The TSC, APERF and MPERF must be read together for
+		 * APERF/MPERF and MPERF/TSC to give accurate results.
+		 *
+		 * Unfortunately, APERF and MPERF are read by
+		 * individual system call, so delays may occur
+		 * between them.  If the time to read them
+		 * varies by a large amount, we re-read them.
+		 */
+
+		/*
+		 * This initial dummy APERF read has been seen to
+		 * reduce jitter in the subsequent reads.
+		 */
+
+		if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
+			return -3;
+
+		t->tsc = rdtsc();	/* re-read close to APERF */
+
+		tsc_before = t->tsc;
+
 		if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
 			return -3;
+
+		tsc_between = rdtsc();
+
 		if (get_msr(cpu, MSR_IA32_MPERF, &t->mperf))
 			return -4;
+
+		tsc_after = rdtsc();
+
+		aperf_time = tsc_between - tsc_before;
+		mperf_time = tsc_after - tsc_between;
+
+		/*
+		 * If the system call latency to read APERF and MPERF
+		 * differ by more than 2x, then try again.
+		 */
+		if ((aperf_time > (2 * mperf_time)) || (mperf_time > (2 * aperf_time))) {
+			aperf_mperf_retry_count++;
+			if (aperf_mperf_retry_count < 5)
+				goto retry;
+			else
+				warnx("cpu%d jitter %lld %lld\n",
+					cpu, aperf_time, mperf_time);
+		}
+		aperf_mperf_retry_count = 0;
+
 		t->aperf = t->aperf * aperf_mperf_multiplier;
 		t->mperf = t->mperf * aperf_mperf_multiplier;
 	}
@@ -3554,7 +3603,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(outf, "turbostat version 4.10 10 Dec, 2015"
+	fprintf(outf, "turbostat version 4.11 27 Feb 2016"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.7.1.339.g0233b80

