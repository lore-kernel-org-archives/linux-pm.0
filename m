From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 08/16] thermal: mvebu: Fix temperature output formula for kirkwood
Date: Wed, 20 Mar 2013 19:36:29 -0300
Message-ID: <1363818997-23137-9-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50613 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab3CTWhS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Mar 2013 18:37:18 -0400
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The temperature formula was taken from the Armada 510 datasheet.
This is wrong because the Kirkwood SoC thermal sensor has
different coefficients.

Fix it using values from 88F682/88F683 Kirkwood datasheet.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index 5886a9c..ed4c9b0 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -48,14 +48,9 @@ static int mvebu_get_temp(struct thermal_zone_device *thermal,
 		return -EIO;
 	}
 
-	/*
-	 * Calculate temperature. See Section 8.10.1 of the 88AP510,
-	 * datasheet, which has the same sensor.
-	 * Documentation/arm/Marvell/README
-	 */
 	reg = (reg >> KIRKWOOD_THERMAL_TEMP_OFFSET) &
 		KIRKWOOD_THERMAL_TEMP_MASK;
-	*temp = ((2281638UL - (7298*reg)) / 10);
+	*temp = ((2363302UL - (7339*reg)) / 10);
 
 	return 0;
 }
-- 
1.7.8.6

