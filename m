From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 01/13] power: bq24257: Add bit definition for temp sense enable
Date: Mon, 31 Aug 2015 21:10:23 -0500
Message-ID: <1441073435-12349-2-git-send-email-dannenberg@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37565 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317AbbIACLU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 22:11:20 -0400
In-Reply-To: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

Adding a missing bit definition for the sake of consistency device model
vs. bit field representation. No change in functionality.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 5859bc7..db81356 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -47,7 +47,7 @@ enum bq24257_fields {
 	F_VBAT, F_USB_DET,					    /* REG 3 */
 	F_ICHG, F_ITERM,					    /* REG 4 */
 	F_LOOP_STATUS, F_LOW_CHG, F_DPDM_EN, F_CE_STATUS, F_VINDPM, /* REG 5 */
-	F_X2_TMR_EN, F_TMR, F_SYSOFF, F_TS_STAT,		    /* REG 6 */
+	F_X2_TMR_EN, F_TMR, F_SYSOFF, F_TS_EN, F_TS_STAT,	    /* REG 6 */
 	F_VOVP, F_CLR_VDP, F_FORCE_BATDET, F_FORCE_PTM,		    /* REG 7 */
 
 	F_MAX_FIELDS
@@ -135,6 +135,7 @@ static const struct reg_field bq24257_reg_fields[] = {
 	[F_X2_TMR_EN]		= REG_FIELD(BQ24257_REG_6, 7, 7),
 	[F_TMR]			= REG_FIELD(BQ24257_REG_6, 5, 6),
 	[F_SYSOFF]		= REG_FIELD(BQ24257_REG_6, 4, 4),
+	[F_TS_EN]		= REG_FIELD(BQ24257_REG_6, 3, 3),
 	[F_TS_STAT]		= REG_FIELD(BQ24257_REG_6, 0, 2),
 	/* REG 7 */
 	[F_VOVP]		= REG_FIELD(BQ24257_REG_7, 5, 7),
-- 
1.9.1

