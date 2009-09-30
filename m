From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] CPUidle: always return with interrupts enabled
Date: Wed, 30 Sep 2009 10:35:53 -0700
Message-ID: <1254332153-23493-1-git-send-email-khilman__47569.9181938127$1254332291$gmane$org@deeprootsystems.com>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In the case where cpuidle_idle_call() returns before changing state
due to a need_resched(), it was returning with IRQs disabled.

This patch ensures IRQs are (re)enabled before returning.

Reported-by: Hemanth V <hemanthv@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/cpuidle/cpuidle.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ad41f19..12fdd39 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -76,8 +76,11 @@ static void cpuidle_idle_call(void)
 #endif
 	/* ask the governor for the next state */
 	next_state = cpuidle_curr_governor->select(dev);
-	if (need_resched())
+	if (need_resched()) {
+		local_irq_enable();
 		return;
+	}
+
 	target_state = &dev->states[next_state];
 
 	/* enter the state and update stats */
-- 
1.6.4.3
