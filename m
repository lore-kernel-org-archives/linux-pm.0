From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2 2.6.37.stable] intel_idle: disable
 Atom/Lincroft HW C-state auto-demotion
Date: Tue, 22 Mar 2011 22:26:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103222224530.10489@x980>
References: <alpine.LFD.2.02.1103222222490.10489@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <alpine.LFD.2.02.1103222222490.10489@x980>
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

upstream bfb53ccf1c734b1907df7189eef4c08489827951

Just as we had to disable auto-demotion for NHM/WSM,
we need to do the same for Atom (Lincroft version).

In particular, auto-demotion will prevent Lincroft
from entering the S0i3 idle power saving state.

https://bugzilla.kernel.org/show_bug.cgi?id=25252

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h |    1 +
 drivers/idle/intel_idle.c        |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

Index: linux-2.6.37.y/arch/x86/include/asm/msr-index.h
===================================================================
--- linux-2.6.37.y.orig/arch/x86/include/asm/msr-index.h
+++ linux-2.6.37.y/arch/x86/include/asm/msr-index.h
@@ -39,6 +39,7 @@
 #define MSR_NHM_SNB_PKG_CST_CFG_CTL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
+#define ATM_LNC_C6_AUTO_DEMOTE		(1UL << 25)
 
 #define MSR_MTRRcap			0x000000fe
 #define MSR_IA32_BBL_CR_CTL		0x00000119
Index: linux-2.6.37.y/drivers/idle/intel_idle.c
===================================================================
--- linux-2.6.37.y.orig/drivers/idle/intel_idle.c
+++ linux-2.6.37.y/drivers/idle/intel_idle.c
@@ -340,8 +340,12 @@ static int intel_idle_probe(void)
 		break;
 
 	case 0x1C:	/* 28 - Atom Processor */
+		cpuidle_state_table = atom_cstates;
+		break;
+
 	case 0x26:	/* 38 - Lincroft Atom Processor */
 		cpuidle_state_table = atom_cstates;
+		auto_demotion_disable_flags = ATM_LNC_C6_AUTO_DEMOTE;
 		break;
 
 	case 0x2A:	/* SNB */
