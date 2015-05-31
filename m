From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/1] x86 TSC: set X86_FEATURE_TSC_RELIABLE, per CPUID
Date: Sun, 31 May 2015 01:44:42 -0400
Message-ID: <f1643565587e70dd2fe2714e9afa566689211a9a.1433050960.git.len.brown@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33853 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbEaFo7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 May 2015 01:44:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Speed cpu_up() by believing CPUID's "invariant TSC" flag,
and skipping the TSC warp test on single socket systems.

On my desktop, cpu_up() duration drops from 4.4ms to 2.4ms.
That savings is per-CPU, and occurs during boot, online
and resume from S3.

Originally, this was done for all sized systems, in Feb-2009
by 83ce40092868 (x86: set X86_FEATURE_TSC_RELIABLE).

But in Dec-2009, it was disabled for all sized systems by
6c56ccecf05f (x86: Reenable TSC sync check at boot, even with NONSTOP_TSC)
due to discovery of a TSC time warp on a multi-node system.

Here we re-enable this optimization for single-socket systems.

Multi-node systems will still run the sanity test.

"tsc=reliable" is still available to tell them to not bother.

Perhaps in the future we can up the node count to 2, or perhaps 4,
using dmi_check_multi[] to workaround bugs, per the original design.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 21 +++++++++++++++------
 arch/x86/kernel/tsc.c       |  2 +-
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 50163fa..aa00390 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -79,17 +79,26 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		c->x86_phys_bits = 36;
 
 	/*
-	 * c->x86_power is 8000_0007 edx. Bit 8 is TSC runs at constant rate
-	 * with P/T states and does not stop in deep C-states.
-	 *
-	 * It is also reliable across cores and sockets. (but not across
-	 * cabinets - we turn it off in that case explicitly.)
+	 * c->x86_power is CPUID(0x80000007).EDX
+	 * Bit 8 describes the "invariant TSC" feature, where the TSC
+	 * continues running at a constant rate across P/T/C states.
+	 * Linux X86_FEATURE_CONSTANT_TSC describes the constant rate.
+	 * Linux X86_FEATURE_NONSTOP_TSC describes not stopping in C-states.
+	 * Linux X86_FEATURE_TSC_RELIABLE means that Linux should skip
+	 * TSC sanity checks because we know the TSC is sufficient for
+	 * clocksource.  This was invented for VMM use, but can also
+	 * be used to skip sanity check cost on bare metal.
+	 * We set it here, but the TSC code currently tests anyway
+	 * on multi-node systems, out of paranoia.
+	 * dmi_check_multi[] can also be used to clear this flag.
 	 */
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
-		if (!check_tsc_unstable())
+		if (!check_tsc_unstable()) {
 			set_sched_clock_stable();
+			set_cpu_cap(c, X86_FEATURE_TSC_RELIABLE);
+		}
 	}
 
 	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5054497..f1a25e5 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1014,7 +1014,7 @@ static void __init check_system_tsc_reliable(void)
 	if (res_low & RTSC_SUSP)
 		tsc_clocksource_reliable = 1;
 #endif
-	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
+	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE) && (nr_node_ids == 1))
 		tsc_clocksource_reliable = 1;
 }
 
-- 
2.4.1.314.g9532ead

