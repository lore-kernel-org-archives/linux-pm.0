From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0126/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:42:38 +0800
Message-ID: <20160802104238.22151-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:61387 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934716AbcHBMWX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 08:22:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org, jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com, hpa@zytor.com, x86@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, jslaby@suse.cz, peter@korsgaard.com, lee.jones@linaro.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/cpuidle/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 832a2c3..8ad34d4 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -115,8 +115,8 @@ static ssize_t store_current_governor(struct device *dev,
 		return count;
 }
 
-static DEVICE_ATTR(current_driver, 0444, show_current_driver, NULL);
-static DEVICE_ATTR(current_governor_ro, 0444, show_current_governor, NULL);
+static DEVICE_ATTR(current_driver, S_IRUSR | S_IRGRP | S_IROTH, show_current_driver, NULL);
+static DEVICE_ATTR(current_governor_ro, S_IRUSR | S_IRGRP | S_IROTH, show_current_governor, NULL);
 
 static struct attribute *cpuidle_default_attrs[] = {
 	&dev_attr_current_driver.attr,
@@ -124,8 +124,8 @@ static struct attribute *cpuidle_default_attrs[] = {
 	NULL
 };
 
-static DEVICE_ATTR(available_governors, 0444, show_available_governors, NULL);
-static DEVICE_ATTR(current_governor, 0644, show_current_governor,
+static DEVICE_ATTR(available_governors, S_IRUSR | S_IRGRP | S_IROTH, show_available_governors, NULL);
+static DEVICE_ATTR(current_governor, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, show_current_governor,
 		   store_current_governor);
 
 static struct attribute *cpuidle_switch_attrs[] = {
-- 
2.9.2

