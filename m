From: venkatesh.pallipadi@intel.com
Subject: [patch 2/3] cpuidle: Menu governor fix wrong usage of
	measured_us
Date: Wed, 30 Jul 2008 19:21:43 -0700
Message-ID: <20080731022215.894712000@intel.com>
References: <20080731022141.088307000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=cpuidle_menu_fix.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: len.brown@intel.com, andi@firstfloor.org
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

There is a bug in menu governor where we have
		if (data->elapsed_us < data->elapsed_us + measured_us)

with measured_us already having elapsed_us added in tickless case here
	unsigned int measured_us =
		cpuidle_get_last_residency(dev) + data->elapsed_us;


Also, it should be last_residency, not measured_us, that need to be used to
do comparing and distinguish between expected & non-expected events.

Refactor menu_reflect() to fix these two problems.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Wei Gang <gang.wei@intel.com>

---
 drivers/cpuidle/governors/menu.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-2.6.orig/drivers/cpuidle/governors/menu.c	2008-07-28 16:25:58.000000000 -0700
+++ linux-2.6/drivers/cpuidle/governors/menu.c	2008-07-28 16:29:18.000000000 -0700
@@ -74,9 +74,9 @@ static void menu_reflect(struct cpuidle_
 {
 	struct menu_device *data = &__get_cpu_var(menu_devices);
 	int last_idx = data->last_state_idx;
-	unsigned int measured_us =
-		cpuidle_get_last_residency(dev) + data->elapsed_us;
+	unsigned int last_idle_us = cpuidle_get_last_residency(dev);
 	struct cpuidle_state *target = &dev->states[last_idx];
+	unsigned int measured_us;
 
 	/*
 	 * Ugh, this idle state doesn't support residency measurements, so we
@@ -84,20 +84,27 @@ static void menu_reflect(struct cpuidle_
 	 * for one full standard timer tick.  However, be aware that this
 	 * could potentially result in a suboptimal state transition.
 	 */
-	if (!(target->flags & CPUIDLE_FLAG_TIME_VALID))
-		measured_us = USEC_PER_SEC / HZ;
+	if (unlikely(!(target->flags & CPUIDLE_FLAG_TIME_VALID)))
+		last_idle_us = USEC_PER_SEC / HZ;
 
-	/* Predict time remaining until next break event */
-	if (measured_us + BREAK_FUZZ < data->expected_us - target->exit_latency) {
-		data->predicted_us = max(measured_us, data->last_measured_us);
+	/*
+	 * measured_us and elapsed_us are the cumulative idle time, since the
+	 * last time we were woken out of idle by an interrupt.
+	 */
+	if (data->elapsed_us <= data->elapsed_us + last_idle_us)
+		measured_us = data->elapsed_us + last_idle_us;
+	else
+		measured_us = -1;
+
+	/* Predict time until next break event */
+	data->predicted_us = max(measured_us, data->last_measured_us);
+
+	if (last_idle_us + BREAK_FUZZ <
+	    data->expected_us - target->exit_latency) {
 		data->last_measured_us = measured_us;
 		data->elapsed_us = 0;
 	} else {
-		if (data->elapsed_us < data->elapsed_us + measured_us)
-			data->elapsed_us = measured_us;
-		else
-			data->elapsed_us = -1;
-		data->predicted_us = max(measured_us, data->last_measured_us);
+		data->elapsed_us = measured_us;
 	}
 }
 

-- 
