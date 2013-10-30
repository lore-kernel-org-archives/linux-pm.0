From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH v2 2/2] cpufreq: arm_big_little: reconfigure switcher behavior
 at run time
Date: Wed, 30 Oct 2013 15:44:41 -0400
Message-ID: <1383162281-24204-3-git-send-email-nicolas.pitre@linaro.org>
References: <1383162281-24204-1-git-send-email-nicolas.pitre@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1383162281-24204-1-git-send-email-nicolas.pitre@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, sudeep.karkadanagesha@arm.com, dave.martin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

The b.L switcher can be turned on/off at run time.  It is therefore
necessary to change the cpufreq driver behavior accordingly.

The driver must be unregistered/registered with the cpufreq core
to reconfigure freq tables for the virtual or actual CPUs. This is
accomplished via the b.L switcher notifier callback.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 54 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index a6a8f74811..f63dc8dd80 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -40,9 +40,12 @@
 #define MAX_CLUSTERS	2
 
 #ifdef CONFIG_BL_SWITCHER
-#define is_bL_switching_enabled()	true
+static bool bL_switching_enabled;
+#define is_bL_switching_enabled()	bL_switching_enabled
+#define set_switching_enabled(x)	(bL_switching_enabled = (x))
 #else
 #define is_bL_switching_enabled()	false
+#define set_switching_enabled(x)	do { } while (0)
 #endif
 
 #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
@@ -508,6 +511,38 @@ static struct cpufreq_driver bL_cpufreq_driver = {
 	.attr			= cpufreq_generic_attr,
 };
 
+static int bL_cpufreq_switcher_notifier(struct notifier_block *nfb,
+					unsigned long action, void *_arg)
+{
+	pr_debug("%s: action: %ld\n", __func__, action);
+
+	switch (action) {
+	case BL_NOTIFY_PRE_ENABLE:
+	case BL_NOTIFY_PRE_DISABLE:
+		cpufreq_unregister_driver(&bL_cpufreq_driver);
+		break;
+
+	case BL_NOTIFY_POST_ENABLE:
+		set_switching_enabled(true);
+		cpufreq_register_driver(&bL_cpufreq_driver);
+		break;
+
+	case BL_NOTIFY_POST_DISABLE:
+		set_switching_enabled(false);
+		cpufreq_register_driver(&bL_cpufreq_driver);
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block bL_switcher_notifier = {
+	.notifier_call = bL_cpufreq_switcher_notifier,
+};
+
 int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
 {
 	int ret, i;
@@ -525,6 +560,9 @@ int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
 
 	arm_bL_ops = ops;
 
+	ret = bL_switcher_get_enabled();
+	set_switching_enabled(ret);
+
 	for (i = 0; i < MAX_CLUSTERS; i++)
 		mutex_init(&cluster_lock[i]);
 
@@ -534,10 +572,17 @@ int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
 				__func__, ops->name, ret);
 		arm_bL_ops = NULL;
 	} else {
-		pr_info("%s: Registered platform driver: %s\n", __func__,
-				ops->name);
+		ret = bL_switcher_register_notifier(&bL_switcher_notifier);
+		if (ret) {
+			cpufreq_unregister_driver(&bL_cpufreq_driver);
+			arm_bL_ops = NULL;
+		} else {
+			pr_info("%s: Registered platform driver: %s\n",
+					__func__, ops->name);
+		}
 	}
 
+	bL_switcher_put_enabled();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(bL_cpufreq_register);
@@ -550,7 +595,10 @@ void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
 		return;
 	}
 
+	bL_switcher_get_enabled();
+	bL_switcher_unregister_notifier(&bL_switcher_notifier);
 	cpufreq_unregister_driver(&bL_cpufreq_driver);
+	bL_switcher_put_enabled();
 	pr_info("%s: Un-registered platform driver: %s\n", __func__,
 			arm_bL_ops->name);
 	arm_bL_ops = NULL;
-- 
1.8.4.108.g55ea5f6

