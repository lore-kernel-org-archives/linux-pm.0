From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH] thermal: Fix thermal_zone_of_sensor_register to match documentation
Date: Tue,  8 Sep 2015 14:51:12 +0100
Message-ID: <1441720272-17338-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:59001 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754175AbbIHNuG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 09:50:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux@roeck-us.net, Punit Agrawal <punit.agrawal@arm.com>

thermal_zone_of_sensor_register is documented as returning a pointer
to either a valid thermal_zone_device on success, or a corresponding
ERR_PTR() value.

In contrast, the function returns NULL when THERMAL_OF is configured
off. Fix this.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---
Hi Eduardo, Rui,

This patch has been on the list without any objection for sometime [0]
 now. Could you pick this up for the next rc please?

Thanks,
Punit

[0] http://thread.gmane.org/gmane.linux.kernel/2011466/focus=2013175

 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 037e9df..f344e51 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -364,7 +364,7 @@ static inline struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
 				const struct thermal_zone_of_device_ops *ops)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline
-- 
2.5.0

