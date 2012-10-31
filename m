From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V3 3/4] cpuidle: prepare the driver core to be multi drivers
	aware
Date: Wed, 31 Oct 2012 17:44:47 +0100
Message-ID: <1351701888-19963-4-git-send-email-daniel.lezcano@linaro.org>
References: <1351701888-19963-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1351701888-19963-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch is a preparation for the multiple drivers support.

As the next patch will introduce the multiple drivers with the Kconfig
option and we want to keep the code clean and understandable, this patch
defines a set of functions for encapsulating some common parts and split
what should be done in a lock context or not.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/cpuidle/driver.c |   60 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 3e59075..8246662 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -39,11 +39,20 @@ static void set_power_states(struct cpuidle_driver *drv)
 		drv->states[i].power_usage = -1 - i;
 }
 
-/**
- * cpuidle_register_driver - registers a driver
- * @drv: the driver
- */
-int cpuidle_register_driver(struct cpuidle_driver *drv)
+static void __cpuidle_driver_init(struct cpuidle_driver *drv)
+{
+	drv->refcnt = 0;
+
+	if (!drv->power_specified)
+		set_power_states(drv);
+}
+
+static void cpuidle_set_driver(struct cpuidle_driver *drv)
+{
+	cpuidle_curr_driver = drv;
+}
+
+static int __cpuidle_register_driver(struct cpuidle_driver *drv)
 {
 	if (!drv || !drv->state_count)
 		return -EINVAL;
@@ -51,22 +60,38 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
 	if (cpuidle_disabled())
 		return -ENODEV;
 
-	spin_lock(&cpuidle_driver_lock);
-	if (cpuidle_curr_driver) {
-		spin_unlock(&cpuidle_driver_lock);
+	if (cpuidle_get_driver())
 		return -EBUSY;
-	}
 
-	if (!drv->power_specified)
-		set_power_states(drv);
+	__cpuidle_driver_init(drv);
 
-	drv->refcnt = 0;
+	cpuidle_set_driver(drv);
 
-	cpuidle_curr_driver = drv;
+	return 0;
+}
+
+static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
+{
+	if (drv != cpuidle_get_driver())
+		return;
+
+	if (!WARN_ON(drv->refcnt > 0))
+		cpuidle_set_driver(NULL);
+}
 
+/**
+ * cpuidle_register_driver - registers a driver
+ * @drv: the driver
+ */
+int cpuidle_register_driver(struct cpuidle_driver *drv)
+{
+	int ret;
+
+	spin_lock(&cpuidle_driver_lock);
+	ret = __cpuidle_register_driver(drv);
 	spin_unlock(&cpuidle_driver_lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpuidle_register_driver);
 
@@ -86,8 +111,7 @@ EXPORT_SYMBOL_GPL(cpuidle_get_driver);
 void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
 	spin_lock(&cpuidle_driver_lock);
-	if (drv == cpuidle_curr_driver && !WARN_ON(drv->refcnt > 0))
-		cpuidle_curr_driver = NULL;
+	__cpuidle_unregister_driver(drv);
 	spin_unlock(&cpuidle_driver_lock);
 }
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
@@ -98,7 +122,7 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
 
 	spin_lock(&cpuidle_driver_lock);
 
-	drv = cpuidle_curr_driver;
+	drv = cpuidle_get_driver();
 	drv->refcnt++;
 
 	spin_unlock(&cpuidle_driver_lock);
@@ -107,7 +131,7 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
 
 void cpuidle_driver_unref(void)
 {
-	struct cpuidle_driver *drv = cpuidle_curr_driver;
+	struct cpuidle_driver *drv = cpuidle_get_driver();
 
 	spin_lock(&cpuidle_driver_lock);
 
-- 
1.7.5.4
