From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2 2.6.37.stable] intel_idle: disable NHM/WSM HW
 C-state auto-demotion
Date: Tue, 22 Mar 2011 22:24:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103222222490.10489@x980>
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
To: stable@kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

upstream 14796fca2bd22acc73dd0887248d003b0f441d08

Hardware C-state auto-demotion is a mechanism where the HW overrides
the OS C-state request, instead demoting to a shallower state,
which is less expensive, but saves less power.

Modern Linux should generally get exactly the states it requests.
In particular, when a CPU is taken off-line, it must not be demoted, else
it can prevent the entire package from reaching deep C-states.

https://bugzilla.kernel.org/show_bug.cgi?id=25252

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h |    4 ++++
 drivers/idle/intel_idle.c        |   20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

Index: linux-2.6.37.y/arch/x86/include/asm/msr-index.h
===================================================================
--- linux-2.6.37.y.orig/arch/x86/include/asm/msr-index.h
+++ linux-2.6.37.y/arch/x86/include/asm/msr-index.h
@@ -36,6 +36,10 @@
 #define MSR_IA32_PERFCTR1		0x000000c2
 #define MSR_FSB_FREQ			0x000000cd
 
+#define MSR_NHM_SNB_PKG_CST_CFG_CTL	0x000000e2
+#define NHM_C3_AUTO_DEMOTE		(1UL << 25)
+#define NHM_C1_AUTO_DEMOTE		(1UL << 26)
+
 #define MSR_MTRRcap			0x000000fe
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 
Index: linux-2.6.37.y/drivers/idle/intel_idle.c
===================================================================
--- linux-2.6.37.y.orig/drivers/idle/intel_idle.c
+++ linux-2.6.37.y/drivers/idle/intel_idle.c
@@ -62,6 +62,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <asm/mwait.h>
+#include <asm/msr.h>
 
 #define INTEL_IDLE_VERSION "0.4"
 #define PREFIX "intel_idle: "
@@ -85,6 +86,12 @@ static int intel_idle(struct cpuidle_dev
 static struct cpuidle_state *cpuidle_state_table;
 
 /*
+ * Hardware C-state auto-demotion may not always be optimal.
+ * Indicate which enable bits to clear here.
+ */
+static unsigned long long auto_demotion_disable_flags;
+
+/*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
  * Thus C0 is a dummy.
@@ -276,6 +283,15 @@ static struct notifier_block setup_broad
 	.notifier_call = setup_broadcast_cpuhp_notify,
 };
 
+static void auto_demotion_disable(void *dummy)
+{
+	unsigned long long msr_bits;
+
+	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+	msr_bits &= ~auto_demotion_disable_flags;
+	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+}
+
 /*
  * intel_idle_probe()
  */
@@ -319,6 +335,8 @@ static int intel_idle_probe(void)
 	case 0x25:	/* Westmere */
 	case 0x2C:	/* Westmere */
 		cpuidle_state_table = nehalem_cstates;
+		auto_demotion_disable_flags =
+			(NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE);
 		break;
 
 	case 0x1C:	/* 28 - Atom Processor */
@@ -431,6 +449,8 @@ static int intel_idle_cpuidle_devices_in
 			return -EIO;
 		}
 	}
+	if (auto_demotion_disable_flags)
+		smp_call_function(auto_demotion_disable, NULL, 1);
 
 	return 0;
 }
