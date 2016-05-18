From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH] thermal: add the note for set_trip_temp
Date: Wed, 18 May 2016 23:01:39 +0800
Message-ID: <1463583699-31020-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34703 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932607AbcERPCD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 11:02:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Fixes commit 60f9ce3ada53
("thermal: of-thermal: allow setting trip_temp on hardware")

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org

---

 include/linux/thermal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45abe7..ee517be 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -335,6 +335,8 @@ struct thermal_genl_event {
  * @get_trend: a pointer to a function that reads the sensor temperature trend.
  * @set_emul_temp: a pointer to a function that sets sensor emulated
  *		   temperature.
+ * @set_trip_temp: a pointer to a function that sets the trip temperature on
+ *		   hardware.
  */
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
-- 
2.7.4

