From: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH RFC 08/10] hwspinlock: qcom: Lock #7 is special lock, uses dynamic proc_id
Date: Wed,  5 Aug 2015 10:32:44 -0600
Message-ID: <1438792366-2737-9-git-send-email-lina.iyer@linaro.org>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438792366-2737-1-git-send-email-lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, msivasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jeffrey Hugo <jhugo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hwspinlocks are widely used between processors in an SoC, and also
between elevation levels within in the same processor.  QCOM SoC's use
hwspinlock to serialize entry into a low power mode when the context
switches from Linux to secure monitor.

Lock #7 has been assigned for this purpose. In order to differentiate
between one cpu core holding a lock while another cpu is contending for
the same lock, the proc id written into the lock is (128 + cpu id). This
makes it unique value among the cpu cores and therefore when a core
locks the hwspinlock, other cores would wait for the lock to be released
since they would have a different proc id.  This value is specific for
the lock #7 only.

Declare lock #7 as raw capable, so the hwspinlock framework would not
enfore acquiring a s/w spinlock before acquiring the hwspinlock.

Cc: Jeffrey Hugo <jhugo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Cc: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/hwspinlock/qcom_hwspinlock.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index c752447..573f0dd 100644
--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -25,16 +25,26 @@
 
 #include "hwspinlock_internal.h"
 
-#define QCOM_MUTEX_APPS_PROC_ID	1
-#define QCOM_MUTEX_NUM_LOCKS	32
+#define QCOM_MUTEX_APPS_PROC_ID		1
+#define QCOM_MUTEX_CPUIDLE_OFFSET	128
+#define QCOM_CPUIDLE_LOCK		7
+#define QCOM_MUTEX_NUM_LOCKS		32
+
+static inline u32 __qcom_get_proc_id(struct hwspinlock *lock)
+{
+	return hwspin_lock_get_id(lock) == QCOM_CPUIDLE_LOCK ?
+			(QCOM_MUTEX_CPUIDLE_OFFSET + smp_processor_id()) :
+			QCOM_MUTEX_APPS_PROC_ID;
+}
 
 static int qcom_hwspinlock_trylock(struct hwspinlock *lock)
 {
 	struct regmap_field *field = lock->priv;
 	u32 lock_owner;
 	int ret;
+	u32 proc_id = __qcom_get_proc_id(lock);
 
-	ret = regmap_field_write(field, QCOM_MUTEX_APPS_PROC_ID);
+	ret = regmap_field_write(field, proc_id);
 	if (ret)
 		return ret;
 
@@ -42,7 +52,7 @@ static int qcom_hwspinlock_trylock(struct hwspinlock *lock)
 	if (ret)
 		return ret;
 
-	return lock_owner == QCOM_MUTEX_APPS_PROC_ID;
+	return lock_owner == proc_id;
 }
 
 static void qcom_hwspinlock_unlock(struct hwspinlock *lock)
@@ -57,7 +67,7 @@ static void qcom_hwspinlock_unlock(struct hwspinlock *lock)
 		return;
 	}
 
-	if (lock_owner != QCOM_MUTEX_APPS_PROC_ID) {
+	if (lock_owner != __qcom_get_proc_id(lock)) {
 		pr_err("%s: spinlock not owned by us (actual owner is %d)\n",
 				__func__, lock_owner);
 	}
@@ -129,6 +139,8 @@ static int qcom_hwspinlock_probe(struct platform_device *pdev)
 							     regmap, field);
 	}
 
+	bank->lock[QCOM_CPUIDLE_LOCK].hwcaps = HWL_CAP_ALLOW_RAW;
+
 	pm_runtime_enable(&pdev->dev);
 
 	ret = hwspin_lock_register(bank, &pdev->dev, &qcom_hwspinlock_ops,
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
