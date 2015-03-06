From: Jenny TC <jenny.tc@intel.com>
Subject: [RFC 3/4] power_supply: Introduce charger control interface
Date: Fri,  6 Mar 2015 16:03:26 +0530
Message-ID: <1425638007-9411-4-git-send-email-jenny.tc@intel.com>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, jonghwa3.lee@samsung.com, myungjoo.ham@gmail.com, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, Jenny TC <jenny.tc@intel.com>
List-Id: linux-pm@vger.kernel.org

Introduce power_supply charger control interfaces to control
charging from charging framework like charger-manager. The interfaces
are similar to the existing power supply get/set interfaces, but
introduce a different set of properties in order to differentiate
itself from other power supply properties which exposed in sysfs

Signed-off-by: Jenny TC <jenny.tc@intel.com>
---
 include/linux/power_supply.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 30145d8e..a80a3ef 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -176,6 +176,32 @@ union power_supply_propval {
 struct device;
 struct device_node;
 
+enum psy_charger_control_property {
+	PSY_CHARGER_PROP_ENABLE_CHARGING = 0,
+	PSY_CHARGER_PROP_ENABLE_CHARGER,
+	PSY_CHARGER_PROP_RESET_WDT,
+};
+
+/**
+ * struct power_supply_charger - power supply charger driver
+ * @get_property: get property function to retrieve charger properties defined
+ *	in enum power_supply_charger_property
+ * @set_property: get property function to retrieve charger properties defined
+ *	in enum power_supply_charger_property
+ *
+ * This structure is used by charger drivers to register with power supply
+ * charging driver
+ */
+
+struct power_supply_charger {
+	int (*get_property)(struct power_supply_charger *psyc,
+			    enum psy_charger_control_property pspc,
+			    union power_supply_propval *val);
+	int (*set_property)(struct power_supply_charger *psyc,
+			    enum psy_charger_control_property pspc,
+			    const union power_supply_propval *val);
+};
+
 struct power_supply {
 	const char *name;
 	enum power_supply_type type;
@@ -200,6 +226,8 @@ struct power_supply {
 	void (*external_power_changed)(struct power_supply *psy);
 	void (*set_charged)(struct power_supply *psy);
 
+	struct power_supply_charger *psy_charger;
+
 	/*
 	 * Set if thermal zone should not be created for this power supply.
 	 * For example for virtual supplies forwarding calls to actual
-- 
1.7.9.5
