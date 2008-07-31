From: venkatesh.pallipadi@intel.com
Subject: [patch 3/3] cpuidle: Make ladder governor honor latency
	requirements fully
Date: Wed, 30 Jul 2008 19:21:44 -0700
Message-ID: <20080731022216.041218000@intel.com>
References: <20080731022141.088307000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=ladder_latency_requirement.patch
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

ladder governor only honored latency requirement when promoting C-states.
Instead. it should check for latency requirement on each idle call,
and demote to appropriate C-state when there is a latency requirement change.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

---
 drivers/cpuidle/governors/ladder.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6/drivers/cpuidle/governors/ladder.c
===================================================================
--- linux-2.6.orig/drivers/cpuidle/governors/ladder.c	2008-07-28 15:49:10.000000000 -0700
+++ linux-2.6/drivers/cpuidle/governors/ladder.c	2008-07-28 15:49:21.000000000 -0700
@@ -99,6 +99,18 @@ static int ladder_select_state(struct cp
 
 	/* consider demotion */
 	if (last_idx > CPUIDLE_DRIVER_STATE_START &&
+	    dev->states[last_idx].exit_latency > latency_req) {
+		int i;
+
+		for (i = last_idx - 1; i > CPUIDLE_DRIVER_STATE_START; i--) {
+			if (dev->states[i].exit_latency <= latency_req)
+				break;
+		}
+		ladder_do_selection(ldev, last_idx, i);
+		return i;
+	}
+
+	if (last_idx > CPUIDLE_DRIVER_STATE_START &&
 	    last_residency < last_state->threshold.demotion_time) {
 		last_state->stats.demotion_count++;
 		last_state->stats.promotion_count = 0;

-- 
