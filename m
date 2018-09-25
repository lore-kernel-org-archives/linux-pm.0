From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH RFC] cpuidle/drivers/menu: Remove get_loadavg in the performance multiplier
Date: Tue, 25 Sep 2018 11:38:44 +0200
Message-ID: <1537868328-13405-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Colin Cross <ccross@android.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The function get_loadavg() returns almost always zero. To be more
precise, statistically speaking for a total of 1023379 times passing
to the function, the load is equal to zero 1020728 times, greater than
100, 610 times, the remaining is between 0 and 5.

I'm putting in question this metric. Is it worth to keep it?

Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Colin Cross <ccross@android.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index e26a409..d939b8e 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -173,18 +173,10 @@ static inline int which_bucket(unsigned int duration, unsigned long nr_iowaiters
  * to be, the higher this multiplier, and thus the higher
  * the barrier to go to an expensive C state.
  */
-static inline int performance_multiplier(unsigned long nr_iowaiters, unsigned long load)
+static inline int performance_multiplier(unsigned long nr_iowaiters)
 {
-	int mult = 1;
-
-	/* for higher loadavg, we are more reluctant */
-
-	mult += 2 * get_loadavg(load);
-
 	/* for IO wait tasks (per cpu!) we add 5x each */
-	mult += 10 * nr_iowaiters;
-
-	return mult;
+	return 1 + 10 * nr_iowaiters;
 }
 
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
@@ -359,7 +351,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 * Use the performance multiplier and the user-configurable
 		 * latency_req to determine the maximum exit latency.
 		 */
-		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
+		interactivity_req = data->predicted_us /
+			performance_multiplier(nr_iowaiters);
 		if (latency_req > interactivity_req)
 			latency_req = interactivity_req;
 	}
-- 
2.7.4
