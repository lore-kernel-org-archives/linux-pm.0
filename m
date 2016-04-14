From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 04/11] thermal: core: export apis to get slope and offset
Date: Thu, 14 Apr 2016 15:01:52 +0530
Message-ID: <1460626319-14516-5-git-send-email-rnayak@codeaurora.org>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35122 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbcDNJcd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2016 05:32:33 -0400
In-Reply-To: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com, Rajendra Nayak <rnayak@codeaurora.org>

Add apis for platform thermal drivers to query for slope and offset
attributes, which might be needed for temperature calculations.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/thermal/thermal_core.c | 16 ++++++++++++++++
 include/linux/thermal.h        |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d4b5465..7d72aad 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -2065,6 +2065,22 @@ exit:
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
 
+int thermal_zone_get_slope(struct thermal_zone_device *tz)
+{
+	if (tz && tz->tzp)
+		return tz->tzp->slope;
+	return 1;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_slope);
+
+int thermal_zone_get_offset(struct thermal_zone_device *tz)
+{
+	if (tz && tz->tzp)
+		return tz->tzp->offset;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
+
 #ifdef CONFIG_NET
 static const struct genl_multicast_group thermal_event_mcgrps[] = {
 	{ .name = THERMAL_GENL_MCAST_GROUP_NAME, },
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a55d052..84be6a9 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -432,6 +432,8 @@ thermal_of_cooling_device_register(struct device_node *np, char *, void *,
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
+int thermal_zone_get_slope(struct thermal_zone_device *tz);
+int thermal_zone_get_offset(struct thermal_zone_device *tz);
 
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
@@ -489,6 +491,12 @@ static inline struct thermal_zone_device *thermal_zone_get_zone_by_name(
 static inline int thermal_zone_get_temp(
 		struct thermal_zone_device *tz, int *temp)
 { return -ENODEV; }
+static inline int thermal_zone_get_slope(
+		struct thermal_zone_device *tz)
+{ return -ENODEV; }
+static inline int thermal_zone_get_offset(
+		struct thermal_zone_device *tz)
+{ return -ENODEV; }
 static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
 { return -ENODEV; }
 static inline struct thermal_instance *
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

