From: Len Brown <lenb@kernel.org>
Subject: [PATCH] intel_idle: disable NHM/WSM HW C-state
	auto-demotion (v3)
Date: Wed, 16 Feb 2011 01:22:00 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1102160119430.843__38335.2413926788$1297908383$gmane$org@x980>
References: <alpine.LFD.2.02.1101182150400.14668@x980>
	<alpine.LFD.2.02.1101190035200.14668@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <alpine.LFD.2.02.1101190035200.14668@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

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
index 7acb32e..88998ac 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -62,6 +62,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <asm/mwait.h>
+#include <asm/msr.h>
 
 #define INTEL_IDLE_VERSION "0.4"
 #define PREFIX "intel_idle: "
@@ -85,6 +86,12 @@ static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state);
 static struct cpuidle_state *cpuidle_state_table;
 
 /*
+ * Hardware C-state auto-demotion may not always be optimal.
+ * Indicate which enable bits to clear here.
+ */
+static unsigned int auto_demotion_disable_flags;
+
+/*
  * Set this flag for states where the HW flushes the TLB for us
  * and so we don't need cross-calls to keep it consistent.
  * If this flag is set, SW flushes the TLB, so even if the
@@ -285,6 +292,16 @@ static struct notifier_block __cpuinitdata setup_broadcast_notifier = {
 	.notifier_call = setup_broadcast_cpuhp_notify,
 };
 
+static long auto_demotion_disable(void *enable_bits)
+{
+	unsigned long long msr_bits;
+
+	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+	msr_bits &= ~((unsigned long long)enable_bits);
+	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+	return 0;
+}
+
 /*
  * intel_idle_probe()
  */
@@ -328,6 +345,7 @@ static int intel_idle_probe(void)
 	case 0x25:	/* Westmere */
 	case 0x2C:	/* Westmere */
 		cpuidle_state_table = nehalem_cstates;
+		auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE;
 		break;
 
 	case 0x1C:	/* 28 - Atom Processor */
@@ -440,6 +458,8 @@ static int intel_idle_cpuidle_devices_init(void)
 			return -EIO;
 		}
 	}
+	if (auto_demotion_disable_flags)
+		smp_call_function(auto_demotion_disable, (void *)auto_demotion_disable_flags, 1);
 
 	return 0;
 }
-- 
1.7.4.1.26.g00e6e
