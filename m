From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 06/16] cpuidle: rearrange code in __cpuidle_driver_init()
Date: Thu,  3 Oct 2013 21:26:45 +0530
Message-ID: <77dcb6954b52386106a0ba262b093e6718e0fd7b.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This is trivial patch that just reorders few statements in
__cpuidle_driver_init() routine, so that we don't need both 'continue' and
'break' in the for loop. Functionally it shouldn't change anything.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpuidle/driver.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index ebc6b0f..58077a9 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -170,12 +170,10 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 	 * order, because usually one of the deeper states have this flag set.
 	 */
 	for (i = drv->state_count - 1; i >= 0 ; i--) {
-
-		if (!(drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP))
-			continue;
-
-		drv->bctimer = 1;
-		break;
+		if (drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP) {
+			drv->bctimer = 1;
+			break;
+		}
 	}
 }
 
-- 
1.7.12.rc2.18.g61b472e
