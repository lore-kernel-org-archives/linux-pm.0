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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFFCC282DA
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CB52075B
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFyhsuGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfDPRoj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:44:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44112 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfDPRoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 13:44:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so10743179pfm.11;
        Tue, 16 Apr 2019 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/u94BtNlhqIi/IfQiSta23HVk4c4bD4ErFZeKAzdc0g=;
        b=lFyhsuGV41/RhIhbwDHFY3aRRnojfdWbgskHeyfOa/qH/xmE1KmanKE/jT7oiBM3q9
         nX2CDWWGwujipPACwv/vkm0WxPJFq2DqYZt56bKD8DUgB06kDXhymokKpGtaQXWhuPEW
         VAj1UJt9zfmbyT818qF0ww5ukFHYw149BjU77my8IBDXTkmONBfrD67Nxn6rWbjEMKVd
         SafIJsSZf9go/cnDJoT4Y9uvXIGElgbsf1/Vraf2dT/T1/62PdT0kTd38UVFgikyJuwE
         Qhw+pI/j65kEiqUi1sCGFrfIE0zYg+iY7ONh1DcbGzAOSOVjFu0IdQxDBXrh3rCcdmvj
         FQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/u94BtNlhqIi/IfQiSta23HVk4c4bD4ErFZeKAzdc0g=;
        b=jPyNosaG4UyQxY69d3+Og6UVEXJZ3btxVd6jrZ1orgCCtmd6tNM1njM7LRX6vbs7gk
         wwc/lKkWPZ4z86KN0jkaVDhZbe05ec3+6uNI1EHYRXa3fzT2qXBglZmmkdNXWXUyA66D
         PicfEQrHgY3I1Oc9AA0wxjhFhMS+fBwPBDtF63UtWK+FVVjBp90Yyi8e1x66pHFIRvqe
         w1avxDhiw3IAA/3l65T7HZ1C3LQFg7glRAKu6X6JKpkc8PayDzyaVC1yTQ1OQ+4fFiGa
         wpgOeGtCFMxhcPN7BWIf4TdXs6P4riltHqlJNwdgd6fuPvqzCAMLsC3ZMBdGKqPoXMtz
         t7zQ==
X-Gm-Message-State: APjAAAVRWKUl+Dpcw/qh993J8mijOzbB4gCWttr7jXzOlkdXXtcpeKeR
        ZhcPEQYeebwvzRYxFCu2YD/aV5ig
X-Google-Smtp-Source: APXvYqye2Th6RRXevYuCBagjjx9jIetRVgGwvP0WbrD4TuLXC3tM/nRrKxqgb+lReAUpFL2w73u47Q==
X-Received: by 2002:a63:fc5a:: with SMTP id r26mr74341625pgk.97.1555436678241;
        Tue, 16 Apr 2019 10:44:38 -0700 (PDT)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp. [118.155.13.174])
        by smtp.gmail.com with ESMTPSA id f20sm39763791pff.176.2019.04.16.10.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 10:44:37 -0700 (PDT)
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT v2 3/3] thermal: rcar_gen3_thermal: Update temperature conversion method
Date:   Wed, 17 Apr 2019 02:44:15 +0900
Message-Id: <1555436655-5262-4-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
References: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the formula to calculate temperature:
Currently, current TEMP is calculated as
average of val1 (is calculated by formula 1)
and val2 (is calculated by formula 2). But,
as description in HWM (chapter 10A.3.1.2 Normal Mode.)

If (TEMP_CODE < THCODE2[11:0]) CTEMP value should be val1.
If (TEMP_CODE > THCODE2[11:0]) CTEMP value should be val2.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 97cf3cd..9b95263 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -63,6 +63,13 @@
 
 #define TSC_MAX_NUM	3
 
+/* default THCODE values if FUSEs are missing */
+static const int thcode[TSC_MAX_NUM][3] = {
+	{ 3397, 2800, 2221 },
+	{ 3393, 2795, 2216 },
+	{ 3389, 2805, 2237 },
+};
+
 /* Structure for thermal temperature calculation */
 struct equation_coefs {
 	int a1;
@@ -78,6 +85,7 @@ struct rcar_gen3_thermal_tsc {
 	int low;
 	int high;
 	int tj_2;
+	int id; /* thermal channel id */
 };
 
 struct rcar_gen3_thermal_priv {
@@ -129,7 +137,7 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 
 
 static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
-					 int *ptat, int *thcode,
+					 int *ptat, const int *thcode,
 					 unsigned int ths_tj_1)
 {
 	/* TODO: Find documentation and document constant calculation formula */
@@ -163,15 +171,19 @@ static int rcar_gen3_thermal_round(int temp)
 static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 {
 	struct rcar_gen3_thermal_tsc *tsc = devdata;
-	int mcelsius, val1, val2;
+	int mcelsius, val;
 	u32 reg;
 
 	/* Read register and convert to mili Celsius */
 	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
 
-	val1 = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1, tsc->coef.a1);
-	val2 = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2, tsc->coef.a2);
-	mcelsius = FIXPT_TO_MCELSIUS((val1 + val2) / 2);
+	if (reg <= thcode[tsc->id][1])
+		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
+				tsc->coef.a1);
+	else
+		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
+				tsc->coef.a2);
+	mcelsius = FIXPT_TO_MCELSIUS(val);
 
 	/* Make sure we are inside specifications */
 	if ((mcelsius < MCELSIUS(-40)) || (mcelsius > MCELSIUS(125)))
@@ -377,11 +389,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	/* default values if FUSEs are missing */
 	/* TODO: Read values from hardware on supported platforms */
 	int ptat[3] = { 2631, 1509, 435 };
-	int thcode[TSC_MAX_NUM][3] = {
-		{ 3397, 2800, 2221 },
-		{ 3393, 2795, 2216 },
-		{ 3389, 2805, 2237 },
-	};
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -438,6 +445,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			ret = PTR_ERR(tsc->base);
 			goto error_unregister;
 		}
+		tsc->id = i;
 
 		priv->tscs[i] = tsc;
 
-- 
1.9.1

