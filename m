Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC01C56201
	for <linux-pm@archiver.kernel.org>; Thu, 12 Nov 2020 10:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FF422227
	for <linux-pm@archiver.kernel.org>; Thu, 12 Nov 2020 10:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYPx0tv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgKLKki (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 12 Nov 2020 05:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgKLKke (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 05:40:34 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D912C0613D4;
        Thu, 12 Nov 2020 02:40:34 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so4127921pfb.10;
        Thu, 12 Nov 2020 02:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qvf5AIpXJgqzY8DsXinh6oVuEtLC89N/j7eeRIAQsYI=;
        b=WYPx0tv4IqBfoB6hq/h2N4Uajcn+oh92wnAaRlZLVyOe4JDjRHNFvAlNEGAH+lUDoT
         Uzk6jEKAkZamgzL5PzhO/u08Xv6PHtEI3w476txDvv4zSLm5VlHoBzEtfDR+xUnJdLPu
         N6s6nSnU/oQupTOsbQ0X8N/FDubL0FzCDdDuhv6IWg/e0c4qNbbnGEAKBkdLuT4fSTty
         eOUj3CaME5l5Cn1cwRwAGknuGIl5ZicjZQfZGqmbUTr79EJDFuCO3zy1GJhyQlr/SUHe
         7L5jRGEK0XU0BzG6YL/KoO7ot6FgXapZa95T+xKOZNc3cSG+JJvH3gJpYnJ4vBS/cr89
         SNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qvf5AIpXJgqzY8DsXinh6oVuEtLC89N/j7eeRIAQsYI=;
        b=GbmVQctWhlbzs+uqGcVmY3zvxI1uFtxR0q2WbQzSNA5HUlw4MdetpEVm9N2lv2Adun
         HqBcCm7Wr7Ij5vepvqdVubNbShErx8NOvcgWvDjNGvIr0kfl0IZVlZBYe+Zdn1iQqm/e
         XEsSkxWA3jJIMfaTMMVAIuVA7EEhZY01UNUDJueY8ee30aRIu7tGzubJIFCE3QBtsQ8p
         zyEjz0VwE9tnjvZ8Y0y2bOdlHfynfAInBbSt+sy+ZfeKv8/eCASVbEvIjp6P6lZkgJyw
         xBozdhF452bNMtPX0XjPTiTaF85IFKhZ2/zGc3S/lfMLy53r+3VORqP5d6/g/B/iy7K+
         v2gg==
X-Gm-Message-State: AOAM5332r1kAdm4nfxW74mlgnZRZ0yTNHANgjWjW9H1Y7buF5pLiLcyV
        NCHBFD3bpO61UwLZfbxyr5Y=
X-Google-Smtp-Source: ABdhPJyyWVlHB+a2NshHyH/uS3Y/rLp30ezfS6MrZrvU1ScHUOqwdLKBr24cY5G+pZU+cJpykerNuA==
X-Received: by 2002:a17:90a:178b:: with SMTP id q11mr6688456pja.132.1605177634194;
        Thu, 12 Nov 2020 02:40:34 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:47a:a27:cf8e:7817:51df:a883])
        by smtp.gmail.com with ESMTPSA id mp16sm6414094pjb.13.2020.11.12.02.40.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 02:40:33 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v7 08/11] mfd: mt6360: Fix flow which is used to check ic exist
Date:   Thu, 12 Nov 2020 18:39:55 +0800
Message-Id: <1605177598-23501-9-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Fix flow which is used to check ic exist.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 2356d99..de002fe 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -293,6 +293,25 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
+static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
+{
+	u32 info;
+	int ret;
+
+	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &info);
+	if (ret < 0)
+		return ret;
+
+	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
+		dev_err(ddata->dev, "Device not supported\n");
+		return -ENODEV;
+	}
+
+	ddata->chip_rev = info & CHIP_REV_MASK;
+
+	return 0;
+}
+
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 	MT6360_PMU_SLAVEID,
 	MT6360_PMIC_SLAVEID,
@@ -303,7 +322,6 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 static int mt6360_probe(struct i2c_client *client)
 {
 	struct mt6360_ddata *ddata;
-	unsigned int reg_data;
 	int i, ret;
 
 	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
@@ -319,17 +337,9 @@ static int mt6360_probe(struct i2c_client *client)
 		return PTR_ERR(ddata->regmap);
 	}
 
-	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &reg_data);
-	if (ret) {
-		dev_err(&client->dev, "Device not found\n");
+	ret = mt6360_check_vendor_info(ddata);
+	if (ret)
 		return ret;
-	}
-
-	ddata->chip_rev = reg_data & CHIP_REV_MASK;
-	if (ddata->chip_rev != CHIP_VEN_MT6360) {
-		dev_err(&client->dev, "Device not supported\n");
-		return -ENODEV;
-	}
 
 	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
 				       0, 0, &mt6360_irq_chip,
-- 
2.7.4

