From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH] cpufreq: x86: Disable interrupts during MSRs reading
Date: Tue,  8 Aug 2017 14:12:49 -0700
Message-ID: <1502226769-5670-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, len.brown@intel.com
Cc: dsmythies@telus.net, rafael@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

According to Intel 64 and IA-32 Architectures SDM, Volume 3,
Chapter 14.2, "Software needs to exercise care to avoid delays
between the two RDMSRs (for example interrupts)".

So, disable interrupts during reading MSRs IA32_APERF and IA32_MPERF.

See also:
commit 4ab60c3f32c721e46217e762bcd3e55a8f659c04
cpufreq: intel_pstate: Disable interrupts during MSRs reading

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 arch/x86/kernel/cpu/aperfmperf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 7cf7c70..0ee8332 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -40,13 +40,16 @@ static void aperfmperf_snapshot_khz(void *dummy)
 	struct aperfmperf_sample *s = this_cpu_ptr(&samples);
 	ktime_t now = ktime_get();
 	s64 time_delta = ktime_ms_delta(now, s->time);
+	unsigned long flags;
 
 	/* Don't bother re-computing within the cache threshold time. */
 	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
 		return;
 
+	local_irq_save(flags);
 	rdmsrl(MSR_IA32_APERF, aperf);
 	rdmsrl(MSR_IA32_MPERF, mperf);
+	local_irq_restore(flags);
 
 	aperf_delta = aperf - s->aperf;
 	mperf_delta = mperf - s->mperf;
-- 
2.7.4
