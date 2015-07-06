From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/4] thermal: trivial: fix typo in comment
Date: Mon,  6 Jul 2015 09:46:14 +0200
Message-ID: <1436168777-10463-2-git-send-email-s.hauer@pengutronix.de>
References: <1436168777-10463-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436168777-10463-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 04659bf..34ce9e4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -465,7 +465,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 }
 
 /**
- * thermal_zone_get_temp() - returns its the temperature of thermal zone
+ * thermal_zone_get_temp() - returns the temperature of a thermal zone
  * @tz: a valid pointer to a struct thermal_zone_device
  * @temp: a valid pointer to where to store the resulting temperature.
  *
-- 
2.1.4
