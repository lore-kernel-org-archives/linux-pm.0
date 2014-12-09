From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI / Fan: Use bus id for INT3404 Fan
Date: Tue,  9 Dec 2014 12:53:05 -0800
Message-ID: <1418158385-5070-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31713 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbaLIUxp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Dec 2014 15:53:45 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The ART table refers to actual bus id name for specifying relationship.
Naming "Fan" is not enough as name in the ART table can change on every
platform.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/fan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index caf9b76..c9213bc 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -325,6 +325,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	struct thermal_cooling_device *cdev;
 	struct acpi_fan *fan;
 	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	char *name;
 
 	fan = devm_kzalloc(&pdev->dev, sizeof(*fan), GFP_KERNEL);
 	if (!fan) {
@@ -346,7 +347,12 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		}
 	}
 
-	cdev = thermal_cooling_device_register("Fan", device,
+	if (!strncmp(pdev->name, "INT3404", strlen("INT3404")))
+		name = acpi_device_bid(device);
+	else
+		name = "Fan";
+
+	cdev = thermal_cooling_device_register(name, device,
 						&fan_cooling_ops);
 	if (IS_ERR(cdev)) {
 		result = PTR_ERR(cdev);
-- 
1.9.1

