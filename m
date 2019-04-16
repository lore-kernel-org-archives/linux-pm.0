Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8DEC10F14
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F552075B
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNexly5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfDPRog (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:44:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37790 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPRog (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 13:44:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so10691634pgc.4;
        Tue, 16 Apr 2019 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uXqJwGYbWPvLuqN2q64M5FrfdD3hYmhiNr9td7M0BAg=;
        b=tNexly5HdIEvp+ZfwKznG1et5SguN04ex8CB9WBcDz4/IhKEySo/meJEWbX1Vc9Q/7
         m9ckkoM7NajxEnQY/dODcxDxxRMS3/1jXhsXtzkRf/1XKxeVSqgLlLF1LqZIPyTL3mWC
         Q9NZ6aoS7ft0+d3Lgzveyb1Q4WYfF1Pi5sWse7I873NhCebaKm3fQFWmqqUFIkepaJD7
         A2BJ+nyg8F/Pym4J5RPUIR5lNkDQspvXXhfyarWsPmNRu8oPubp3PUuqiqWmTgJ/VrBJ
         8aXu4tsyH5v0SWpcuaovV4w8LZcvcMEtGvNtHjrAW4J153IvR1zxYs7C7LXm4XOU+dsX
         DhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uXqJwGYbWPvLuqN2q64M5FrfdD3hYmhiNr9td7M0BAg=;
        b=AciscVSIyQjNBAaPVFu/UyzhZHVHvVa2pGtsRcsLEn/q6vmORMFrzgy7W/yPfJ/+EH
         poUslPLVNGqvXIeY00sLSjhUKCfJup8cSxpexHRgGKRpr5V6JVM466nqsrv+WodOCo3v
         o15nU3RMTRvIkhn5yiPB0hiew6xrTBdfA8oIuk94gmC9YJ184W3rd4Ftwr5WRiziCsTp
         Dw/5Dhaf+WhGfDGLVWoYp2Wpv593db3PIYNbCTHOFovV5I1JsPC2FRrcnP/cYyxDG9UO
         Oh3NghUtChpUyId59p1mWmOMfO4tf7druVioSG3ngwFzjdn5zFhP7v6nWc/s7ybp81RB
         M3kA==
X-Gm-Message-State: APjAAAViBKl6Xsa2drHs2DDXnB5HameAhMp4aEBbwbts5rqM1l6f1OV/
        nH1zbHoxE+/8Gz0AnTws5hF6GTaV
X-Google-Smtp-Source: APXvYqyuuqIaedYQkb6OkOPf60Wj20j2wkX2XgoDjvvzoMQGy5HddxoIAYs1aMiaWvZxbsV9ijaG3Q==
X-Received: by 2002:a63:b48:: with SMTP id a8mr69383607pgl.368.1555436675738;
        Tue, 16 Apr 2019 10:44:35 -0700 (PDT)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp. [118.155.13.174])
        by smtp.gmail.com with ESMTPSA id f20sm39763791pff.176.2019.04.16.10.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 10:44:34 -0700 (PDT)
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT v2 2/3] thermal: rcar_gen3_thermal: Update calculation formula of IRQTEMP
Date:   Wed, 17 Apr 2019 02:44:14 +0900
Message-Id: <1555436655-5262-3-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
References: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the formula to calculate CTEMP:
Currently, the CTEMP is average of val1 (is calculated by
formula 1) and val2 (is calculated by formula 2). But,
as description in HWM (chapter 10A.3.1.1 Setting of Normal Mode)

If (STEMP < Tj_T) CTEMP value should be val1.
If (STEMP > Tj_T) CTEMP value should be val2.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index a2fd0fd..97cf3cd 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -77,6 +77,7 @@ struct rcar_gen3_thermal_tsc {
 	struct equation_coefs coef;
 	int low;
 	int high;
+	int tj_2;
 };
 
 struct rcar_gen3_thermal_priv {
@@ -126,28 +127,27 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 /* no idea where these constants come from */
 #define TJ_3 -41
 
-static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
+
+static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
 					 int *ptat, int *thcode,
 					 unsigned int ths_tj_1)
 {
-	int tj_2;
-
 	/* TODO: Find documentation and document constant calculation formula */
 
 	/*
 	 * Division is not scaled in BSP and if scaled it might overflow
 	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
 	 */
-	tj_2 = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
-		/ (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
+	tsc->tj_2 = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
+		     / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
 
-	coef->a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
-			     tj_2 - FIXPT_INT(TJ_3));
-	coef->b1 = FIXPT_INT(thcode[2]) - coef->a1 * TJ_3;
+	tsc->coef.a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
+				 tsc->tj_2 - FIXPT_INT(TJ_3));
+	tsc->coef.b1 = FIXPT_INT(thcode[2]) - tsc->coef.a1 * TJ_3;
 
-	coef->a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
-			     tj_2 - FIXPT_INT(ths_tj_1));
-	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * ths_tj_1;
+	tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
+				 tsc->tj_2 - FIXPT_INT(ths_tj_1));
+	tsc->coef.b2 = FIXPT_INT(thcode[0]) - tsc->coef.a2 * ths_tj_1;
 }
 
 static int rcar_gen3_thermal_round(int temp)
@@ -186,13 +186,15 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
 					      int mcelsius)
 {
-	int celsius, val1, val2;
+	int celsius, val;
 
 	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
-	val1 = celsius * tsc->coef.a1 + tsc->coef.b1;
-	val2 = celsius * tsc->coef.a2 + tsc->coef.b2;
+	if (celsius <= INT_FIXPT(tsc->tj_2))
+		val = celsius * tsc->coef.a1 + tsc->coef.b1;
+	else
+		val = celsius * tsc->coef.a2 + tsc->coef.b2;
 
-	return INT_FIXPT((val1 + val2) / 2);
+	return INT_FIXPT(val);
 }
 
 static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
@@ -440,7 +442,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		priv->tscs[i] = tsc;
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i],
+		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcode[i],
 					     *rcar_gen3_ths_tj_1);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
-- 
1.9.1

