From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] thermal: Do not log an error if thermal_zone_get_temp returns -EAGAIN
Date: Tue, 10 Mar 2015 16:06:46 +0100
Message-ID: <1426000006-15729-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617AbbCJPHB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 Mar 2015 11:07:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Some temperature sensors only get updated every few seconds and while
waiting for the first irq reporting a (new) temperature to happen there
get_temp operand will return -EAGAIN as it does not have any data to report
yet.

Not logging an error in this case avoids messages like these from showing
up in dmesg on affected systems:

[    1.219353] thermal thermal_zone0: failed to read out thermal zone 0
[    2.015433] thermal thermal_zone0: failed to read out thermal zone 0
[    2.416737] thermal thermal_zone0: failed to read out thermal zone 0

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/thermal/thermal_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 48491d1..e3cbf34 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -458,8 +458,10 @@ static void update_temperature(struct thermal_zone_device *tz)
 
 	ret = thermal_zone_get_temp(tz, &temp);
 	if (ret) {
-		dev_warn(&tz->device, "failed to read out thermal zone %d\n",
-			 tz->id);
+		if (ret != -EAGAIN)
+			dev_warn(&tz->device,
+				 "failed to read out thermal zone %d\n",
+				 tz->id);
 		return;
 	}
 
-- 
2.3.1

