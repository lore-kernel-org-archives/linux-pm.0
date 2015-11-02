From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 1/2] thermal: devfreq_cooling: use a thermal_cooling_device for register and unregister
Date: Mon,  2 Nov 2015 19:03:03 +0000
Message-ID: <1446490984-18438-2-git-send-email-javi.merino@arm.com>
References: <1446490984-18438-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446490984-18438-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, orjan.eide@arm.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Be consistent with what other cooling devices do and return a struct
thermal_cooling_device * on register.  Also, for the unregister, accept
a struct thermal_cooling_device * as parameter.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 16 ++++++++++------
 include/linux/devfreq_cooling.h   | 16 ++++++++--------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index a27206815066..31e40a9a9fd0 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -467,7 +467,7 @@ free_power_table:
  * devfreq should use the simple_ondemand governor, other governors
  * are not currently supported.
  */
-struct devfreq_cooling_device *
+struct thermal_cooling_device *
 of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 				  struct devfreq_cooling_power *dfc_power)
 {
@@ -513,7 +513,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 
 	dfc->cdev = cdev;
 
-	return dfc;
+	return cdev;
 
 release_idr:
 	release_idr(&devfreq_idr, dfc->id);
@@ -533,7 +533,7 @@ EXPORT_SYMBOL_GPL(of_devfreq_cooling_register_power);
  * @np: Pointer to OF device_node.
  * @df: Pointer to devfreq device.
  */
-struct devfreq_cooling_device *
+struct thermal_cooling_device *
 of_devfreq_cooling_register(struct device_node *np, struct devfreq *df)
 {
 	return of_devfreq_cooling_register_power(np, df, NULL);
@@ -544,7 +544,7 @@ EXPORT_SYMBOL_GPL(of_devfreq_cooling_register);
  * devfreq_cooling_register() - Register devfreq cooling device.
  * @df: Pointer to devfreq device.
  */
-struct devfreq_cooling_device *devfreq_cooling_register(struct devfreq *df)
+struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
 {
 	return of_devfreq_cooling_register(NULL, df);
 }
@@ -554,11 +554,15 @@ EXPORT_SYMBOL_GPL(devfreq_cooling_register);
  * devfreq_cooling_unregister() - Unregister devfreq cooling device.
  * @dfc: Pointer to devfreq cooling device to unregister.
  */
-void devfreq_cooling_unregister(struct devfreq_cooling_device *dfc)
+void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
-	if (!dfc)
+	struct devfreq_cooling_device *dfc;
+
+	if (!cdev)
 		return;
 
+	dfc = cdev->devdata;
+
 	thermal_cooling_device_unregister(dfc->cdev);
 	release_idr(&devfreq_idr, dfc->id);
 	kfree(dfc->power_table);
diff --git a/include/linux/devfreq_cooling.h b/include/linux/devfreq_cooling.h
index ee5f0ec9290b..7adf6cc4b305 100644
--- a/include/linux/devfreq_cooling.h
+++ b/include/linux/devfreq_cooling.h
@@ -43,37 +43,37 @@ struct devfreq_cooling_power {
 	unsigned long dyn_power_coeff;
 };
 
-struct devfreq_cooling_device *
+struct thermal_cooling_device *
 of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 				  struct devfreq_cooling_power *dfc_power);
-struct devfreq_cooling_device *
+struct thermal_cooling_device *
 of_devfreq_cooling_register(struct device_node *np, struct devfreq *df);
-struct devfreq_cooling_device *devfreq_cooling_register(struct devfreq *df);
-void devfreq_cooling_unregister(struct devfreq_cooling_device *dfc);
+struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df);
+void devfreq_cooling_unregister(struct thermal_cooling_device *dfc);
 
 #else /* !CONFIG_DEVFREQ_THERMAL */
 
-struct devfreq_cooling_device *
+struct thermal_cooling_device *
 of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 				  struct devfreq_cooling_power *dfc_power)
 {
 	return ERR_PTR(-EINVAL);
 }
 
-static inline struct devfreq_cooling_device *
+static inline struct thermal_cooling_device *
 of_devfreq_cooling_register(struct device_node *np, struct devfreq *df)
 {
 	return ERR_PTR(-EINVAL);
 }
 
-static inline struct devfreq_cooling_device *
+static inline struct thermal_cooling_device *
 devfreq_cooling_register(struct devfreq *df)
 {
 	return ERR_PTR(-EINVAL);
 }
 
 static inline void
-devfreq_cooling_unregister(struct devfreq_cooling_device *dfc)
+devfreq_cooling_unregister(struct thermal_cooling_device *dfc)
 {
 }
 
-- 
1.9.1
