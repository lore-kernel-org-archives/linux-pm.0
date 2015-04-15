From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH] thermal: armada: Update Armada 380 thermal sensor coefficients
Date: Wed, 15 Apr 2015 19:08:08 +0200
Message-ID: <1429117688-27100-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41646 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753753AbbDORIP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2015 13:08:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, stable@vger.kernel.org

From: Nadav Haklai <nadavh@marvell.com>

Improve the Armada 380 thermal sensor accuracy by using updated formula.
The updated formula is:
Temperature[C degrees] = 0.4761 * tsen_vsen_out - 279.1

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: <stable@vger.kernel.org> #v3.16
---
 drivers/thermal/armada_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2556cf5186b..01255fd65135 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -224,9 +224,9 @@ static const struct armada_thermal_data armada380_data = {
 	.is_valid_shift = 10,
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
-	.coef_b = 1169498786UL,
-	.coef_m = 2000000UL,
-	.coef_div = 4289,
+	.coef_b = 2931108200UL,
+	.coef_m = 5000000UL,
+	.coef_div = 10502,
 	.inverted = true,
 };
 
-- 
2.1.0

