From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 08/16] cpuidle: merge two if() statements for checking error cases
Date: Thu,  3 Oct 2013 21:26:47 +0530
Message-ID: <2e680462629529a569ab67dbd9ea4071f01f115c.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Both return same error message and so better write them in a single line.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 8c91bad..518b542 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -119,10 +119,7 @@ int cpuidle_idle_call(void)
 	struct cpuidle_driver *drv;
 	int next_state, entered_state;
 
-	if (off)
-		return -ENODEV;
-
-	if (!initialized)
+	if (off || !initialized)
 		return -ENODEV;
 
 	/* check if the device is ready */
-- 
1.7.12.rc2.18.g61b472e
