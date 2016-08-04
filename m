From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 1/2] power: reset: reboot-mode: Add managed resource API
Date: Wed,  3 Aug 2016 22:04:05 -0700
Message-ID: <1470287046-17437-1-git-send-email-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, John Stultz <john.stultz@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Provide managed resource version of reboot_mode_register() and
reboot_mode_unregister() to simplify implementations.

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

John, here's a "pointer" to what I meant with my comment on your
sram-reboot-mode patch. Only compile tested though.

 Documentation/driver-model/devres.txt |  4 +++
 drivers/power/reset/reboot-mode.c     | 59 +++++++++++++++++++++++++++++++++++
 drivers/power/reset/reboot-mode.h     |  4 +++
 3 files changed, 67 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index f5e522342ee5..fbb9fde1aad3 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -342,6 +342,10 @@ PINCTRL
   devm_pinctrl_register()
   devm_pinctrl_unregister()
 
+POWER
+  devm_reboot_mode_register()
+  devm_reboot_mode_unregister()
+
 PWM
   devm_pwm_get()
   devm_pwm_put()
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 2dfbbce0f817..fb512183ace3 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -135,6 +135,65 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 }
 EXPORT_SYMBOL_GPL(reboot_mode_unregister);
 
+static void devm_reboot_mode_release(struct device *dev, void *res)
+{
+	reboot_mode_unregister(*(struct reboot_mode_driver **)res);
+}
+
+/**
+ * devm_reboot_mode_register() - resource managed reboot_mode_register()
+ * @dev: device to associate this resource with
+ * @reboot: reboot mode driver
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int devm_reboot_mode_register(struct device *dev,
+			      struct reboot_mode_driver *reboot)
+{
+	struct reboot_mode_driver **dr;
+	int rc;
+
+	dr = devres_alloc(devm_reboot_mode_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	rc = reboot_mode_register(reboot);
+	if (rc) {
+		devres_free(dr);
+		return rc;
+	}
+
+	*dr = reboot;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_reboot_mode_register);
+
+static int devm_reboot_mode_match(struct device *dev, void *res, void *data)
+{
+	struct reboot_mode_driver **p = res;
+
+	if (WARN_ON(!p || !*p))
+		return 0;
+
+	return *p == data;
+}
+
+/**
+ * devm_reboot_mode_unregister() - resource managed reboot_mode_unregister()
+ * @dev: device to associate this resource with
+ * @reboot: reboot mode driver
+ */
+void devm_reboot_mode_unregister(struct device *dev,
+				 struct reboot_mode_driver *reboot)
+{
+	WARN_ON(devres_release(dev,
+			       devm_reboot_mode_release,
+			       devm_reboot_mode_match, reboot));
+}
+EXPORT_SYMBOL_GPL(devm_reboot_mode_unregister);
+
 MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
 MODULE_DESCRIPTION("System reboot mode core library");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/reset/reboot-mode.h b/drivers/power/reset/reboot-mode.h
index 2491bb71f591..75f7fe5c881f 100644
--- a/drivers/power/reset/reboot-mode.h
+++ b/drivers/power/reset/reboot-mode.h
@@ -10,5 +10,9 @@ struct reboot_mode_driver {
 
 int reboot_mode_register(struct reboot_mode_driver *reboot);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot);
+int devm_reboot_mode_register(struct device *dev,
+			      struct reboot_mode_driver *reboot);
+void devm_reboot_mode_unregister(struct device *dev,
+				 struct reboot_mode_driver *reboot);
 
 #endif
-- 
2.5.0
