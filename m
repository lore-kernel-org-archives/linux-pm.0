From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 2/2] thermal: dove: Fix thermal sensor formula
Date: Fri, 22 Mar 2013 09:23:03 -0300
Message-ID: <1363954983-30822-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363954983-30822-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58739 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab3CVMY0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 08:24:26 -0400
In-Reply-To: <1363954983-30822-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The currently formula has been taken from the 88AP510 SoC datasheet,
which is not exactly correct. The correct value for the temperature
in Celcius of the sensor present in this SoC is:

  Celsius = (322-reg)/1.3625

Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Tested by compilation only.

 drivers/thermal/dove_thermal.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 7b0bfa0..ddd73a5 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -107,12 +107,13 @@ static int dove_get_temp(struct thermal_zone_device *thermal,
 	}
 
 	/*
-	 * Calculate temperature. See Section 8.10.1 of 88AP510,
-	 * Documentation/arm/Marvell/README
+	 * Calculate temperature. According to Marvell internal
+	 * documentation the formula for this is:
+	 * Celsius = (322-reg)/1.3625
 	 */
 	reg = readl_relaxed(priv->sensor);
 	reg = (reg >> DOVE_THERMAL_TEMP_OFFSET) & DOVE_THERMAL_TEMP_MASK;
-	*temp = ((2281638UL - (7298*reg)) / 10);
+	*temp = ((3220000000UL - (10000000UL * reg)) / 13625);
 
 	return 0;
 }
-- 
1.7.8.6

