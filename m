From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/12] cpuidle: delete NOP CPUIDLE_FLAG_POLL
Date: Wed, 12 Jan 2011 22:39:56 -0500
Message-ID: <d247632c08c674864d438733280422ddb7130ff8.1294889887.git.len.brown@intel.com>
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
1.7.4.rc1.14.g7fad99
