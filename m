From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel_pch_thermal: Add an ACPI passive trip
Date: Mon,  3 Oct 2016 12:36:24 -0700
Message-ID: <1475523384-64659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:64494 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbcJCTg0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Oct 2016 15:36:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On the platforms which has an ACPI companion device associated with
PCH thermal device, read passive trip temperature via ACPI _PSV
control method.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel_pch_thermal.c | 51 +++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index b19cecc2..19bf202 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/acpi.h>
 #include <linux/thermal.h>
 #include <linux/pm.h>
 
@@ -68,9 +69,53 @@ struct pch_thermal_device {
 	unsigned long crt_temp;
 	int hot_trip_id;
 	unsigned long hot_temp;
+	int psv_trip_id;
+	unsigned long psv_temp;
 	bool bios_enabled;
 };
 
+#ifdef CONFIG_ACPI
+
+/*
+ * On some platforms, there is a companion ACPI device, which adds
+ * passive trip temperature using _PSV method. There is no specific
+ * passive temperature setting in MMIO interface of this PCI device.
+ */
+static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
+				      int *nr_trips)
+{
+	struct acpi_device *adev;
+
+	ptd->psv_trip_id = -1;
+
+	adev = ACPI_COMPANION(&ptd->pdev->dev);
+	if (adev) {
+		unsigned long long r;
+		acpi_status status;
+
+		status = acpi_evaluate_integer(adev->handle, "_PSV", NULL,
+					       &r);
+		if (ACPI_SUCCESS(status)) {
+			unsigned long trip_temp;
+
+			trip_temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+			if (trip_temp) {
+				ptd->psv_temp = trip_temp;
+				ptd->psv_trip_id = *nr_trips;
+				++(*nr_trips);
+			}
+		}
+	}
+}
+#else
+static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
+				      int *nr_trips)
+{
+	ptd->psv_trip_id = -1;
+
+}
+#endif
+
 static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)
 {
 	u8 tsel;
@@ -121,6 +166,8 @@ read_trips:
 		++(*nr_trips);
 	}
 
+	pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
+
 	return 0;
 }
 
@@ -196,6 +243,8 @@ static int pch_get_trip_type(struct thermal_zone_device *tzd, int trip,
 		*type = THERMAL_TRIP_CRITICAL;
 	else if (ptd->hot_trip_id == trip)
 		*type = THERMAL_TRIP_HOT;
+	else if (ptd->psv_trip_id == trip)
+		*type = THERMAL_TRIP_PASSIVE;
 	else
 		return -EINVAL;
 
@@ -210,6 +259,8 @@ static int pch_get_trip_temp(struct thermal_zone_device *tzd, int trip, int *tem
 		*temp = ptd->crt_temp;
 	else if (ptd->hot_trip_id == trip)
 		*temp = ptd->hot_temp;
+	else if (ptd->psv_trip_id == trip)
+		*temp = ptd->psv_temp;
 	else
 		return -EINVAL;
 
-- 
2.7.4

