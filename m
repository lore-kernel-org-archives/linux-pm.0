From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] tools/power turbostat: Replace MSR_NHM_TURBO_RATIO_LIMIT
Date: Wed,  6 Jul 2016 16:07:56 -0700
Message-ID: <1467846477-13659-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1467846477-13659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467846477-13659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Replace MSR_NHM_TURBO_RATIO_LIMIT with MSR_TURBO_RATIO_LIMIT.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 2 +-
 tools/power/x86/turbostat/turbostat.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 89a55d5..492e84f 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -123,7 +123,7 @@ cpu0: MSR_NHM_PLATFORM_INFO: 0x80838f3012300
 35 * 100 = 3500 MHz TSC frequency
 cpu0: MSR_IA32_POWER_CTL: 0x0004005d (C1E auto-promotion: DISabled)
 cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x1e000400 (UNdemote-C3, UNdemote-C1, demote-C3, demote-C1, UNlocked: pkg-cstate-limit=0: pc0)
-cpu0: MSR_NHM_TURBO_RATIO_LIMIT: 0x25262727
+cpu0: MSR_TURBO_RATIO_LIMIT: 0x25262727
 37 * 100 = 3700 MHz max turbo 4 active cores
 38 * 100 = 3800 MHz max turbo 3 active cores
 39 * 100 = 3900 MHz max turbo 2 active cores
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index acbf7ff..3e199b5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1480,7 +1480,7 @@ dump_knl_turbo_ratio_limits(void)
 	unsigned int cores[buckets_no];
 	unsigned int ratio[buckets_no];
 
-	get_msr(base_cpu, MSR_NHM_TURBO_RATIO_LIMIT, &msr);
+	get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
 
 	fprintf(outf, "cpu%d: MSR_TURBO_RATIO_LIMIT: 0x%08llx\n",
 		base_cpu, msr);
-- 
2.5.5
