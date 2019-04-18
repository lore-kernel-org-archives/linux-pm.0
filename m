Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA9DC10F0E
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 07:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B97B21850
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 07:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfDRHPV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:15:21 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:32856 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbfDRHPU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 03:15:20 -0400
Received: from penelope.horms.nl (astrasbourg-652-1-77-110.w109-217.abo.wanadoo.fr [109.217.202.110])
        by kirsty.vergenet.net (Postfix) with ESMTPA id D9C0E25AEB1;
        Thu, 18 Apr 2019 17:15:18 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 60AC8E22049; Thu, 18 Apr 2019 09:15:15 +0200 (CEST)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH repost] thermal: rcar_thermal: update calculation formula for E3
Date:   Thu, 18 Apr 2019 09:15:14 +0200
Message-Id: <20190418071514.13027-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>

HW manual changes temperature calculation formula for E3:
- When CTEMP is less than 24
   T = CTEMP[5:0] * 5.5 - 72
- When CTEMP is equal to/greater than 24
   T = CTEMP[5:0] * 5 - 60

This was inspired by a patch in the BSP by Van Do <van.do.xw@renesas.com>

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/thermal/rcar_thermal.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 97462e9b40d8..11df0cc63bed 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -52,6 +52,7 @@ struct rcar_thermal_chip {
 	unsigned int irq_per_ch : 1;
 	unsigned int needs_suspend_resume : 1;
 	unsigned int nirqs;
+	unsigned int ctemp_bands;
 };
 
 static const struct rcar_thermal_chip rcar_thermal = {
@@ -60,6 +61,7 @@ static const struct rcar_thermal_chip rcar_thermal = {
 	.irq_per_ch = 0,
 	.needs_suspend_resume = 0,
 	.nirqs = 1,
+	.ctemp_bands = 1,
 };
 
 static const struct rcar_thermal_chip rcar_gen2_thermal = {
@@ -68,6 +70,7 @@ static const struct rcar_thermal_chip rcar_gen2_thermal = {
 	.irq_per_ch = 0,
 	.needs_suspend_resume = 0,
 	.nirqs = 1,
+	.ctemp_bands = 1,
 };
 
 static const struct rcar_thermal_chip rcar_gen3_thermal = {
@@ -80,6 +83,7 @@ static const struct rcar_thermal_chip rcar_gen3_thermal = {
 	 * interrupts to detect a temperature change, rise or fall.
 	 */
 	.nirqs = 2,
+	.ctemp_bands = 2,
 };
 
 struct rcar_thermal_priv {
@@ -263,7 +267,12 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
 		return ret;
 
 	mutex_lock(&priv->lock);
-	tmp =  MCELSIUS((priv->ctemp * 5) - 65);
+	if (priv->chip->ctemp_bands == 1)
+		tmp =  MCELSIUS((priv->ctemp * 5) - 65);
+	else if (priv->ctemp < 24)
+		tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
+	else
+		tmp = MCELSIUS((priv->ctemp * 5) - 60);
 	mutex_unlock(&priv->lock);
 
 	if ((tmp < MCELSIUS(-45)) || (tmp > MCELSIUS(125))) {
-- 
2.11.0

