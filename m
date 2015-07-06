From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/4] thermal: Add comment explaining test for critical temperature
Date: Mon,  6 Jul 2015 09:46:17 +0200
Message-ID: <1436168777-10463-5-git-send-email-s.hauer@pengutronix.de>
References: <1436168777-10463-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58968 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbbGFHqh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 03:46:37 -0400
In-Reply-To: <1436168777-10463-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

The code testing if a temperature should be emulated or not is
not obvious. Add a comment explaining why this test is done.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/thermal/thermal_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 67296da..956684e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -498,6 +498,11 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
 			}
 		}
 
+		/*
+		 * Only allow emulating a temperature when the real temperature
+		 * is below the critical temperature so that the emulation code
+		 * cannot hide critical conditions.
+		 */
 		if (!ret && *temp < crit_temp)
 			*temp = tz->emul_temperature;
 	}
-- 
2.1.4

