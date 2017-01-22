From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH v4 3/8] power: power_supply: add battery information struct
Date: Sat, 21 Jan 2017 23:13:59 -0800
Message-ID: <20170122071404.9654-4-matt@ranostay.consulting>
References: <20170122071404.9654-1-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170122071404.9654-1-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add power_supply_battery_info structure that is used to
enumerate battery state machine settings.

Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
---
 include/linux/power_supply.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3965503315ef..59674a257d5e 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -288,6 +288,18 @@ struct power_supply_info {
 	int use_for_apm;
 };
 
+/*
+ * This is the recommended struct to specify static battery parameters.
+ * Power supply class itself doesn't use this, but it implements access
+ * that most platform drivers should use for consistency.
+ */
+
+struct power_supply_battery_info {
+	int energy;		/* uWh */
+	int power;		/* uAh */
+	int nominal_voltage;	/* uV */
+};
+
 extern struct atomic_notifier_head power_supply_notifier;
 extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
