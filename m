From: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
Subject: [PATCH v2 2/2] Thermal/int340x: Handle properly the case when _trt or _art acpi entry is missing
Date: Tue,  9 Dec 2014 12:34:03 -0800
Message-ID: <1418157243-6849-1-git-send-email-ilkka.koskinen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41337 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbaLIUhO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Dec 2014 15:37:14 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: ilkka.koskinen@linux.intel.com, rui.zhang@intel.com, edubezval@gmail.com, jacob.jun.pan@linux.intel.com

If either of the entries was missing, the driver tried to free memory
using uninitialized pointer. In addition, it was dereferencing null
pointer.

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
index e4e61b3..231cabc 100644
--- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
@@ -82,7 +82,7 @@ int acpi_parse_trt(acpi_handle handle, int *trt_count, struct trt **trtp,
 	struct acpi_buffer trt_format = { sizeof("RRNNNNNN"), "RRNNNNNN" };
 
 	if (!acpi_has_method(handle, "_TRT"))
-		return 0;
+		return -ENODEV;
 
 	status = acpi_evaluate_object(handle, "_TRT", NULL, &buffer);
 	if (ACPI_FAILURE(status))
@@ -167,7 +167,7 @@ int acpi_parse_art(acpi_handle handle, int *art_count, struct art **artp,
 		sizeof("RRNNNNNNNNNNN"), "RRNNNNNNNNNNN" };
 
 	if (!acpi_has_method(handle, "_ART"))
-		return 0;
+		return -ENODEV;
 
 	status = acpi_evaluate_object(handle, "_ART", NULL, &buffer);
 	if (ACPI_FAILURE(status))
@@ -321,8 +321,8 @@ static long acpi_thermal_rel_ioctl(struct file *f, unsigned int cmd,
 	unsigned long length = 0;
 	int count = 0;
 	char __user *arg = (void __user *)__arg;
-	struct trt *trts;
-	struct art *arts;
+	struct trt *trts = NULL;
+	struct art *arts = NULL;
 
 	switch (cmd) {
 	case ACPI_THERMAL_GET_TRT_COUNT:
-- 
1.9.1

