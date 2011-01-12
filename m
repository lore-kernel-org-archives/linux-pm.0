From: Len Brown <lenb@kernel.org>
Subject: [PATCH] cpuidle: CPUIDLE_FLAG_TLB_FLUSHED is specific to
	intel_idle
Date: Wed, 12 Jan 2011 03:02:32 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120301530.19140__7872.61403534121$1294819679$gmane$org@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
	<1294396190-23031-6-git-send-email-trenn@suse.de>
	<alpine.LFD.2.02.1101120159400.19140@x980>
	<alpine.LFD.2.02.1101120229060.19140@x980>
	<alpine.LFD.2.02.1101120235390.19140@x980>
	<alpine.LFD.2.02.1101120258550.19140@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <alpine.LFD.2.02.1101120258550.19140@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, arjan@linux.intel.com, j-pihet@ti.com
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |    8 ++++++++
 include/linux/cpuidle.h   |    1 -
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 21d3871..8256309 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -82,6 +82,14 @@ static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state);
 static struct cpuidle_state *cpuidle_state_table;
 
 /*
+ * Set this flag for states where the HW flushes the TLB for us
+ * and so we don't need cross-calls to keep it consistent.
+ * If this flag is set, SW flushes the TLB, so even if the
+ * HW doesn't do the flushing, this flag is safe to use.
+ */
+#define CPUIDLE_FLAG_TLB_FLUSHED	0x10000
+
+/*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
  * Thus C0 is a dummy.
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index c252953..6be722c 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -49,7 +49,6 @@ struct cpuidle_state {
 #define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
 #define CPUIDLE_FLAG_CHECK_BM	(0x02) /* BM activity will exit state */
 #define CPUIDLE_FLAG_IGNORE	(0x100) /* ignore during this idle period */
-#define CPUIDLE_FLAG_TLB_FLUSHED (0x200) /* tlb will be flushed */
 
 #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
 
-- 
1.7.4.rc1.7.g2cf08
