From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 05/16] thermal: mvebu: Fix valid check for thermal register
Date: Wed, 20 Mar 2013 19:36:26 -0300
Message-ID: <1363818997-23137-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50574 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab3CTWhE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Mar 2013 18:37:04 -0400
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The correct value is obtain by first shifting the register by the offset,
later applying the valid mask and finally invert the result.
This check was lacking an extra parenthesis to be strictly correct.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index d54f90c..ef04e4e 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -41,8 +41,8 @@ static int mvebu_get_temp(struct thermal_zone_device *thermal,
 	reg = readl_relaxed(priv->sensor);
 
 	/* Valid check */
-	if (!(reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
-	    KIRKWOOD_THERMAL_VALID_MASK) {
+	if (!((reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
+	    KIRKWOOD_THERMAL_VALID_MASK)) {
 		dev_err(&thermal->device,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
-- 
1.7.8.6

