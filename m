From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] CPUidle: increment state counter for state
	actually entered
Date: Wed,  1 Oct 2008 13:47:04 +0300
Message-ID: <1222858024-20369-1-git-send-email-khilman__44912.2096215889$1222858217$gmane$org@deeprootsystems.com>
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
Cc: linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently, the count for state that the governor chooses is always
incremented after the 'state_enter' hook is called.  However, the
target's enter hook may choose a different state based on BM activity
or other factors.

This patch does the accounting use 'dev->last_state' state instead of
the governor-chosen state.  If the target's enter_idle hook enters a
different state than it was asked, it should update dev->last_state.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/cpuidle/cpuidle.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 5ce07b5..c1294f5 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -67,10 +67,10 @@ static void cpuidle_idle_call(void)
 	target_state = &dev->states[next_state];
 
 	/* enter the state and update stats */
-	dev->last_residency = target_state->enter(dev, target_state);
 	dev->last_state = target_state;
-	target_state->time += (unsigned long long)dev->last_residency;
-	target_state->usage++;
+	dev->last_residency = target_state->enter(dev, target_state);
+	dev->last_state->time += (unsigned long long)dev->last_residency;
+	dev->last_state->usage++;
 
 	/* give the governor an opportunity to reflect on the outcome */
 	if (cpuidle_curr_governor->reflect)
-- 
1.6.0
