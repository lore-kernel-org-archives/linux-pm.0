From: Xunlei Pang <xlpang@126.com>
Subject: [PATCH v2 3/3] cpuidle/coupled: Add sanity check for safe_state_index
Date: Tue,  4 Aug 2015 13:48:57 +0800
Message-ID: <1438667337-16903-3-git-send-email-xlpang@126.com>
References: <1438667337-16903-1-git-send-email-xlpang@126.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438667337-16903-1-git-send-email-xlpang@126.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Xunlei Pang <pang.xunlei@linaro.org>

Since we're using cpuidle_driver::safe_state_index directly as the
target state index, it's better to add the sanity check at the point
of registering the driver.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/cpuidle/driver.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 5db1478..def299e 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -223,10 +223,23 @@ static void poll_idle_init(struct cpuidle_driver *drv) {}
 static int __cpuidle_register_driver(struct cpuidle_driver *drv)
 {
 	int ret;
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
+	int i;
+#endif
 
 	if (!drv || !drv->state_count)
 		return -EINVAL;
 
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
+	for (i = drv->state_count - 1; i >= 0; i--) {
+		if (cpuidle_state_is_coupled(drv, i) &&
+		    (drv->safe_state_index == i ||
+		     drv->safe_state_index < 0 ||
+		     drv->safe_state_index >= drv->state_count))
+			return -EINVAL;
+	}
+#endif
+
 	if (cpuidle_disabled())
 		return -ENODEV;
 
-- 
1.9.1
