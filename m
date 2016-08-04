From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Fix crash in gpstate_timer_handler
Date: Thu,  4 Aug 2016 20:59:17 +0530
Message-ID: <1470324557-20711-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

'commit 09ca4c9b5958 ("cpufreq: powernv: Replacing pstate_id with
frequency table index")' changes calc_global_pstate() to use
cpufreq_table index instead of pstate_id.

But in gpstate_timer_handler() pstate_id was being passed instead
of cpufreq_table index, which caused the index_to_pstate() to access
out of bound indices, leading to this crash.

Adding sanity check for index and pstate, to ensure only valid pstate
and index values are returned.

Call Trace:
[c00000078d66b130] [c00000000011d224] __free_irq+0x234/0x360
(unreliable)
[c00000078d66b1c0] [c00000000011d44c] free_irq+0x6c/0xa0
[c00000078d66b1f0] [c00000000006c4f8] opal_event_shutdown+0x88/0xd0
[c00000078d66b230] [c000000000067a4c] opal_shutdown+0x1c/0x90
[c00000078d66b260] [c000000000063a00] pnv_shutdown+0x20/0x40
[c00000078d66b280] [c000000000021538] machine_restart+0x38/0x90
[c0000000078d66b310] [c000000000965ea0] panic+0x284/0x300
[c00000078d66b3a0] [c00000000001f508] die+0x388/0x450
[c00000078d66b430] [c000000000045a50] bad_page_fault+0xd0/0x140
[c00000078d66b4a0] [c000000000008964] handle_page_fault+0x2c/0x30
   interrupt: 300 at gpstate_timer_handler+0x150/0x260
    LR = gpstate_timer_handler+0x130/0x260
[c00000078d66b7f0] [c000000000132b58] call_timer_fn+0x58/0x1c0
[c00000078d66b880] [c000000000132e20] expire_timers+0x130/0x1d0
[c00000078d66b8f0] [c000000000133068] run_timer_softirq+0x1a8/0x230
[c00000078d66b980] [c0000000000b535c] __do_softirq+0x18c/0x400
[c00000078d66ba70] [c0000000000b5828] irq_exit+0xc8/0x100
[c00000078d66ba90] [c00000000001e214] timer_interrupt+0xa4/0xe0
[c00000078d66bac0] [c0000000000027d0] decrementer_common+0x150/0x180
   interrupt: 901 at arch_local_irq_restore+0x74/0x90
  0] [c000000000106b34] call_cpuidle+0x44/0x90
[c00000078d66be50] [c00000000010708c] cpu_startup_entry+0x38c/0x460
[c00000078d66bf20] [c00000000003d930] start_secondary+0x330/0x380
[c00000078d66bf90] [c000000000008e6c] start_secondary_prolog+0x10/0x14

Fixes: 08d27eb ("cpufreq: powernv: Replacing pstate_id with
frequency table index")
Reported-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 87796e0..d3ffde8 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -145,11 +145,30 @@ static struct powernv_pstate_info {
 /* Use following macros for conversions between pstate_id and index */
 static inline int idx_to_pstate(unsigned int i)
 {
+	if (unlikely(i >= powernv_pstate_info.nr_pstates)) {
+		pr_warn_once("index %u is out of bound\n", i);
+		return powernv_freqs[powernv_pstate_info.nominal].driver_data;
+	}
+
 	return powernv_freqs[i].driver_data;
 }
 
 static inline unsigned int pstate_to_idx(int pstate)
 {
+	int min = powernv_freqs[powernv_pstate_info.min].driver_data;
+	int max = powernv_freqs[powernv_pstate_info.max].driver_data;
+
+	if (min > 0) {
+		if (unlikely((pstate < max) || (pstate > min))) {
+			pr_warn_once("pstate %d is out of bound\n", pstate);
+			return powernv_pstate_info.nominal;
+		}
+	} else {
+		if (unlikely((pstate > max) || (pstate < min))) {
+			pr_warn_once("pstate %d is out of bound\n", pstate);
+			return powernv_pstate_info.nominal;
+		}
+	}
 	/*
 	 * abs() is deliberately used so that is works with
 	 * both monotonically increasing and decreasing
@@ -593,7 +612,7 @@ void gpstate_timer_handler(unsigned long data)
 	} else {
 		gpstate_idx = calc_global_pstate(gpstates->elapsed_time,
 						 gpstates->highest_lpstate_idx,
-						 freq_data.pstate_id);
+						 gpstates->last_lpstate_idx);
 	}
 
 	/*
-- 
2.1.4
