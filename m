From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/12] cpuidle: CPUIDLE_FLAG_TLB_FLUSHED is
 specific to intel_idle
Date: Wed, 12 Jan 2011 22:39:59 -0500
Message-ID: <956d033fb2eb3f8818260cdf01644bf4dc1a9e33.1294889887.git.len.brown@intel.com>
References: <1294890002-6274-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1294890002-6274-1-git-send-email-lenb@kernel.org>
In-reply-to: <ddbd550d503c9cdefcd6674a0ef168d57d3f0917.1294889887.git.len.brown@intel.com>
References: <ddbd550d503c9cdefcd6674a0ef168d57d3f0917.1294889887.git.len.brown@intel.com>
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
1.7.4.rc1.14.g7fad99
