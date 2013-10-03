From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 04/16] cpuidle: make __cpuidle_device_init() return void
Date: Thu,  3 Oct 2013 21:26:43 +0530
Message-ID: <7f788ee893ccb6c283495488ad70ffd0205f0c11.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

__cpuidle_device_init() doesn't return anything except zero and so doesn't
really need a return type other than void.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 8827c02..211e504 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -358,12 +358,10 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
 	module_put(drv->owner);
 }
 
-static int __cpuidle_device_init(struct cpuidle_device *dev)
+static void __cpuidle_device_init(struct cpuidle_device *dev)
 {
 	memset(dev->states_usage, 0, sizeof(dev->states_usage));
 	dev->last_residency = 0;
-
-	return 0;
 }
 
 /**
@@ -410,9 +408,7 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 	if (dev->registered)
 		goto out_unlock;
 
-	ret = __cpuidle_device_init(dev);
-	if (ret)
-		goto out_unlock;
+	__cpuidle_device_init(dev);
 
 	ret = __cpuidle_register_device(dev);
 	if (ret)
-- 
1.7.12.rc2.18.g61b472e
