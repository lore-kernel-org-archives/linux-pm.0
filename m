From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] thermal: power_allocator: do not use devm* interfaces
Date: Tue, 4 Aug 2015 09:33:40 -0700
Message-ID: <20150804163340.GA33245@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36685 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbbHDQdo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 12:33:44 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Lukasz Majewski <l.majewski@samsung.com>, Peter Feuerer <peter@piie.net>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The code in question is called outside of standard driver
probe()/remove() callbacks and thus will not benefit from use of devm*
infrastructure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/thermal/power_allocator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 13ccf00..e9ba29f 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -334,7 +334,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 				      max_allocatable_power, current_temp,
 				      control_temp - current_temp);
 
-	devm_kfree(&tz->device, req_power);
+	kfree(req_power);
 unlock:
 	mutex_unlock(&tz->lock);
 
@@ -426,7 +426,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		return -EINVAL;
 	}
 
-	params = devm_kzalloc(&tz->device, sizeof(*params), GFP_KERNEL);
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
 	if (!params)
 		return -ENOMEM;
 
@@ -468,14 +468,14 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	return 0;
 
 free:
-	devm_kfree(&tz->device, params);
+	kfree(params);
 	return ret;
 }
 
 static void power_allocator_unbind(struct thermal_zone_device *tz)
 {
 	dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
-	devm_kfree(&tz->device, tz->governor_data);
+	kfree(tz->governor_data);
 	tz->governor_data = NULL;
 }
 
-- 
2.5.0.rc2.392.g76e840b


-- 
Dmitry
