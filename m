From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 01/19] reset: add of_reset_control_get_by_index()
Date: Mon, 13 Jul 2015 13:39:39 +0100
Message-ID: <1436791197-32358-2-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Add of_reset_control_get_by_index() to allow the drivers to get reset
device without knowing its name.

Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
[jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org: Updated stub function to return -ENOTSUPP instead
 of -ENOSYS which should only be used for system calls.]
Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

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
index da5602bd77d7..26f1b53386d8 100644
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
+	return ERR_PTR(-ENOTSUPP);
+}
+
 #endif /* CONFIG_RESET_CONTROLLER */
 
 #endif
-- 
2.1.4
