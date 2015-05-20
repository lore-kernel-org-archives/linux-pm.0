From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 05/16] thermal: Add comment explaining test for critical temperature
Date: Wed, 20 May 2015 15:20:35 +0200
Message-ID: <1432128046-12921-6-git-send-email-s.hauer@pengutronix.de>
References: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

The code testing if a temperature should be emulated or not is
not obvious. Add a comment explaining why this test is done.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/thermal/thermal_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3e0fe55..e204deb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -435,6 +435,11 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
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
