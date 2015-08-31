From: Xunlei Pang <xlpang@126.com>
Subject: [PATCH v3] cpuidle/coupled: Add sanity check for safe_state_index
Date: Mon, 31 Aug 2015 11:34:05 +0800
Message-ID: <1440992045-17464-1-git-send-email-xlpang@126.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m50-111.126.com ([123.125.50.111]:47046 "EHLO m50-111.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbbHaDfm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 30 Aug 2015 23:35:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>

From: Xunlei Pang <pang.xunlei@linaro.org>

Since we are using cpuidle_driver::safe_state_index directly as the
target state index, it is better to add the sanity check at the point
of registering the driver.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
v2->v3:
Move the code to a new cpuidle_coupled_state_verify() depending on 
CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED, to avoid using #ifdef in function 
bodies. Thanks Rafael's comments on this.

 drivers/cpuidle/coupled.c | 22 ++++++++++++++++++++++
 drivers/cpuidle/cpuidle.h |  6 ++++++
 drivers/cpuidle/driver.c  |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 1523e2d..344058f 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -187,6 +187,28 @@ bool cpuidle_state_is_coupled(struct cpuidle_driver *drv, int state)
 }
 
 /**
+ * cpuidle_coupled_state_verify - check if the coupled states are correctly set.
+ * @drv: struct cpuidle_driver for the platform
+ *
+ * Returns 0 for valid state values, a negative error code otherwise:
+ *  * -EINVAL if any coupled state(safe_state_index) is wrongly set.
+ */
+int cpuidle_coupled_state_verify(struct cpuidle_driver *drv)
+{
+	int i;
+
+	for (i = drv->state_count - 1; i >= 0; i--) {
+		if (cpuidle_state_is_coupled(drv, i) &&
+		    (drv->safe_state_index == i ||
+		     drv->safe_state_index < 0 ||
+		     drv->safe_state_index >= drv->state_count))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
  * cpuidle_coupled_set_ready - mark a cpu as ready
  * @coupled: the struct coupled that contains the current cpu
  */
diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
index 178c5ad..f87f399 100644
--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -35,6 +35,7 @@ extern void cpuidle_remove_sysfs(struct cpuidle_device *dev);
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 bool cpuidle_state_is_coupled(struct cpuidle_driver *drv, int state);
+int cpuidle_coupled_state_verify(struct cpuidle_driver *drv);
 int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int next_state);
 int cpuidle_coupled_register_device(struct cpuidle_device *dev);
@@ -46,6 +47,11 @@ bool cpuidle_state_is_coupled(struct cpuidle_driver *drv, int state)
 	return false;
 }
 
+static inline int cpuidle_coupled_state_verify(struct cpuidle_driver *drv)
+{
+	return 0;
+}
+
 static inline int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int next_state)
 {
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 5db1478..389ade4 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -227,6 +227,10 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv)
 	if (!drv || !drv->state_count)
 		return -EINVAL;
 
+	ret = cpuidle_coupled_state_verify(drv);
+	if (ret)
+		return ret;
+
 	if (cpuidle_disabled())
 		return -ENODEV;
 
-- 
1.9.1


