From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 3/4] power: supply: power_supply_core: add
 constant-charge-current optional property
Date: Thu, 11 May 2017 15:42:19 +0200
Message-ID: <20170511134221.5569-4-quentin.schulz@free-electrons.com>
References: <20170511134221.5569-1-quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBUOU2HEAKGQEMUBGPBI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170511134221.5569-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This adds the constant-charge-current property to the list of optional
properties for the battery.

The constant charge current is critical for batteries as they can't
handle all charge currents.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/power/supply/power_supply_core.c | 3 +++
 include/linux/power_supply.h             | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 5019bdee0f0b..23887739c95c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -508,6 +508,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->energy_full_design_uwh = -EINVAL;
 	info->charge_full_design_uah = -EINVAL;
 	info->voltage_min_design_uv  = -EINVAL;
+	info->constant_charge_current_max_ua  = -EINVAL;
 
 	if (!psy->of_node) {
 		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
@@ -537,6 +538,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->charge_full_design_uah);
 	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
 			     &info->voltage_min_design_uv);
+	of_property_read_u32(battery_np, "constant-charge-current-max-microamp",
+			     &info->constant_charge_current_max_ua);
 
 	return 0;
 }
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e84f1d31d987..6f9c28187caf 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -301,6 +301,7 @@ struct power_supply_battery_info {
 	int energy_full_design_uwh;	/* microWatt-hours */
 	int charge_full_design_uah;	/* microAmp-hours */
 	int voltage_min_design_uv;	/* microVolts */
+	int constant_charge_current_max_ua;		/* microAmps */
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
-- 
2.11.0
