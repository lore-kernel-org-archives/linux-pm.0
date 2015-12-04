From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 01/16] reset: add of_reset_control_get_by_index()
Date: Fri, 4 Dec 2015 14:57:02 +0000
Message-ID: <1449241037-22193-2-git-send-email-jonathanh@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

From: Vince Hsu <vinceh@nvidia.com>

Add of_reset_control_get_by_index() to allow the drivers to get reset
device without knowing its name.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
[jonathanh@nvidia.com: Updated stub function to return -ENOTSUPP instead
 of -ENOSYS which should only be used for system calls.]
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

---
v3: addressed comments from Philipp
v2: minor changes according to Alex's comments
---
 drivers/reset/core.c  | 40 +++++++++++++++++++++++++++++-----------
 include/linux/reset.h |  9 +++++++++
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 7955e00d04d4..81ae17d15480 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -141,27 +141,24 @@ int reset_control_status(struct reset_control *rstc)
 EXPORT_SYMBOL_GPL(reset_control_status);
 
 /**
- * of_reset_control_get - Lookup and obtain a reference to a reset controller.
+ * of_reset_control_get_by_index - Lookup and obtain a reference to a reset
+ * controller by index.
  * @node: device to be reset by the controller
- * @id: reset line name
- *
- * Returns a struct reset_control or IS_ERR() condition containing errno.
+ * @index: index of the reset controller
  *
- * Use of id names is optional.
+ * This is to be used to perform a list of resets for a device or power domain
+ * in whatever order. Returns a struct reset_control or IS_ERR() condition
+ * containing errno.
  */
-struct reset_control *of_reset_control_get(struct device_node *node,
-					   const char *id)
+struct reset_control *of_reset_control_get_by_index(struct device_node *node,
+					   int index)
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
@@ -202,6 +199,27 @@ struct reset_control *of_reset_control_get(struct device_node *node,
 
 	return rstc;
 }
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
+	return of_reset_control_get_by_index(node, index);
+}
 EXPORT_SYMBOL_GPL(of_reset_control_get);
 
 /**
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 7f65f9cff951..6db74ad3dec7 100644
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
@@ -106,6 +109,12 @@ static inline struct reset_control *of_reset_control_get(
 	return ERR_PTR(-ENOSYS);
 }
 
+static inline struct reset_control *of_reset_control_get_by_index(
+				struct device_node *node, int index)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 #endif /* CONFIG_RESET_CONTROLLER */
 
 #endif
-- 
2.1.4
