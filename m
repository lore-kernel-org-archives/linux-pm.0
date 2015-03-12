From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 01/17] reset: add of_reset_control_get_by_index()
Date: Thu, 12 Mar 2015 20:15:02 +0800
Message-ID: <1426162518-7405-2-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, Vince Hsu <vinceh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Add of_reset_control_get_by_index() to allow the drivers to get reset device
without knowing its name.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>

---
v2: minor changes according to Alex's comments

 drivers/reset/core.c  | 44 +++++++++++++++++++++++++++++---------------
 include/linux/reset.h |  9 +++++++++
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 7955e00d04d4..5e78866acd62 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -140,28 +140,15 @@ int reset_control_status(struct reset_control *rstc)
 }
 EXPORT_SYMBOL_GPL(reset_control_status);
 
-/**
- * of_reset_control_get - Lookup and obtain a reference to a reset controller.
- * @node: device to be reset by the controller
- * @id: reset line name
- *
- * Returns a struct reset_control or IS_ERR() condition containing errno.
- *
- * Use of id names is optional.
- */
-struct reset_control *of_reset_control_get(struct device_node *node,
-					   const char *id)
+struct reset_control *__of_reset_control_get(struct device_node *node,
+						int index)
 {
 	struct reset_control *rstc = ERR_PTR(-EPROBE_DEFER);
 	struct reset_controller_dev *r, *rcdev;
 	struct of_phandle_args args;
-	int index = 0;
 	int rstc_id;
 	int ret;
 
-	if (id)
-		index = of_property_match_string(node,
-						 "reset-names", id);
 	ret = of_parse_phandle_with_args(node, "resets", "#reset-cells",
 					 index, &args);
 	if (ret)
@@ -202,6 +189,33 @@ struct reset_control *of_reset_control_get(struct device_node *node,
 
 	return rstc;
 }
+
+struct reset_control *of_reset_control_get_by_index(struct device_node *node,
+					   int index)
+{
+	return __of_reset_control_get(node, index);
+}
+EXPORT_SYMBOL_GPL(of_reset_control_get_by_index);
+
+/**
+ * of_reset_control_get - Lookup and obtain a reference to a reset controller.
+ * @node: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ *
+ * Use of id names is optional.
+ */
+struct reset_control *of_reset_control_get(struct device_node *node,
+					   const char *id)
+{
+	int index = 0;
+
+	if (id)
+		index = of_property_match_string(node,
+						 "reset-names", id);
+	return __of_reset_control_get(node, index);
+}
 EXPORT_SYMBOL_GPL(of_reset_control_get);
 
 /**
diff --git a/include/linux/reset.h b/include/linux/reset.h
index da5602bd77d7..d998df70008d 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -38,6 +38,9 @@ static inline struct reset_control *devm_reset_control_get_optional(
 struct reset_control *of_reset_control_get(struct device_node *node,
 					   const char *id);
 
+struct reset_control *of_reset_control_get_by_index(
+					struct device_node *node, int index);
+
 #else
 
 static inline int reset_control_reset(struct reset_control *rstc)
@@ -92,6 +95,12 @@ static inline struct reset_control *of_reset_control_get(
 	return ERR_PTR(-ENOSYS);
 }
 
+static inline struct reset_control *of_reset_control_get_by_index(
+				struct device_node *node, int index)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 #endif /* CONFIG_RESET_CONTROLLER */
 
 #endif
-- 
2.1.4
