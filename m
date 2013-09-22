From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 15/21] cpuidle: free all state kobjects from cpuidle_free_state_kobj()
Date: Sun, 22 Sep 2013 06:51:07 +0530
Message-ID: <503b7472308007b4c233b33d19f5a54c138212e7.1379779777.git.viresh.kumar@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379779777.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379779777.git.viresh.kumar@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Loop for states is currently present on callers side and so is replicated at
several places. It would be better to move that inside cpuidle_free_state_kobj()
instead.

This patch does it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpuidle/sysfs.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index e918b6d..ade31a9 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -378,12 +378,17 @@ static struct kobj_type ktype_state_cpuidle = {
 	.release = cpuidle_state_sysfs_release,
 };
 
-static inline void cpuidle_free_state_kobj(struct cpuidle_device *device, int i)
+static inline void cpuidle_free_state_kobj(struct cpuidle_device *device,
+		int count)
 {
-	kobject_put(&device->kobjs[i]->kobj);
-	wait_for_completion(&device->kobjs[i]->kobj_unregister);
-	kfree(device->kobjs[i]);
-	device->kobjs[i] = NULL;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		kobject_put(&device->kobjs[i]->kobj);
+		wait_for_completion(&device->kobjs[i]->kobj_unregister);
+		kfree(device->kobjs[i]);
+		device->kobjs[i] = NULL;
+	}
 }
 
 /**
@@ -419,8 +424,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 	return 0;
 
 error_state:
-	for (i = i - 1; i >= 0; i--)
-		cpuidle_free_state_kobj(device, i);
+	cpuidle_free_state_kobj(device, i);
 	return ret;
 }
 
@@ -430,10 +434,7 @@ error_state:
  */
 static void cpuidle_remove_state_sysfs(struct cpuidle_device *device)
 {
-	int i;
-
-	for (i = 0; i < device->state_count; i++)
-		cpuidle_free_state_kobj(device, i);
+	cpuidle_free_state_kobj(device, device->state_count);
 }
 
 #ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
-- 
1.7.12.rc2.18.g61b472e
