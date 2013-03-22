From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 1/2] thermal: kirkwood: Fix thermal sensor formula
Date: Fri, 22 Mar 2013 09:23:02 -0300
Message-ID: <1363954983-30822-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363954983-30822-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58728 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab3CVMYW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 08:24:22 -0400
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
 drivers/thermal/kirkwood_thermal.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index 65cb4f0..84b331f 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -49,13 +49,13 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
 	}
 
 	/*
-	 * Calculate temperature. See Section 8.10.1 of the 88AP510,
-	 * datasheet, which has the same sensor.
-	 * Documentation/arm/Marvell/README
+	 * Calculate temperature. According to Marvell internal
+	 * documentation the formula for this is:
+	 * Celsius = (322-reg)/1.3625
 	 */
 	reg = (reg >> KIRKWOOD_THERMAL_TEMP_OFFSET) &
 		KIRKWOOD_THERMAL_TEMP_MASK;
-	*temp = ((2281638UL - (7298*reg)) / 10);
+	*temp = ((3220000000UL - (10000000UL * reg)) / 13625);
 
 	return 0;
 }
-- 
1.7.8.6

