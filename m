From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 10/49] thermal: core: remove useless empty line
Date: Mon,  7 Nov 2016 21:08:48 -0800
Message-ID: <1478581767-7009-11-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36814 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbcKHFWP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:22:15 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Fix style problem on create_trip_attrs();

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e8098f6..122eba7 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1833,7 +1833,6 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 	}
 
-
 	for (indx = 0; indx < tz->trips; indx++) {
 		/* create trip type attribute */
 		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
-- 
2.1.4

