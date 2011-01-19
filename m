From: Len Brown <lenb@kernel.org>
Subject: [PATCH] intel_idle: disable HW auto-demotion
Date: Tue, 18 Jan 2011 21:52:26 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101182150400.14668__18510.7654579499$1295405705$gmane$org@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

HW auto-demotion is a mechanism where the HW overrides
the OS C-state request, instead choosing a shallower state.

This is a useful feature for legacy Linux, which has clock
ticks in idle and may request states deeper than make sense.

However, modern Linux should get exactly the states it requests.

In particular, when a processor is taken off-line, it is
important that its request for the deepest available C-state
is honored, else it can disrupt the C-states reached by
the remaining on-line threads.

boot with "intel_idle.auto_demote=1" to disable the effect of this patch.

https://bugzilla.kernel.org/show_bug.cgi?id=25252

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h |    4 ++++
 drivers/idle/intel_idle.c        |   30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4d0dfa0..b75eeab 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -36,6 +36,10 @@
 #define MSR_IA32_PERFCTR1		0x000000c2
 #define MSR_FSB_FREQ			0x000000cd
 
+#define MSR_NHM_SNB_PKG_CST_CFG_CTL	0x000000e2
+#define NHM_C3_AUTO_DEMOTE		(1UL << 25)
+#define NHM_C1_AUTO_DEMOTE		(1UL << 26)
+
 #define MSR_MTRRcap			0x000000fe
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 7acb32e..3ee8c38 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -62,6 +62,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <asm/mwait.h>
+#include <asm/msr.h>
 
 #define INTEL_IDLE_VERSION "0.4"
 #define PREFIX "intel_idle: "
@@ -85,6 +86,16 @@ static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state);
 static struct cpuidle_state *cpuidle_state_table;
 
 /*
+ * Disable HW auto demotion on tick-less idle kernels
+ */
+static unsigned int has_nhm_snb_hw_auto_demotion;
+#ifdef CONFIG_NO_HZ
+static unsigned int auto_demotion;
+#else
+static unsigned int auto_demotion = 1;
+#endif
+
+/*
  * Set this flag for states where the HW flushes the TLB for us
  * and so we don't need cross-calls to keep it consistent.
  * If this flag is set, SW flushes the TLB, so even if the
@@ -285,6 +296,20 @@ static struct notifier_block __cpuinitdata setup_broadcast_notifier = {
 	.notifier_call = setup_broadcast_cpuhp_notify,
 };
 
+static long nhm_snb_auto_demotion_off(void *unused)
+{
+	unsigned long long msr_bits;
+
+	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+
+	msr_bits &= ~(NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE);
+
+	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+
+	return 0;
+}
+
+
 /*
  * intel_idle_probe()
  */
@@ -328,6 +353,7 @@ static int intel_idle_probe(void)
 	case 0x25:	/* Westmere */
 	case 0x2C:	/* Westmere */
 		cpuidle_state_table = nehalem_cstates;
+		has_nhm_snb_hw_auto_demotion = 1;
 		break;
 
 	case 0x1C:	/* 28 - Atom Processor */
@@ -338,6 +364,7 @@ static int intel_idle_probe(void)
 	case 0x2A:	/* SNB */
 	case 0x2D:	/* SNB Xeon */
 		cpuidle_state_table = snb_cstates;
+		has_nhm_snb_hw_auto_demotion = 1;
 		break;
 
 	default:
@@ -439,6 +466,8 @@ static int intel_idle_cpuidle_devices_init(void)
 			intel_idle_cpuidle_devices_uninit();
 			return -EIO;
 		}
+		if (has_nhm_snb_hw_auto_demotion && (auto_demotion == 0))
+			work_on_cpu(i, nhm_snb_auto_demotion_off, 0);
 	}
 
 	return 0;
@@ -490,6 +519,7 @@ module_init(intel_idle_init);
 module_exit(intel_idle_exit);
 
 module_param(max_cstate, int, 0444);
+module_param(auto_demotion, int, 0444);
 
 MODULE_AUTHOR("Len Brown <len.brown@intel.com>");
 MODULE_DESCRIPTION("Cpuidle driver for Intel Hardware v" INTEL_IDLE_VERSION);
-- 
1.7.4.rc2
