From: riel@redhat.com
Subject: [PATCH 2/3] cpuidle,menu: use interactivity_req to disable polling
Date: Tue,  3 Nov 2015 17:34:18 -0500
Message-ID: <1446590059-18897-3-git-send-email-riel@redhat.com>
References: <1446590059-18897-1-git-send-email-riel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446590059-18897-1-git-send-email-riel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, arjan@linux.intel.com, len.brown@intel.com, daniel.lezcano@linaro.org
List-Id: linux-pm@vger.kernel.org

From: Rik van Riel <riel@redhat.com>

The menu governor carefully figures out how much time we typically
sleep for an estimated sleep interval, or whether there is a repeating
pattern going on, and corrects that estimate for the CPU load.

Then it proceeds to ignore that information when determining whether
or not to consider polling. This is not a big deal on most x86 CPUs,
which have very low C1 latencies, and the patch should not have any
effect on those CPUs.

However, certain CPUs (eg. Atom) have much higher C1 latencies, and
it would be good to not waste performance and power on those CPUs if
we are expecting a very low wakeup latency.

Disable polling based on the estimated interactivity requirement, not
on the time to the next timer interrupt.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 drivers/cpuidle/governors/menu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index ecc242a586c9..b1a55731f921 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -330,7 +330,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * We want to default to C1 (hlt), not to busy polling
 	 * unless the timer is happening really really soon.
 	 */
-	if (data->next_timer_us > 20 &&
+	if (interactivity_req > 20 &&
 	    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
 		dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
-- 
2.1.0
