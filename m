From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 1/2] thermal: introduce thermal_zone_get_zone_by_node helper function
Date: Thu, 9 Jan 2014 18:37:58 +0800
Message-ID: <1389263879-10483-2-git-send-email-wni@nvidia.com>
References: <1389263879-10483-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9756 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaAIKht (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 05:37:49 -0500
In-Reply-To: <1389263879-10483-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: eduardo.valentin@ti.com, rui.zhang@intel.com, mark.rutland@arm.com, durgadoss.r@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, Wei Ni <wni@nvidia.com>

The thermal framework start to support device tree, this
patch adds a helper function to get a reference of a
thermal zone, based on the zone's device node.

It will add a device_node *np member in the struct
thermal_zone_device, and initialize it when create a thermal
zone. This funciton perform a zone device node lookup and
return a reference to a thermal zone device that matches
the device node requested.
In case the zone is not found or if the required parameters
are invalid, it will return the corresponding error code (ERR_PTR).

Change-Id: I4d65f849e84425dddd387f70886a9c7c4c2002f2
Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/of-thermal.c   |    2 ++
 drivers/thermal/thermal_core.c |   33 +++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |    3 +++
 3 files changed, 38 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 04b1be7..53f2d3a 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -804,6 +804,8 @@ int __init of_parse_thermal_zones(void)
 			of_thermal_free_zone(tz);
 			/* attempting to build remaining zones still */
 		}
+
+		zone->np = child;
 	}
 
 	return 0;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 338a88b..eeddb94 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1672,6 +1672,39 @@ exit:
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
 
+/**
+* thermal_zone_get_zone_by_node() - search for a zone and returns its ref
+* @node: device node of the thermal zone
+*
+* When thermal zone is found with the passed device node, returns a reference
+* to it.
+*
+* Return: On success returns a reference to an unique thermal zone with
+* matching device node, an ERR_PTR otherwise (-EINVAL for invalid
+* paramenters, -ENODEV for not found).
+*/
+struct thermal_zone_device *
+thermal_zone_get_zone_by_node(struct device_node *node)
+{
+	struct thermal_zone_device *pos = NULL, *ref = ERR_PTR(-ENODEV);
+	bool found = false;
+
+	if (!node)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(pos, &thermal_tz_list, node)
+		if (node == pos->np) {
+			ref = pos;
+			found = true;
+			break;
+		}
+	mutex_unlock(&thermal_list_lock);
+
+	return ref;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_node);
+
 #ifdef CONFIG_NET
 static const struct genl_multicast_group thermal_event_mcgrps[] = {
 	{ .name = THERMAL_GENL_MCAST_GROUP_NAME, },
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f7e11c7..288d272 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -162,6 +162,7 @@ struct thermal_zone_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
 	struct device device;
+	struct device_node *np;
 	struct thermal_attr *trip_temp_attrs;
 	struct thermal_attr *trip_type_attrs;
 	struct thermal_attr *trip_hyst_attrs;
@@ -286,6 +287,8 @@ thermal_of_cooling_device_register(struct device_node *np, char *, void *,
 				   const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
+struct thermal_zone_device *
+thermal_zone_get_zone_by_node(struct device_node *node);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp);
 
 int get_tz_trend(struct thermal_zone_device *, int);
-- 
1.7.9.5

