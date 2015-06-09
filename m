From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/8] power: Add devm_power_supply_get_by_phandle() helper function
Date: Tue,  9 Jun 2015 23:37:56 +0200
Message-ID: <1433885881-19809-4-git-send-email-hdegoede@redhat.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49115 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932699AbbFIViZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Jun 2015 17:38:25 -0400
In-Reply-To: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>

This commit adds a resource-managed version of the
power_supply_get_by_phandle() function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/power_supply_core.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/power_supply.h      |  5 +++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 2ed4a4a..59856bc 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -420,6 +420,45 @@ struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 	return psy;
 }
 EXPORT_SYMBOL_GPL(power_supply_get_by_phandle);
+
+static void devm_power_supply_put(struct device *dev, void *res)
+{
+	struct power_supply **psy = res;
+
+	power_supply_put(*psy);
+}
+
+/**
+ * devm_power_supply_get_by_phandle() - Resource managed version of
+ *  power_supply_get_by_phandle()
+ * @dev: Pointer to device holding phandle property
+ * @phandle_name: Name of property holding a power supply phandle
+ *
+ * Return: On success returns a reference to a power supply with
+ * matching name equals to value under @property, NULL or ERR_PTR otherwise.
+ */
+struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
+						      const char *property)
+{
+	struct power_supply **ptr, *psy;
+
+	if (!dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	ptr = devres_alloc(devm_power_supply_put, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	psy = power_supply_get_by_phandle(dev->of_node, property);
+	if (IS_ERR_OR_NULL(psy)) {
+		devres_free(ptr);
+	} else {
+		*ptr = psy;
+		devres_add(dev, ptr);
+	}
+	return psy;
+}
+EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
 #endif /* CONFIG_OF */
 
 int power_supply_get_property(struct power_supply *psy,
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 75a1dd8..a99cf4f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -286,10 +286,15 @@ extern void power_supply_put(struct power_supply *psy);
 #ifdef CONFIG_OF
 extern struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 							const char *property);
+extern struct power_supply *devm_power_supply_get_by_phandle(
+				    struct device *dev, const char *property);
 #else /* !CONFIG_OF */
 static inline struct power_supply *
 power_supply_get_by_phandle(struct device_node *np, const char *property)
 { return NULL; }
+static inline struct power_supply *
+devm_power_supply_get_by_phandle(struct device *dev, const char *property)
+{ return NULL; }
 #endif /* CONFIG_OF */
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
-- 
2.3.6

