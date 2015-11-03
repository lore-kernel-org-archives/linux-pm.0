From: riel@redhat.com
Subject: [PATCH 1/3] cpuidle,x86: increase forced cut-off for polling to 20us
Date: Tue,  3 Nov 2015 17:34:17 -0500
Message-ID: <1446590059-18897-2-git-send-email-riel@redhat.com>
References: <1446590059-18897-1-git-send-email-riel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446590059-18897-1-git-send-email-riel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, arjan@linux.intel.com, len.brown@intel.com, daniel.lezcano@linaro.org
List-Id: linux-pm@vger.kernel.org

From: Rik van Riel <riel@redhat.com>

The cpuidle menu governor has a forced cut-off for polling at 5us,
in order to deal with firmware that gives the OS bad information
on cpuidle states, leading to the system spending way too much time
in polling.

However, at least one x86 CPU family (Atom) has chips that have
a 20us break-even point for C1. Forcing the polling cut-off to
less than that wastes performance and power.

Increase the polling cut-off to 20us.

Systems with a lower C1 latency will be found in the states table by
the menu governor, which will pick those states as appropriate.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 drivers/cpuidle/governors/menu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 22e4463d1787..ecc242a586c9 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -330,7 +330,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * We want to default to C1 (hlt), not to busy polling
 	 * unless the timer is happening really really soon.
 	 */
-	if (data->next_timer_us > 5 &&
+	if (data->next_timer_us > 20 &&
 	    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
 		dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
-- 
2.1.0
