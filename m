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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0DFC282DA
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03EB2087C
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzGS2NHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfDPRoe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:44:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40827 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPRoe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 13:44:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so10681774pgl.7;
        Tue, 16 Apr 2019 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jsbPM1PB6pp7nEXaKWf2/ssPsShBgfDSwohisCd8xh8=;
        b=pzGS2NHLrVrBBiLrA7ZA0HXqROoysmpFQOhhVcmN7jZ0EOPP4zZ0BIwfnwsaCKqmqB
         8moqkcY7Wzw63vJoK9ee+UUrHq51Kwyc6ivkRU1x54Iu+K+bPK19a7Ges3mcj0fMS7Rc
         /8upUBYfZmq2MirpaOhQZiOUbcnO4dQOeNp8TbDK8tcD1XsPBomAYzr81UW7c2FNwl+c
         POUIRJ830f/5cIc7qT8iM+UVMw+uki+tSBD45MnDSvJ98yykrLqzoYyW+nd4VhUSfd+L
         45mVRHZ+er5oZyRNh7I1VlAIyVcRYuJIQFdyT6kk6saK9BSOZBXiJi+iEOhzJEikYYtl
         1ICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jsbPM1PB6pp7nEXaKWf2/ssPsShBgfDSwohisCd8xh8=;
        b=j+oxMPfN9wVY9runH8CApFmT74q1iY8ouSGFWRthK01MjXsKKKLIn86HylQofIlAmf
         Y2qf1J6Og6jZKMheuELjpABEROVucbXOl0E7YzgX8KvyPbSuvVcBKnLKCqxd2X0jr3ej
         MFOPnZVBFIqiHiXLsJhUu7gRSJyVsTxmDqNTHZ5B20h+AhwJwZ/mCfFhGAcA+lqusU/z
         xaKIiyOe9TWRsTxqgmIsLQZgrT4/P+vFQMkodNy5TKVxgh1RPIBS2lZClZkNYMLxZS8y
         kbfFZp2w0nnA35LGagPD2uxDGUY1a/e6N6q4e7rYQ4tyUzySp1KbFQTHtGKlygvMTv5n
         A4wQ==
X-Gm-Message-State: APjAAAU+ENDKMWJ/gi9BwDPVQQRd46zTK3o83PD+3K9rPNJNBnDPzOKr
        wRJSyWOSJho4e7iYQsYWeSZtO6nA
X-Google-Smtp-Source: APXvYqzAtcxJ+4tOmt2aIYIaIP07OGFMS6Q1FNLWGap7qok+ner47haamRUOqonhnhGzr24fZ+UHcw==
X-Received: by 2002:a62:69c2:: with SMTP id e185mr83456661pfc.119.1555436673141;
        Tue, 16 Apr 2019 10:44:33 -0700 (PDT)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp. [118.155.13.174])
        by smtp.gmail.com with ESMTPSA id f20sm39763791pff.176.2019.04.16.10.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 10:44:32 -0700 (PDT)
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT v2 1/3] thermal: rcar_gen3_thermal: Update value of Tj_1
Date:   Wed, 17 Apr 2019 02:44:13 +0900
Message-Id: <1555436655-5262-2-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
References: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As evaluation of hardware team, temperature calculation formula
of M3-W is difference from all other SoCs as below:
- M3-W: Tj_1: 116 (so Tj_1 - Tj_3 = 157)
- Others: Tj_1: 126 (so Tj_1 - Tj_3 = 167)

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 41 +++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 88fa41c..a2fd0fd 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -124,11 +124,11 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
 
 /* no idea where these constants come from */
-#define TJ_1 116
 #define TJ_3 -41
 
 static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
-					 int *ptat, int *thcode)
+					 int *ptat, int *thcode,
+					 unsigned int ths_tj_1)
 {
 	int tj_2;
 
@@ -139,15 +139,15 @@ static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
 	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
 	 */
 	tj_2 = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
-		/ (ptat[0] - ptat[2])) - FIXPT_INT(41);
+		/ (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
 
 	coef->a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
 			     tj_2 - FIXPT_INT(TJ_3));
 	coef->b1 = FIXPT_INT(thcode[2]) - coef->a1 * TJ_3;
 
 	coef->a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
-			     tj_2 - FIXPT_INT(TJ_1));
-	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * TJ_1;
+			     tj_2 - FIXPT_INT(ths_tj_1));
+	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * ths_tj_1;
 }
 
 static int rcar_gen3_thermal_round(int temp)
@@ -318,12 +318,29 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 	usleep_range(1000, 2000);
 }
 
+static const unsigned int rcar_gen3_ths_tj_1 = 126;
+static const unsigned int rcar_gen3_ths_tj_1_m3_w = 116;
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
-	{ .compatible = "renesas,r8a774a1-thermal", },
-	{ .compatible = "renesas,r8a7795-thermal", },
-	{ .compatible = "renesas,r8a7796-thermal", },
-	{ .compatible = "renesas,r8a77965-thermal", },
-	{ .compatible = "renesas,r8a77980-thermal", },
+	{
+		.compatible = "renesas,r8a774a1-thermal",
+		.data = &rcar_gen3_ths_tj_1_m3_w,
+	},
+	{
+		.compatible = "renesas,r8a7795-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
+	{
+		.compatible = "renesas,r8a7796-thermal",
+		.data = &rcar_gen3_ths_tj_1_m3_w,
+	},
+	{
+		.compatible = "renesas,r8a77965-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
+	{
+		.compatible = "renesas,r8a77980-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
@@ -349,6 +366,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 {
 	struct rcar_gen3_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
+	const unsigned int *rcar_gen3_ths_tj_1 = of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
 	int ret, irq, i;
@@ -422,7 +440,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		priv->tscs[i] = tsc;
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i]);
+		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i],
+					     *rcar_gen3_ths_tj_1);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
-- 
1.9.1

