From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0865/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:53:25 +0800
Message-ID: <20160802115325.7648-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:53573 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965070AbcHBMew (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 08:34:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/power/twl4030_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index bcd4dc3..03b9ee1 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -109,7 +109,7 @@ static inline int ac_available(struct iio_channel *channel_vac)
 }
 
 static bool allow_usb;
-module_param(allow_usb, bool, 0644);
+module_param(allow_usb, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(allow_usb, "Allow USB charge drawing default current");
 
 struct twl4030_bci {
@@ -707,7 +707,7 @@ static ssize_t twl4030_bci_max_current_show(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "%u\n", cur);
 }
 
-static DEVICE_ATTR(max_current, 0644, twl4030_bci_max_current_show,
+static DEVICE_ATTR(max_current, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, twl4030_bci_max_current_show,
 			twl4030_bci_max_current_store);
 
 static void twl4030_bci_usb_work(struct work_struct *data)
@@ -802,7 +802,7 @@ twl4030_bci_mode_show(struct device *dev,
 	buf[len-1] = '\n';
 	return len;
 }
-static DEVICE_ATTR(mode, 0644, twl4030_bci_mode_show,
+static DEVICE_ATTR(mode, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, twl4030_bci_mode_show,
 		   twl4030_bci_mode_store);
 
 static int twl4030_charger_get_current(void)
-- 
2.9.2

