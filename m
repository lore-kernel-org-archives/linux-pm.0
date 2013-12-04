From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] PowerCap: Fix mode for energy counter
Date: Wed,  4 Dec 2013 11:12:59 -0800
Message-ID: <1386184379-26220-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51667 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756036Ab3LDTOj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Dec 2013 14:14:39 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

As per the documentation of powercap sysfs, energy_uj field is read only,
if it can't be reset. Currently it always allows write but will fail,
if there is no reset callback.
Changing mode field, to read only if there is no reset callback.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reported-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/powercap/powercap_sys.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 8d0fe43..84419af 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -377,9 +377,14 @@ static void create_power_zone_common_attributes(
 	if (power_zone->ops->get_max_energy_range_uj)
 		power_zone->zone_dev_attrs[count++] =
 					&dev_attr_max_energy_range_uj.attr;
-	if (power_zone->ops->get_energy_uj)
+	if (power_zone->ops->get_energy_uj) {
+		if (power_zone->ops->reset_energy_uj)
+			dev_attr_energy_uj.attr.mode = S_IWUSR | S_IRUGO;
+		else
+			dev_attr_energy_uj.attr.mode = S_IRUGO;
 		power_zone->zone_dev_attrs[count++] =
 					&dev_attr_energy_uj.attr;
+	}
 	if (power_zone->ops->get_power_uw)
 		power_zone->zone_dev_attrs[count++] =
 					&dev_attr_power_uw.attr;
-- 
1.8.3.1

