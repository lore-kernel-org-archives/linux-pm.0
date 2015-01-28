From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/4] ACPI / PMIC: Use common LPAT table handling functions
Date: Wed, 28 Jan 2015 11:56:47 -0800
Message-ID: <1422475009-20759-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1422475009-20759-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:53316 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbbA1U0H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Jan 2015 15:26:07 -0500
In-Reply-To: <1422475009-20759-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The LPAT table processing functions from this modules are moved to a
standalone module with exported interface functions.
Using new interface functions in this module.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/pmic/intel_pmic.c | 133 ++++++-----------------------------------
 1 file changed, 18 insertions(+), 115 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index a732e5d..bd772cd 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -16,20 +16,15 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/regmap.h>
+#include <acpi/acpi_lpat.h>
 #include "intel_pmic.h"
 
 #define PMIC_POWER_OPREGION_ID		0x8d
 #define PMIC_THERMAL_OPREGION_ID	0x8c
 
-struct acpi_lpat {
-	int temp;
-	int raw;
-};
-
 struct intel_pmic_opregion {
 	struct mutex lock;
-	struct acpi_lpat *lpat;
-	int lpat_count;
+	struct acpi_lpat_conversion_table *lpat_table;
 	struct regmap *regmap;
 	struct intel_pmic_opregion_data *data;
 };
@@ -50,105 +45,6 @@ static int pmic_get_reg_bit(int address, struct pmic_table *table,
 	return -ENOENT;
 }
 
-/**
- * raw_to_temp(): Return temperature from raw value through LPAT table
- *
- * @lpat: the temperature_raw mapping table
- * @count: the count of the above mapping table
- * @raw: the raw value, used as a key to get the temerature from the
- *       above mapping table
- *
- * A positive value will be returned on success, a negative errno will
- * be returned in error cases.
- */
-static int raw_to_temp(struct acpi_lpat *lpat, int count, int raw)
-{
-	int i, delta_temp, delta_raw, temp;
-
-	for (i = 0; i < count - 1; i++) {
-		if ((raw >= lpat[i].raw && raw <= lpat[i+1].raw) ||
-		    (raw <= lpat[i].raw && raw >= lpat[i+1].raw))
-			break;
-	}
-
-	if (i == count - 1)
-		return -ENOENT;
-
-	delta_temp = lpat[i+1].temp - lpat[i].temp;
-	delta_raw = lpat[i+1].raw - lpat[i].raw;
-	temp = lpat[i].temp + (raw - lpat[i].raw) * delta_temp / delta_raw;
-
-	return temp;
-}
-
-/**
- * temp_to_raw(): Return raw value from temperature through LPAT table
- *
- * @lpat: the temperature_raw mapping table
- * @count: the count of the above mapping table
- * @temp: the temperature, used as a key to get the raw value from the
- *        above mapping table
- *
- * A positive value will be returned on success, a negative errno will
- * be returned in error cases.
- */
-static int temp_to_raw(struct acpi_lpat *lpat, int count, int temp)
-{
-	int i, delta_temp, delta_raw, raw;
-
-	for (i = 0; i < count - 1; i++) {
-		if (temp >= lpat[i].temp && temp <= lpat[i+1].temp)
-			break;
-	}
-
-	if (i == count - 1)
-		return -ENOENT;
-
-	delta_temp = lpat[i+1].temp - lpat[i].temp;
-	delta_raw = lpat[i+1].raw - lpat[i].raw;
-	raw = lpat[i].raw + (temp - lpat[i].temp) * delta_raw / delta_temp;
-
-	return raw;
-}
-
-static void pmic_thermal_lpat(struct intel_pmic_opregion *opregion,
-			      acpi_handle handle, struct device *dev)
-{
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj_p, *obj_e;
-	int *lpat, i;
-	acpi_status status;
-
-	status = acpi_evaluate_object(handle, "LPAT", NULL, &buffer);
-	if (ACPI_FAILURE(status))
-		return;
-
-	obj_p = (union acpi_object *)buffer.pointer;
-	if (!obj_p || (obj_p->type != ACPI_TYPE_PACKAGE) ||
-	    (obj_p->package.count % 2) || (obj_p->package.count < 4))
-		goto out;
-
-	lpat = devm_kmalloc(dev, sizeof(int) * obj_p->package.count,
-			    GFP_KERNEL);
-	if (!lpat)
-		goto out;
-
-	for (i = 0; i < obj_p->package.count; i++) {
-		obj_e = &obj_p->package.elements[i];
-		if (obj_e->type != ACPI_TYPE_INTEGER) {
-			devm_kfree(dev, lpat);
-			goto out;
-		}
-		lpat[i] = (s64)obj_e->integer.value;
-	}
-
-	opregion->lpat = (struct acpi_lpat *)lpat;
-	opregion->lpat_count = obj_p->package.count / 2;
-
-out:
-	kfree(buffer.pointer);
-}
-
 static acpi_status intel_pmic_power_handler(u32 function,
 		acpi_physical_address address, u32 bits, u64 *value64,
 		void *handler_context, void *region_context)
@@ -192,12 +88,12 @@ static int pmic_read_temp(struct intel_pmic_opregion *opregion,
 	if (raw_temp < 0)
 		return raw_temp;
 
-	if (!opregion->lpat) {
+	if (!opregion->lpat_table) {
 		*value = raw_temp;
 		return 0;
 	}
 
-	temp = raw_to_temp(opregion->lpat, opregion->lpat_count, raw_temp);
+	temp = acpi_lpat_raw_to_temp(opregion->lpat_table, raw_temp);
 	if (temp < 0)
 		return temp;
 
@@ -223,9 +119,8 @@ static int pmic_thermal_aux(struct intel_pmic_opregion *opregion, int reg,
 	if (!opregion->data->update_aux)
 		return -ENXIO;
 
-	if (opregion->lpat) {
-		raw_temp = temp_to_raw(opregion->lpat, opregion->lpat_count,
-				       *value);
+	if (opregion->lpat_table) {
+		raw_temp = acpi_lpat_temp_to_raw(opregion->lpat_table, *value);
 		if (raw_temp < 0)
 			return raw_temp;
 	} else {
@@ -314,6 +209,7 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
 {
 	acpi_status status;
 	struct intel_pmic_opregion *opregion;
+	int ret;
 
 	if (!dev || !regmap || !d)
 		return -EINVAL;
@@ -327,14 +223,16 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
 
 	mutex_init(&opregion->lock);
 	opregion->regmap = regmap;
-	pmic_thermal_lpat(opregion, handle, dev);
+	opregion->lpat_table = acpi_lpat_get_conversion_table(handle);
 
 	status = acpi_install_address_space_handler(handle,
 						    PMIC_POWER_OPREGION_ID,
 						    intel_pmic_power_handler,
 						    NULL, opregion);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
+	if (ACPI_FAILURE(status)) {
+		ret = -ENODEV;
+		goto out_error;
+	}
 
 	status = acpi_install_address_space_handler(handle,
 						    PMIC_THERMAL_OPREGION_ID,
@@ -343,11 +241,16 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
 	if (ACPI_FAILURE(status)) {
 		acpi_remove_address_space_handler(handle, PMIC_POWER_OPREGION_ID,
 						  intel_pmic_power_handler);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_error;
 	}
 
 	opregion->data = d;
 	return 0;
+
+out_error:
+	acpi_lpat_free_conversion_table(opregion->lpat_table);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(intel_pmic_install_opregion_handler);
 
-- 
1.9.3

