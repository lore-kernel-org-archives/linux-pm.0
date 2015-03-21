From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] thermal: Do not log an error if thermal_zone_get_temp returns -EAGAIN
Date: Sat, 21 Mar 2015 15:02:55 +0100
Message-ID: <1426946575-12795-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52200 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbbCUOC6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 21 Mar 2015 10:02:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

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
Changes in v2:
-log error code on thermal zone read error and stop logging the zone nr twice
---
 drivers/thermal/thermal_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 174d3bc..4108db7 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -458,8 +458,10 @@ static void update_temperature(struct thermal_zone_device *tz)
 
 	ret = thermal_zone_get_temp(tz, &temp);
 	if (ret) {
-		dev_warn(&tz->device, "failed to read out thermal zone %d\n",
-			 tz->id);
+		if (ret != -EAGAIN)
+			dev_warn(&tz->device,
+				 "failed to read out thermal zone (%d)\n",
+				 ret);
 		return;
 	}
 
-- 
2.3.3

