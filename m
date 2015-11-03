From: riel@redhat.com
Subject: [PATCH 3/3] cpuidle,menu: smooth out measured_us calculation
Date: Tue,  3 Nov 2015 17:34:19 -0500
Message-ID: <1446590059-18897-4-git-send-email-riel@redhat.com>
References: <1446590059-18897-1-git-send-email-riel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446590059-18897-1-git-send-email-riel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, arjan@linux.intel.com, len.brown@intel.com, daniel.lezcano@linaro.org
List-Id: linux-pm@vger.kernel.org

From: Rik van Riel <riel@redhat.com>

The cpuidle state tables contain the maximum exit latency for each
cpuidle state. On x86, that is the exit latency for when the entire
package goes into that same idle state.

However, a lot of the time we only go into the core idle state,
not the package idle state. This means we see a much smaller exit
latency.

We have no way to detect whether we went into the core or package
idle state while idle, and that is ok.

However, the current menu_update logic does have the potential to
trip up the repeating pattern detection in get_typical_interval.
If the system is experiencing an exit latency near the idle state's
exit latency, some of the samples will have exit_us subtracted,
while others will not. This turns a repeating pattern into mush,
potentially breaking get_typical_interval.

Furthermore, for smaller sleep intervals, we know the chance that
all the cores in the package went to the same idle state are fairly
small. Dividing the measured_us by two, instead of subtracting the
full exit latency when hitting a small measured_us, will reduce the
error.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 drivers/cpuidle/governors/menu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b1a55731f921..7b0971d97cc3 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -404,8 +404,10 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	measured_us = cpuidle_get_last_residency(dev);
 
 	/* Deduct exit latency */
-	if (measured_us > target->exit_latency)
+	if (measured_us > 2 * target->exit_latency)
 		measured_us -= target->exit_latency;
+	else
+		measured_us /= 2;
 
 	/* Make sure our coefficients do not exceed unity */
 	if (measured_us > data->next_timer_us)
-- 
2.1.0
