From: Len Brown <lenb@kernel.org>
Subject: [PATCH] cpuidle: delete NOP CPUIDLE_FLAG_POLL
Date: Wed, 12 Jan 2011 02:37:54 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120235390.19140__22807.0652032786$1294817927$gmane$org@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
	<1294396190-23031-6-git-send-email-trenn@suse.de>
	<alpine.LFD.2.02.1101120159400.19140@x980>
	<alpine.LFD.2.02.1101120229060.19140@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <alpine.LFD.2.02.1101120229060.19140@x980>
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

it serves no purpose

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/cpuidle.c |    2 +-
 include/linux/cpuidle.h   |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 37e4460..dd5f1ea 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -186,7 +186,7 @@ static void poll_idle_init(struct cpuidle_device *dev)
 	state->exit_latency = 0;
 	state->target_residency = 0;
 	state->power_usage = -1;
-	state->flags = CPUIDLE_FLAG_POLL;
+	state->flags = 0;
 	state->enter = poll_idle;
 }
 #else
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 1be416b..dee3285 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -48,7 +48,6 @@ struct cpuidle_state {
 /* Idle State Flags */
 #define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
 #define CPUIDLE_FLAG_CHECK_BM	(0x02) /* BM activity will exit state */
-#define CPUIDLE_FLAG_POLL	(0x10) /* no latency, no savings */
 #define CPUIDLE_FLAG_SHALLOW	(0x20) /* low latency, minimal savings */
 #define CPUIDLE_FLAG_BALANCED	(0x40) /* medium latency, moderate savings */
 #define CPUIDLE_FLAG_DEEP	(0x80) /* high latency, large savings */
-- 
1.7.4.rc1.7.g2cf08
