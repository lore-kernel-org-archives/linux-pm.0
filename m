From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH] thermal: armada: Fix possible overflow in the Armada 380 thermal sensor formula
Date: Thu,  6 Aug 2015 18:03:49 +0200
Message-ID: <1438877029-32514-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38685 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754313AbbHFQEA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2015 12:04:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>

From: Nadav Haklai <nadavh@marvell.com>

Update the coefficients so the calculation will not overrun the
unsigned long 32bits boundary

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Reviewed-by: Victor Axelrod <victora@marvell.com>
Reviewed-by: Neta Zur Hershkovits <neta@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 01255fd65135..363bf91c32a3 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -224,9 +224,9 @@ static const struct armada_thermal_data armada380_data = {
 	.is_valid_shift = 10,
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
-	.coef_b = 2931108200UL,
-	.coef_m = 5000000UL,
-	.coef_div = 10502,
+	.coef_b = 1172499100UL,
+	.coef_m = 2000096UL,
+	.coef_div = 4201,
 	.inverted = true,
 };
 
-- 
2.1.0

