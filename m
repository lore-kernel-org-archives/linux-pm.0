From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/1] intel_idle: recognize ARAT on WSM-EX
Date: Sat, 11 Dec 2010 02:15:07 -0500
Message-ID: <56b9aea3b740be7665be100872a913da9bdc653b.1292051640.git.len.brown@intel.com>
References: <1292051707-10409-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1292051707-10409-1-git-send-email-lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

We erroneously ignored the Always Running APIC Timer on WSM-EX.
Move the check for ARAT down so that it can apply to any/all models.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 41665d2..c131d58 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -273,8 +273,6 @@ static int intel_idle_probe(void)
 
 	pr_debug(PREFIX "MWAIT substates: 0x%x\n", mwait_substates);
 
-	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
-		lapic_timer_reliable_states = 0xFFFFFFFF;
 
 	if (boot_cpu_data.x86 != 6)	/* family 6 */
 		return -ENODEV;
@@ -286,8 +284,6 @@ static int intel_idle_probe(void)
 	case 0x1F:	/* Core i7 and i5 Processor - Nehalem */
 	case 0x2E:	/* Nehalem-EX Xeon */
 	case 0x2F:	/* Westmere-EX Xeon */
-		lapic_timer_reliable_states = (1 << 1);	 /* C1 */
-
 	case 0x25:	/* Westmere */
 	case 0x2C:	/* Westmere */
 		cpuidle_state_table = nehalem_cstates;
@@ -295,7 +291,6 @@ static int intel_idle_probe(void)
 
 	case 0x1C:	/* 28 - Atom Processor */
 	case 0x26:	/* 38 - Lincroft Atom Processor */
-		lapic_timer_reliable_states = (1 << 1); /* C1 */
 		cpuidle_state_table = atom_cstates;
 		break;
 
@@ -303,10 +298,6 @@ static int intel_idle_probe(void)
 	case 0x2D:	/* SNB Xeon */
 		cpuidle_state_table = snb_cstates;
 		break;
-#ifdef FUTURE_USE
-	case 0x17:	/* 23 - Core 2 Duo */
-		lapic_timer_reliable_states = (1 << 2) | (1 << 1); /* C2, C1 */
-#endif
 
 	default:
 		pr_debug(PREFIX "does not run on family %d model %d\n",
@@ -314,6 +305,9 @@ static int intel_idle_probe(void)
 		return -ENODEV;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
+		lapic_timer_reliable_states = 0xFFFFFFFF;
+
 	pr_debug(PREFIX "v" INTEL_IDLE_VERSION
 		" model 0x%X\n", boot_cpu_data.x86_model);
 
-- 
1.7.3.3.480.g2f76a
