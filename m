From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RESEND PATCH 1/3] power: charger-manager: Replace deprecatd API of
 extcon
Date: Fri, 15 Apr 2016 09:43:34 +0900
Message-ID: <1460681016-2770-2-git-send-email-cw00.choi@samsung.com>
References: <1460681016-2770-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1460681016-2770-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch removes the deprecated notifier API of extcon framework and then use
the new extcon API[2] with the unique id[1] to indicate the each external
connector. Alter deprecated API as following:
- extcon_register_interest() -> extcon_register_notifier()
- extcon_unregister_interest() -> extcon_unregister_notifier()

And, extcon alters the name of USB charger connector in patch[3] as following:
- EXTCON_CHG_USB_SDP /* Standard Downstream Port */
- EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
- EXTCON_CHG_USB_CDP /* Charging Downstream Port */
- EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */

So, the name of external charger connector are changed as following:
- "USB" -> "SDP"
- "TA" -> "DCP"

[1] Commit 2a9de9c0f08d61
- ("extcon: Use the unique id for external connector instead of string)
[2] Commit 046050f6e623e4
- ("extcon: Update the prototype of extcon_register_notifier() with enum extcon
[3] Commit 11eecf910bd81d
- ("extcon: Modify the id and name of external connector")

Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 .../bindings/power_supply/charger-manager.txt      |  4 +--
 drivers/power/charger-manager.c                    | 31 ++++++++++++++--------
 include/linux/power/charger-manager.h              |  4 +--
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/power_supply/charger-manager.txt b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
index ec4fe9de3137..73193e380dc2 100644
--- a/Documentation/devicetree/bindings/power_supply/charger-manager.txt
+++ b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
@@ -65,13 +65,13 @@ Example :
 		regulator@0 {
 			cm-regulator-name = "chg-reg";
 			cable@0 {
-				cm-cable-name = "USB";
+				cm-cable-id = 5; /* EXTCON_CHG_USB_SDP */
 				cm-cable-extcon = "extcon-dev.0";
 				cm-cable-min = <475000>;
 				cm-cable-max = <500000>;
 			};
 			cable@1 {
-				cm-cable-name = "TA";
+				cm-cable-id = 6; /* EXTCON_CHG_USB_DCP */
 				cm-cable-extcon = "extcon-dev.0";
 				cm-cable-min = <650000>;
 				cm-cable-max = <675000>;
diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index e664ca7c0afd..ed63dc086eb6 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1137,8 +1137,8 @@ static void charger_extcon_work(struct work_struct *work)
 		ret = regulator_set_current_limit(cable->charger->consumer,
 					cable->min_uA, cable->max_uA);
 		if (ret < 0) {
-			pr_err("Cannot set current limit of %s (%s)\n",
-			       cable->charger->regulator_name, cable->name);
+			pr_err("Cannot set current limit of %s (%d)\n",
+			       cable->charger->regulator_name, cable->id);
 			return;
 		}
 
@@ -1207,11 +1207,18 @@ static int charger_extcon_init(struct charger_manager *cm,
 	 */
 	INIT_WORK(&cable->wq, charger_extcon_work);
 	cable->nb.notifier_call = charger_extcon_notifier;
-	ret = extcon_register_interest(&cable->extcon_dev,
-			cable->extcon_name, cable->name, &cable->nb);
+
+	cable->extcon_dev = extcon_get_extcon_dev(cable->extcon_name);
+	if (IS_ERR(cable->extcon_dev)) {
+		pr_err("Cannot get extcon_dev for %s\n", cable->extcon_name);
+		return PTR_ERR(cable->extcon_dev);
+	}
+
+	ret = extcon_register_notifier(cable->extcon_dev, cable->id,
+			&cable->nb);
 	if (ret < 0) {
-		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
-			cable->extcon_name, cable->name);
+		pr_info("Cannot register extcon_dev for %s(cable: %d)\n",
+			cable->extcon_name, cable->id);
 		ret = -EINVAL;
 	}
 
@@ -1589,8 +1596,8 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 				chg_regs->cables = cables;
 
 				for_each_child_of_node(child, _child) {
-					of_property_read_string(_child,
-					"cm-cable-name", &cables->name);
+					of_property_read_u32(_child,
+					"cm-cable-id", &cables->id);
 					of_property_read_string(_child,
 					"cm-cable-extcon",
 					&cables->extcon_name);
@@ -1833,8 +1840,9 @@ err_reg_extcon:
 		for (j = 0; j < charger->num_cables; j++) {
 			struct charger_cable *cable = &charger->cables[j];
 			/* Remove notifier block if only edev exists */
-			if (cable->extcon_dev.edev)
-				extcon_unregister_interest(&cable->extcon_dev);
+			if (cable->extcon_dev)
+				extcon_unregister_notifier(cable->extcon_dev,
+						cable->id, &cable->nb);
 		}
 
 		regulator_put(desc->charger_regulators[i].consumer);
@@ -1865,7 +1873,8 @@ static int charger_manager_remove(struct platform_device *pdev)
 				= &desc->charger_regulators[i];
 		for (j = 0 ; j < charger->num_cables ; j++) {
 			struct charger_cable *cable = &charger->cables[j];
-			extcon_unregister_interest(&cable->extcon_dev);
+			extcon_unregister_notifier(cable->extcon_dev,
+						cable->id, &cable->nb);
 		}
 	}
 
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index c4fa907c8f14..b3404bb825d6 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -63,10 +63,10 @@ enum cm_event_types {
  */
 struct charger_cable {
 	const char *extcon_name;
-	const char *name;
+	unsigned int id;
 
 	/* The charger-manager use Extcon framework */
-	struct extcon_specific_cable_nb extcon_dev;
+	struct extcon_dev *extcon_dev;
 	struct work_struct wq;
 	struct notifier_block nb;
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
