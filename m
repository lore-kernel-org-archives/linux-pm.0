From: Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] thermal: core: fix some format issues on critical shutdown string
Date: Sun, 23 Jul 2017 22:21:49 +0800
Message-ID: <20170723142149.43869-1-icenowy@aosc.io>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:37043 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751365AbdGWOWC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Jul 2017 10:22:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>

The critical shutdown notice string used to have some spaces missing,
which makes it not so pretty.

Add the spaces to satisfy usual English space rules.

Reported-by: Mingcong Bai <jeffbai@aosc.io>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5a51c740e372..671e4d15599d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -390,7 +390,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 
 	if (trip_type == THERMAL_TRIP_CRITICAL) {
 		dev_emerg(&tz->device,
-			  "critical temperature reached(%d C),shutting down\n",
+			  "critical temperature reached (%d C), shutting down\n",
 			  tz->temperature / 1000);
 		mutex_lock(&poweroff_lock);
 		if (!power_off_triggered) {
-- 
2.13.0
