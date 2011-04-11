From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: [RFC PATCH V2 2/4] Remove CPUIDLE_FLAG_IGNORE and
	dev->prepare()
Date: Mon, 11 Apr 2011 12:47:15 +0530
Message-ID: <20110411071702.6348.68758.stgit__7.02158217809057$1302506292$gmane$org@tringupt.in.ibm.com>
References: <20110411071508.6348.67918.stgit@tringupt.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110411071508.6348.67918.stgit@tringupt.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, peterz@infradead.org
Cc: karthik-dp@ti.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpuidle_device->prepare() mechanism causes updates to the
cpuidle_state[].flags, setting and clearing CPUIDLE_FLAG_IGNORE
to tell the governor not to chose a state on a per-cpu basis at
run-time. State demotion is now handled by the driver and it returns
the actual state entered. Hence, this mechanism is not required.
Also this removes per-cpu flags from cpuidle_state enabling
it to be made global.

Signed-off-by: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
---

 drivers/cpuidle/cpuidle.c        |   10 ----------
 drivers/cpuidle/governors/menu.c |    2 --
 include/linux/cpuidle.h          |    3 ---
 3 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 355b078..92a6216 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -75,16 +75,6 @@ static void cpuidle_idle_call(void)
 	hrtimer_peek_ahead_timers();
 #endif
 
-	/*
-	 * Call the device's prepare function before calling the
-	 * governor's select function.  ->prepare gives the device's
-	 * cpuidle driver a chance to update any dynamic information
-	 * of its cpuidle states for the current idle period, e.g.
-	 * state availability, latencies, residencies, etc.
-	 */
-	if (dev->prepare)
-		dev->prepare(dev);
-
 	/* ask the governor for the next state */
 	next_state = cpuidle_curr_governor->select(dev);
 	if (need_resched()) {
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 70d9982..40b5630 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -286,8 +286,6 @@ static int menu_select(struct cpuidle_device *dev)
 	for (i = CPUIDLE_DRIVER_STATE_START; i < dev->state_count; i++) {
 		struct cpuidle_state *s = &dev->states[i];
 
-		if (s->flags & CPUIDLE_FLAG_IGNORE)
-			continue;
 		if (s->target_residency > data->predicted_us)
 			continue;
 		if (s->exit_latency > latency_req)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 45eef60..a3306be 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -47,7 +47,6 @@ struct cpuidle_state {
 
 /* Idle State Flags */
 #define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
-#define CPUIDLE_FLAG_IGNORE	(0x100) /* ignore during this idle period */
 
 #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
 
@@ -93,8 +92,6 @@ struct cpuidle_device {
 	struct completion	kobj_unregister;
 	void			*governor_data;
 	int			safe_state_index;
-
-	int (*prepare)		(struct cpuidle_device *dev);
 };
 
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
