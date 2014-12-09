From: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
Subject: [PATCH 2/2] Thermal/int340x: Handle properly the case when _trt or _art acpi entry is missing
Date: Mon,  8 Dec 2014 18:01:32 -0800
Message-ID: <1418090492-87508-3-git-send-email-ilkka.koskinen@linux.intel.com>
References: <1418090492-87508-1-git-send-email-ilkka.koskinen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:55255 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbaLICEr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Dec 2014 21:04:47 -0500
In-Reply-To: <1418090492-87508-1-git-send-email-ilkka.koskinen@linux.intel.com>
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
index e4e61b3..ee4ed3b 100644
--- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
@@ -82,7 +82,7 @@ int acpi_parse_trt(acpi_handle handle, int *trt_count, struct trt **trtp,
 	struct acpi_buffer trt_format = { sizeof("RRNNNNNN"), "RRNNNNNN" };
 
 	if (!acpi_has_method(handle, "_TRT"))
-		return 0;
+		return -EEXIST;
 
 	status = acpi_evaluate_object(handle, "_TRT", NULL, &buffer);
 	if (ACPI_FAILURE(status))
@@ -167,7 +167,7 @@ int acpi_parse_art(acpi_handle handle, int *art_count, struct art **artp,
 		sizeof("RRNNNNNNNNNNN"), "RRNNNNNNNNNNN" };
 
 	if (!acpi_has_method(handle, "_ART"))
-		return 0;
+		return -EEXIST;
 
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

